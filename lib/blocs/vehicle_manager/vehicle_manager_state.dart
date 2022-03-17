// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'vehicle_manager_bloc.dart';

@freezed
class VehicleManagerState with _$VehicleManagerState {
  const VehicleManagerState._();
  factory VehicleManagerState.initial() => VehicleManagerState(
        isInitialized: false,
        vehicles: <Vehicle>[].lock,
      );

  factory VehicleManagerState({
    required bool isInitialized,
    required IList<Vehicle> vehicles,
  }) = _VehicleManager;
}
