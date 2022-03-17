// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'vehicle_manager_bloc.dart';

@immutable
abstract class VehicleManagerEvent {}

@immutable
class InitializeFromDatabaseEvent extends VehicleManagerEvent {}

/// Save updated vehicle and tire information in memory. Also an UpsertVehicle event should be sent to
/// persist this data.
@immutable
class UpsertVehicle extends VehicleManagerEvent {
  final Vehicle vehicle;

  UpsertVehicle(this.vehicle);
}

/// Delete vehicle and tire information from memory. Also a [DeleteVehicleFromDatabase] event should be sent to
/// delete it from the persistence database.
@immutable
class DeleteVehicle extends VehicleManagerEvent {
  final UuidValue uuid;

  DeleteVehicle(this.uuid);
}

/// Persist updated vehicle and tire information. This should be sent automatically by the handler of
/// the [UpsertVehicle] event.
@immutable
class UpsertVehicleInDatabase extends VehicleManagerEvent {
  final Vehicle vehicle;

  UpsertVehicleInDatabase(this.vehicle);
}

/// Delete vehicle and tire information from the database. This should be sent automatically by the handler of the
/// [DeleteVehicle] event. 
@immutable
class DeleteVehicleFromDatabase extends VehicleManagerEvent {
  final UuidValue uuid;

  DeleteVehicleFromDatabase(this.uuid);
}

/// Update sensor data in memory for given tire. Also an [UpsertVehicle] event should be sent to persist this data.
@immutable
class UpsertSensorInfo extends VehicleManagerEvent {
  final SensorInfo sensorInfo;
  final UuidValue? tireUuid;

  UpsertSensorInfo(this.sensorInfo, [this.tireUuid]);
}
