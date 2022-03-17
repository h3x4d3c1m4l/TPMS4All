// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:uuid/uuid.dart';

part 'db_tire.g.dart';

@Collection(accessor: 'tire')
class DbTire {
  int? id;
  @UuidConverter()
  late UuidValue uuid;

  @TireLocationConverter()
  late TireLocation? locationOnVehicle;

  Uint8List? sensorBtAddress;
  String? sensorSerial;
  String? sensorVendorName;
  String? sensorProductName;
  DateTime? sensorLastSeen;
  late bool sensorAutoPair;
  
  double? lastTirePressureKPa;
  double? lastTemperatureCelcius;
  double? lastBatteryPercentage;
  bool? lastLeakDetected;

  double? nominalTirePressureKPa;
  double? warnAtTirePressureKPa;
  double? criticalAtTirePressureKPa;
  double? warnAtTemperatureCelcius;
  double? criticalAtTemperatureCelcius;
}

class TireLocationConverter extends TypeConverter<TireLocation?, int?> {
  const TireLocationConverter();

  @override
  TireLocation? fromIsar(int? object) {
    return object != null ? TireLocation.values[object] : null;
  }

  @override
  int? toIsar(TireLocation? object) {
    return object?.index;
  }
}

class UuidConverter extends TypeConverter<UuidValue, String> {
  const UuidConverter();

  @override
  UuidValue fromIsar(String object) {
    return UuidValue(object);
  }

  @override
  String toIsar(UuidValue object) {
    return object.uuid;
  }
}