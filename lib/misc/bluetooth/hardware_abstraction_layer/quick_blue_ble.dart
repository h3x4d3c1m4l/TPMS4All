// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

// ignore_for_file: unused_local_variable, avoid_print, unused_element

import 'dart:typed_data';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:quick_blue/quick_blue.dart';
import 'package:universal_tpms_reader/misc/bluetooth/hardware_abstraction_layer/_all.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:uuid/uuid.dart' as uuid;

/// This is a Bluetooth Low Energy implementation based on quick_blue.
/// TODO: implement correct splitting of manufacturer data and device filtering by BLE service ID and LOTS of testing.
class QuickBlueBle implements BluetoothHal {
  @override
  Stream<BleDevice> scanForDevices({
    required IList<uuid.UuidValue> withServices,
    BleScanMode scanMode = BleScanMode.balanced,
  }) async* {
    QuickBlue.startScan();

    yield* QuickBlue.scanResultStream.where((device) {
      if (device.name.startsWith('TPMS')) {
        return true;
      }
      return false;
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
