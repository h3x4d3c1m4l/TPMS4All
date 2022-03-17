// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

// ignore_for_file: unused_local_variable, avoid_print, unused_element

import 'dart:typed_data';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:quick_blue/quick_blue.dart';
import 'package:universal_tpms_reader/misc/bluetooth/hardware_abstraction_layer/_all.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:convert/convert.dart';

/// This is a Bluetooth Low Energy implementation based on quick_blue.
/// TODO: implement correct splitting of manufacturer data and device filtering by BLE service ID and LOTS of testing.
class QuickBlueBle implements BluetoothHal {
  late FlutterReactiveBle _flutterReactiveBle;

  QuickBlueBle() {
    _flutterReactiveBle = FlutterReactiveBle();
    _flutterReactiveBle.initialize();
  }

  @override
  Stream<BleDevice> scanForDevices({
    required IList<uuid.UuidValue> withServices,
    BleScanMode scanMode = BleScanMode.balanced,
  }) async* {
    List<Uuid> servicesView = withServices.map((s) => Uuid.parse(s.uuid)).toIList().unlockView;

    QuickBlue.startScan();
    List<String> seenDeviceIds = [];
    yield* QuickBlue.scanResultStream.where((device) {
      if (!seenDeviceIds.contains(device.deviceId)) {
        seenDeviceIds.add(device.deviceId);

        // see: https://github.com/woodemi/quick_blue/issues/75
        ByteData btAddressData = ByteData(8)..setUint64(0, int.parse(device.deviceId));
        print(device.name.isEmpty ? "<EMPTY>" : device.name);
        print(hex.encode(btAddressData.buffer.asUint8List(2, 6)));
        print(hex.encode(device.manufacturerDataHead));
        print(hex.encode(device.manufacturerData));
      }
      return true;
    }).map(
      (device) => BleDevice(
        btAddress: Uint8List.fromList([]),
        name: device.name,
        vendorData: device.manufacturerData,
      ),
    );
    QuickBlue.stopScan(); // TODO: does this work?
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
