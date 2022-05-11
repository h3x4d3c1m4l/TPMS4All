// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_tpms_reader/misc/bluetooth/hardware_abstraction_layer/_all.dart';
import 'package:universal_tpms_reader/misc/bluetooth/tpms/_all.dart';
import 'package:universal_tpms_reader/misc/extensions/ilist_extension.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:uuid/uuid.dart';
import 'package:wakelock/wakelock.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';
part 'bluetooth_bloc.freezed.dart';

/// BLoC that manages Bluetooth scanning, parsing sensor data and storing any found TPMS sensors (in memory).
///
/// Note: Persistence of any sensor data is managed by VehicleManagerBloc.
class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  static final IList<UuidValue> _bleServiceIds = TpmsMessageParser.allParsers.expand((p) => p.bleServiceIds).toIList();
  late final BluetoothHal _bluetooth;
  DateTime? _scanStarted;
  Completer<bool>? _scanCancelCompleter;
  Completer<void>? _scanFinishedCompleter;

  BluetoothBloc() : super(BluetoothState.defaultState()) {
    on<InitializeRequest>(_onInitializeRequest);
    on<RequestPermissionsRequest>(_onRequestPermissionsRequest);
    on<SetScanModeRequest>(_onSetScanModeRequest);
    on<CancelScanRequest>(_onCancelScanRequest);
  }

  FutureOr<void> _onInitializeRequest(InitializeRequest event, Emitter<BluetoothState> emit) async {
    emit(state.copyWith(permissionStatusIsBeingUpdated: true));

    _bluetooth = ReactiveBle(); // hardware implementation, seems very stable
    //_bluetooth = FakeBle(); // send fake BLE reports (but data is actually in the same format as real sensors)
    //_bluetooth = QuickBlueBle(); // hardware implementation, but not stable yet

    // permissions are slightly different per platform and not applicable to desktop platforms
    if (Platform.isAndroid) {
      // Android
      emit(state.copyWith(
        permissionForLocation: await Permission.locationWhenInUse.status,
        permissionForBluetooth: await Permission.bluetoothScan.status,
        permissionStatusIsBeingUpdated: false,
        isInitialized: true,
      ));
    } else if (Platform.isIOS) {
      // iOS/iPadOS
      emit(state.copyWith(
        permissionForLocation: await Permission.location.status,
        permissionForBluetooth: await Permission.bluetooth.status,
        permissionStatusIsBeingUpdated: false,
        isInitialized: true,
      ));
    }
  }

  FutureOr<void> _onRequestPermissionsRequest(RequestPermissionsRequest event, Emitter<BluetoothState> emit) async {
    emit(state.copyWith(permissionStatusIsBeingUpdated: true));

    // permissions are slightly different per platform and not applicable to desktop platforms
    if (Platform.isAndroid) {
      // Android
      await _requestPermissionsAndroid(emit);
    } else if (Platform.isIOS) {
      // iOS/iPadOS
      await _requestPermissionsIOS(emit);
    }

    emit(state.copyWith(permissionStatusIsBeingUpdated: false));
  }

  Future<void> _requestPermissionsAndroid(Emitter<BluetoothState> emit) async {
    PermissionStatus location, bluetooth;

    final AndroidDeviceInfo deviceInfo = GetIt.I.get<BaseDeviceInfo>() as AndroidDeviceInfo;
    if (deviceInfo.version.sdkInt! < 31) {
      // <= Android 11
      location = await Permission.locationWhenInUse.request();
      bluetooth = await Permission.bluetooth.request();
    } else {
      // >= Android 12
      location = PermissionStatus.granted; // should not be needed (see AndroidManifest.xml)
      bluetooth = await Permission.bluetoothScan.request();
    }

    emit(state.copyWith(
      permissionForLocation: location,
      permissionForBluetooth: bluetooth,
    ));
  }

  Future<void> _requestPermissionsIOS(Emitter<BluetoothState> emit) async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    emit(state.copyWith(
      permissionForLocation: statuses[Permission.location],
      permissionForBluetooth: statuses[Permission.bluetooth],
      permissionStatusIsBeingUpdated: false,
    ));
  }

  /// This is more complicated than I wanted to have it, but it turned out Android throttles your Bluetooth searches
  /// (it will downgrade your search to 'opportunistic' if you start/stop search too often). This function takes that
  /// into account and automatically does the thottling to prevent the scan downgrade from occuring.
  ///
  /// Could Have 1: Accurately implement throttle (max 5 times start/stop of scan) instead of throttling every scan
  /// Could Have 2: Turn throttling off for iOS/iPadOS
  FutureOr<void> _onSetScanModeRequest(SetScanModeRequest event, Emitter<BluetoothState> emit) async {
    try {
      // cancel previous scan and await it's completion
      _scanCancelCompleter?.complete(false);
      await _scanFinishedCompleter?.future;
      _scanCancelCompleter = Completer<bool>();
      _scanFinishedCompleter = Completer<void>();

      // if low latency scan: enable wakelock and workaround undocumented scan throttle on Android 7+
      if (event.scanMode == BleScanMode.lowLatency) {
        await Wakelock.enable();
      }

      // emit state that shows throttling
      emit(state.copyWith(
        scanState: BluetoothScanState.throttling,
      ));

      // check if 30 seconds have passed, otherwise simply wait
      if (_scanStarted != null) {
        final DateTime dontStartBefore = _scanStarted!.add(const Duration(seconds: 30));
        if (DateTime.now().isBefore(dontStartBefore)) {
          final bool cancelScan = await Future.any([
            Future.delayed(dontStartBefore.difference(DateTime.now()), () => false),
            _scanCancelCompleter!.future.then((_) => true),
          ]);

          if (cancelScan) {
            // scan was already cancelled in favor of new scan
            return;
          }
        }
      }

      // signal start of scan
      emit(state.copyWith(
        scanState: BluetoothScanState.scanning,
        scanMode: event.scanMode,
        scanDuration: event.duration,
        scanStart: DateTime.now(),
        foundSensors: event.storeSeenSensors ? const IListConst<SensorInfo>([]) : state.foundSensors,
      ));

      _scanStarted = DateTime.now();

      // actually start scan
      final Stream<BleDevice> deviceStream =
          _bluetooth.scanForDevices(withServices: _bleServiceIds, scanMode: event.scanMode);
      final StreamSubscription<BleDevice> btDeviceStreamSub = deviceStream.listen((device) {
        // convert raw device info to actual SensorInfo
        for (final TpmsMessageParser parser in TpmsMessageParser.allParsers) {
          final SensorInfo? sensorInfo = parser.parse(device);
          if (sensorInfo != null) {
            // update or insert sensor data
            emit(state.copyWith(
              lastSeenSensor: sensorInfo,
              foundSensors: event.storeSeenSensors
                  ? state.foundSensors.upsert((r) => r.btAddress.deepEquals(sensorInfo.btAddress), sensorInfo)
                  : state.foundSensors,
              // ^ == operator won't compare Int8List's contents
            ));
          }
        }
      });

      // check if we should start a new scan after this scan
      final bool shouldStartForegroundScan = await Future.any([
        _scanCancelCompleter!.future, // manual cancellation
        if (event.duration != null) Future.delayed(event.duration!, () => true), // cancellation due to timeout
      ]);

      // abort scan and disable wakelock
      await btDeviceStreamSub.cancel();
      await Wakelock.disable();

      emit(state.copyWith(
        scanState: BluetoothScanState.idle,
        scanMode: null,
        scanDuration: null,
        scanStart: null,
      ));

      if (shouldStartForegroundScan) {
        add(BluetoothEvent.requestForegroundScan());
      }
    } finally {
      // make sure the next scan will be able to run
      _scanFinishedCompleter!.complete();
    }
  }

  FutureOr<void> _onCancelScanRequest(CancelScanRequest event, Emitter<BluetoothState> emit) {
    _scanCancelCompleter?.complete(true);
    _scanCancelCompleter = null;
  }
}
