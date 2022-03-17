// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:uuid/uuid.dart';

part 'vehicle.freezed.dart';

@freezed
class Vehicle with _$Vehicle {
  const Vehicle._();
  const factory Vehicle({
    required UuidValue uuid,
    required VehicleType? type,
    required String name,
    required DateTime added,
    required Color color,
    required IList<Tire> tires,
  }) = _Vehicle;

  // unconfigured / waiting for sensor
  bool get unconfigured => tires.any((t) => t.isUnconfigured);
  bool get anySensorUnavailable => tires.any((t) => t.sensorUnavailable);
  bool get allSensorUnavailable => !tires.any((t) => !t.sensorUnavailable);
  bool get someSensorsUnavailable => tires.any((t) => t.sensorUnavailable) && tires.any((t) => !t.sensorUnavailable);

  // warning
  bool get warning => tires.any((t) => t.warning);

  // critical
  bool get critical => tires.any((t) => t.critical);
}
