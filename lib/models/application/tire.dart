// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:uuid/uuid.dart';

part 'tire.freezed.dart';

@freezed
class Tire with _$Tire {
  static const Duration _availabilityTimeout = Duration(minutes: 15);

  const factory Tire({
    required UuidValue uuid,
  
    required TireLocation locationOnVehicle,

    Uint8List? sensorBtAddress,
    String? sensorSerial,
    String? sensorVendorName,
    String? sensorProductName,
    DateTime? sensorLastSeen,
    required bool sensorAutoPair,

    double? lastTirePressureKPa,
    double? lastTemperatureCelcius,
    double? lastBatteryPercentage,
    bool? lastLeakDetected,

    double? nominalTirePressureKPa,
    double? warnAtTirePressureKPa,
    double? criticalAtTirePressureKPa,
    double? warnAtTemperatureCelcius,
    double? criticalAtTemperatureCelcius,
  }) = _Tire;
  const Tire._();

  // unconfigured / waiting for sensor
  bool get isUnconfigured => sensorSerial == null;
  bool get sensorUnavailable =>
      sensorLastSeen == null || sensorLastSeen!.isBefore(DateTime.now().subtract(_availabilityTimeout));

  // warning
  bool get temperatureWarning =>
      lastTemperatureCelcius != null &&
      warnAtTemperatureCelcius != null &&
      lastTemperatureCelcius! > warnAtTemperatureCelcius!;
  bool get tirePressureWarning =>
      lastTirePressureKPa != null && warnAtTirePressureKPa != null && lastTirePressureKPa! < warnAtTirePressureKPa!;
  bool get warning => !isUnconfigured && (sensorLastSeen == null || temperatureWarning || tirePressureWarning);

  // critical
  bool get temperatureIsCritical =>
      lastTemperatureCelcius != null &&
      criticalAtTemperatureCelcius != null &&
      lastTemperatureCelcius! > criticalAtTemperatureCelcius!;
  bool get tirePressureIsCritical =>
      lastTirePressureKPa != null &&
      criticalAtTirePressureKPa != null &&
      lastTirePressureKPa! < criticalAtTirePressureKPa!;
  bool get critical => !isUnconfigured && (temperatureIsCritical || tirePressureIsCritical || lastLeakDetected == true);

  // battery warning/critical
  bool get batteryWarning => lastBatteryPercentage != null && lastBatteryPercentage! < 30;
  bool get batteryCritical => lastBatteryPercentage != null && lastBatteryPercentage! < 20;
}
