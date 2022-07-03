// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/misc/extensions/ilist_extension.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:universal_tpms_reader/models/persistence/_all.dart';
import 'package:uuid/uuid.dart';

part 'vehicles_bloc.freezed.dart';
part 'vehicles_bloc_db.dart';
part 'vehicles_event.dart';
part 'vehicles_state.dart';

/// BLoC that manages both in memory storage of vehicle and tire data and also their persistence.
/// For actual persistence Isar is being used.
class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  static const String _databaseName = 'tpmsPersistence';
  static final IList<CollectionSchema> _isarSchemas = [DbVehicleSchema, DbTireSchema].lock;
  final BluetoothBloc bluetoothBloc;
  late final Isar _isar;

  VehiclesBloc(this.bluetoothBloc) : super(VehiclesState.initial()) {
    on<_VehiclesBlocCreated>(_onBlocCreated);

    // manage in memory vehicle and sensor data
    on<_VehiclesVehicleCreatedOrModified>(_onVehicleCreatedOrModified);
    on<_VehiclesVehicleDeleteConfirmed>(_onVehicleDeleteConfirmed);
    on<_VehiclesSensorDataReceived>(_onSensorDataReceived);

    // database (vehicles_bloc_db.dart)
    on<_VehiclesNewOrUpdatedVehicleEmitted>(_onNewOrUpdatedVehicleEmitted, transformer: concurrent());
    on<_VehiclesVehicleDeleteEmitted>(_onVehicleDeleteEmitted);

    // listen to sensor data
    bluetoothBloc.stream.map((s) => s.lastSeenSensor).where((s) => s != null).distinct().listen((s) {
      add(VehiclesEvent.sensorDataReceived(s!, null));
    });
  }

  FutureOr<void> _onBlocCreated(_VehiclesBlocCreated event, Emitter<VehiclesState> emit) async {
    final dir = await getApplicationSupportDirectory();

    _isar = await Isar.open(
      name: _databaseName,
      schemas: _isarSchemas.unlockLazy,
      directory: dir.path,
      inspector: true,
    );

    emit(state.copyWith(isInitialized: true, vehicles: await _getVehiclesFromIsar()));
  }

  FutureOr<void> _onVehicleCreatedOrModified(_VehiclesVehicleCreatedOrModified event, Emitter<VehiclesState> emit) {
    emit(state.copyWith(
      vehicles: state.vehicles.upsert((v) => v.uuid == event.vehicle.uuid, event.vehicle),
    ));
    add(_VehiclesNewOrUpdatedVehicleEmitted(event.vehicle));
  }

  FutureOr<void> _onVehicleDeleteConfirmed(_VehiclesVehicleDeleteConfirmed event, Emitter<VehiclesState> emit) {
    emit(state.copyWith(
      vehicles: state.vehicles.removeWhere((v) => v.uuid == event.vehicleUuid),
    ));
    add(_VehiclesVehicleDeleteEmitted(event.vehicleUuid));
  }

  FutureOr<void> _onSensorDataReceived(_VehiclesSensorDataReceived event, Emitter<VehiclesState> emit) async {
    final Vehicle? vehicle = state.vehicles
        .firstOrNullWhere((v) => v.tires.any((t) => _uuidOrSensorDataMatchesTire(t, event.tireUuid, event.sensorData)));

    // if there's no match, just ignore this sensor data
    if (vehicle == null) return;

    add(_VehiclesVehicleCreatedOrModified(
      // mutate vehicle object
      vehicle.copyWith(
        tires: vehicle.tires.mutate(
          (t) => _uuidOrSensorDataMatchesTire(t, event.tireUuid, event.sensorData),

          // mutate tire object
          (t) => t.copyWith(
            sensorBtAddress: event.sensorData.btAddress,
            sensorSerial: event.sensorData.serial,
            sensorVendorName: event.sensorData.vendorName,
            sensorProductName: event.sensorData.productName,
            sensorLastSeen: DateTime.now(),
            lastTirePressureKPa: event.sensorData.tirePressureKPa,
            lastTemperatureCelcius: event.sensorData.temperatureCelcius,
            lastBatteryPercentage: event.sensorData.batteryPercentage,
            lastLeakDetected: event.sensorData.leakDetected,
          ),
        ),
      ),
    ));
  }

  bool _uuidOrSensorDataMatchesTire(Tire tire, UuidValue? tireUuid, SensorData sensorData) {
    return
        // we already know for sure which tire to update
        tire.uuid == tireUuid ||
            // we might be able to find out to which tire this sensor belongs
            tire.sensorSerial == sensorData.serial ||
            // sensor is unknown, but we might be able to auto pair it with a tire
            (tire.sensorSerial == null &&
                tire.sensorAutoPair &&
                tire.locationOnVehicle != null &&
                tire.locationOnVehicle == sensorData.suggestsLocationOnVehicle);
  }
}
