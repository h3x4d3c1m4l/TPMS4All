// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:isar/isar.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/persistence/_all.dart';

part 'db_vehicle.g.dart';

@Collection(accessor: 'vehicle')
class DbVehicle {
  Id? id;

  late String uuid;

  @Enumerated(EnumType.ordinal, 'value')
  late VehicleType type;
  late String name;
  late DateTime added;
  late int color;

  final tires = IsarLinks<DbTire>();
}
