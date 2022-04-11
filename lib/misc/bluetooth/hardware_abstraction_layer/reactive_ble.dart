// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:universal_tpms_reader/misc/bluetooth/hardware_abstraction_layer/_all.dart';
import 'package:universal_tpms_reader/misc/definitions.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:uuid/uuid.dart' as uuid;

/// This is a Bluetooth Low Energy implementation based on flutter_reactive_ble.
/// Currently only this Bluetooth implementation is fully supported.
class ReactiveBle implements BluetoothHal {
  late FlutterReactiveBle _flutterReactiveBle;

  ReactiveBle() {
    _flutterReactiveBle = FlutterReactiveBle();
    _flutterReactiveBle.initialize();
  }

  @override
  Stream<BleDevice> scanForDevices({
    required IList<uuid.UuidValue> withServices,
    BleScanMode scanMode = BleScanMode.balanced,
  }) async* {
    final List<Uuid> servicesView = withServices.map((s) => Uuid.parse(s.uuid)).toIList().unlockView;

    yield* _flutterReactiveBle
        .scanForDevices(
          withServices: servicesView,
          scanMode: _getScanModeFromBleScanMode(scanMode),
        )
        .map(
          (device) => BleDevice(
            btAddress: hexToUint8List(device.id.replaceAll(':', '')),
            name: device.name,
            vendorData: device.manufacturerData,
          ),
        );
  }

  static ScanMode _getScanModeFromBleScanMode(BleScanMode scanType) {
    switch (scanType) {
      case BleScanMode.opportunistic:
        return ScanMode.opportunistic;
      case BleScanMode.lowPower:
        return ScanMode.lowPower;
      case BleScanMode.balanced:
        return ScanMode.balanced;
      case BleScanMode.lowLatency:
        return ScanMode.lowLatency;
    }
  }
}
