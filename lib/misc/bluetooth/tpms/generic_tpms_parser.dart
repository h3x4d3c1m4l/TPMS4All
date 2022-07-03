// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:universal_tpms_reader/misc/bluetooth/tpms/tpms_message_parser.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:uuid/uuid.dart';

// Supports TPMS that's currently supported by com.po.tyrecheck2020.new
class GenericTpmsParser extends TpmsMessageParser {
  @override
  IList<UuidValue> get bleServiceIds => [UuidValue('0000fbb0-0000-1000-8000-00805f9b34fb')].lock;

  const GenericTpmsParser();

  @override
  SensorData? parse(BleDevice device) {
    // data starts at the company ID (or at least that's what Wireshark calls it)
    if (device.vendorData.length != 18 ||
        device.vendorData[0] != 0x00 ||
        device.vendorData[1] != 0x01) return null;

    final ByteData byteData = device.vendorData.buffer.asByteData();

    return SensorData(
      btAddress: device.btAddress,
      serial: _getSerialFromBluetoothName(device.name) ?? _getSerialFromVendorData(device.vendorData),
      lastSeen: DateTime.now(),
      vendorName: 'Generic',
      productName: _getProductNameFromBluetoothName(device.name),
      suggestsLocationOnVehicle: _getSuggestedTireLocation(device.vendorData[2]),
      tirePressureKPa: byteData.getInt32(8, Endian.little).toDouble() / 1000,
      temperatureCelcius: byteData.getInt32(12, Endian.little).toDouble() / 100,
      batteryPercentage: byteData.getInt8(16).toDouble(),
      leakDetected: byteData.getInt8(17) == 1,
    );
  }

  static TireLocation? _getSuggestedTireLocation(int locationByte) {
    switch (locationByte) {
      case 0x80:
        return TireLocation.frontLeft;
      case 0x81:
        return TireLocation.frontRight;
      case 0x82:
        return TireLocation.rearLeft;
      case 0x83:
        return TireLocation.rearRight;
    }
    return null;
  }

  static String _getProductNameFromBluetoothName(String name) {
    // e.g. TPMS2_1A2B3C
    switch (name.substring(0, 5)) {
      case 'TPMS1':
        return 'TPMS 1';
      case 'TPMS2':
        return 'TPMS 2';
      case 'TPMS3':
        return 'TPMS 3';
      case 'TPMS4':
        return 'TPMS 4';
    }
    return name;
  }

  static String? _getSerialFromBluetoothName(String name) {
    // e.g. TPMS2_1A2B3C
    final List<String> split = name.split('_');
    if (split.length == 2 && split[1].length == 6) {
      return split[1];
    }
    return null;
  }

  static String _getSerialFromVendorData(Uint8List vendorData) {
    return hex.encode(vendorData.sublist(2, 8));
  }
}
