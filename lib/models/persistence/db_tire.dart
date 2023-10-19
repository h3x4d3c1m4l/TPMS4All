// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:isar/isar.dart';
import 'package:universal_tpms_reader/misc/string_hash.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';

part 'db_tire.g.dart';

@Collection(accessor: 'tire')
class DbTire {
  late String uuid;

  Id get isarId => fastHash(uuid);

  @enumerated
  late TireLocation locationOnVehicle;

  List<byte>? sensorBtAddress;
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
