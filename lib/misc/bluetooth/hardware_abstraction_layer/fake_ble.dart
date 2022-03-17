// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';
import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:universal_tpms_reader/misc/bluetooth/hardware_abstraction_layer/_all.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';

/// This is a fake Bluetooth Low Energy implementation used for testing whenever no sensors are in range, or when
/// debugging on an emulator.
class FakeBle implements BluetoothHal {
  static const Duration _interval = Duration(milliseconds: 50);
  static final IList<BleDevice> _fakeDevices = IList([
    BleDevice(
      btAddress: Uint8List.fromList([0x80, 0x12, 0x34, 0x13, 0x37, 0xAA]),
      name: "TPMS1_1337AA",
      vendorData: Uint8List.fromList(
          [0x00, 0x01, 0x80, 0xEA, 0xCA, 0x40, 0x09, 0xAD, 0x55, 0x47, 0x03, 0x00, 0xB0, 0x03, 0x00, 0x00, 0x10, 0x00]),
    ),
    BleDevice(
      btAddress: Uint8List.fromList([0x81, 0x12, 0x34, 0x13, 0x37, 0xBB]),
      name: "TPMS2_1337BB",
      vendorData: Uint8List.fromList(
          [0x00, 0x01, 0x81, 0xEA, 0xCA, 0x40, 0x09, 0xAD, 0x55, 0x47, 0x03, 0x00, 0xB0, 0x03, 0x00, 0x00, 0x10, 0x00]),
    ),
    BleDevice(
      btAddress: Uint8List.fromList([0x82, 0x12, 0x34, 0x13, 0x37, 0xCC]),
      name: "TPMS3_1337CC",
      vendorData: Uint8List.fromList(
          [0x00, 0x01, 0x82, 0xEA, 0xCA, 0x40, 0x09, 0xAD, 0x55, 0x47, 0x03, 0x00, 0xB0, 0x03, 0x00, 0x00, 0x10, 0x00]),
    ),
    BleDevice(
      btAddress: Uint8List.fromList([0x83, 0x12, 0x34, 0x13, 0x37, 0xDD]),
      name: "TPMS4_1337DD",
      vendorData: Uint8List.fromList(
          [0x00, 0x01, 0x83, 0xEA, 0xCA, 0x40, 0x09, 0xAD, 0x55, 0x47, 0x03, 0x00, 0xB0, 0x03, 0x00, 0x00, 0x10, 0x00]),
    ),
    BleDevice(
        btAddress: Uint8List.fromList([0x80, 0x12, 0x34, 0x13, 0x37, 0xEE]),
        name: "I am random!",
        vendorData: Uint8List.fromList([1, 2, 3, 4])),
  ]);

  @override
  Stream<BleDevice> scanForDevices({
    required IList<uuid.UuidValue> withServices,
    BleScanMode scanMode = BleScanMode.balanced,
  }) async* {
    await Future.delayed(const Duration(seconds: 1));
    yield* Stream<BleDevice>.periodic(_interval, (_) => _getRandomBleDevice());
  }

  BleDevice _getRandomBleDevice() {
    int index = Random().nextInt(_fakeDevices.length - 1);
    return _fakeDevices[index];
  }
}
