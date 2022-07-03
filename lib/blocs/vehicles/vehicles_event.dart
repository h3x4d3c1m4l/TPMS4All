// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'vehicles_bloc.dart';

@Freezed(
  copyWith: false,
  equal: false,
)
class VehiclesEvent with _$VehiclesEvent {
  const factory VehiclesEvent.blocCreated() = _VehiclesBlocCreated;

  const factory VehiclesEvent.vehicleCreatedOrModified(Vehicle vehicle) = _VehiclesVehicleCreatedOrModified;

  const factory VehiclesEvent.vehicleDeleteConfirmed(UuidValue vehicleUuid) = _VehiclesVehicleDeleteConfirmed;


  const factory VehiclesEvent.newOrUpdatedVehicleEmitted(Vehicle vehicle) = _VehiclesNewOrUpdatedVehicleEmitted;

  const factory VehiclesEvent.vehicleDeleteEmitted(UuidValue vehicleUuid) = _VehiclesVehicleDeleteEmitted;

  /// Update sensor data in memory for given tire. Also an [VehiclesVehicleAddedOrChanged] event will be sent automatically to persist this data.
  const factory VehiclesEvent.sensorDataReceived(SensorData sensorData, UuidValue? tireUuid) = _VehiclesSensorDataReceived;
}
