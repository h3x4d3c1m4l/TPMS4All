// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:uuid/uuid.dart';

/// Simple abstraction for Bluetooth operations.
/// 
/// As currently supported TPMS sensors don't use any kind of pairing or connection, but just broadcast
/// sensor measurements, this abstraction currently just allows to scan.
abstract class BluetoothHal {
  Stream<BleDevice> scanForDevices({
    required IList<UuidValue> withServices,
    BleScanMode scanMode = BleScanMode.balanced,
  });
}
