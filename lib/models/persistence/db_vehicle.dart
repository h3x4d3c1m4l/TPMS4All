// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/persistence/_all.dart';
import 'package:uuid/uuid.dart';

part 'db_vehicle.g.dart';

@Collection(accessor: 'vehicle')
class DbVehicle {
  int? id;
  @UuidConverter()
  late UuidValue uuid;

  @VehicleTypeConverter()
  late VehicleType? type;
  late String name;
  late DateTime added;
  @VehicleColorConverter()
  late Color color;

  final tires = IsarLinks<DbTire>();
}

class VehicleTypeConverter extends TypeConverter<VehicleType?, int?> {
  const VehicleTypeConverter();

  @override
  VehicleType? fromIsar(int? object) {
    return object != null ? VehicleType.values[object] : null;
  }

  @override
  int? toIsar(VehicleType? object) {
    return object?.index;
  }
}

class VehicleColorConverter extends TypeConverter<Color, int> {
  const VehicleColorConverter();

  @override
  Color fromIsar(int object) {
    return Color(object);
  }

  @override
  int toIsar(Color object) {
    return object.value;
  }
}
