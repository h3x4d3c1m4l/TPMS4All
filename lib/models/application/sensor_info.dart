// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';

part 'sensor_info.freezed.dart';

@freezed
class SensorInfo with _$SensorInfo {
  const SensorInfo._();
  const factory SensorInfo({
    required Uint8List btAddress,
    required String serial,
    required DateTime lastSeen,
    required String vendorName,
    required String productName,
    TireLocation? suggestsLocationOnVehicle,
    required double tirePressureKPa,
    double? temperatureCelcius,
    double? batteryPercentage,
    bool? leakDetected,
  }) = _SensorInfo;
}