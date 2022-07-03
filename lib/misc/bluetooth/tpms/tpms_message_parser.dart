// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:universal_tpms_reader/misc/bluetooth/tpms/_all.dart';
import 'package:universal_tpms_reader/models/application/ble_device.dart';
import 'package:universal_tpms_reader/models/application/sensor_data.dart';
import 'package:uuid/uuid.dart';

abstract class TpmsMessageParser {
  IList<UuidValue> get bleServiceIds;
  static final IList<TpmsMessageParser> allParsers = [
    const GenericTpmsParser(),
  ].lock;

  const TpmsMessageParser();

  SensorData? parse(BleDevice device);
}
