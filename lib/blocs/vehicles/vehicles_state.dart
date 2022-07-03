// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'vehicles_bloc.dart';

@freezed
class VehiclesState with _$VehiclesState {
  const factory VehiclesState({
    required bool isInitialized,
    required IList<Vehicle> vehicles,
  }) = _VehiclesState;
  const VehiclesState._();

  factory VehiclesState.initial() => const VehiclesState(
        isInitialized: false,
        vehicles: IListConst<Vehicle>([]),
      );
}
