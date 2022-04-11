// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
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
import 'package:dart_extensions/dart_extensions.dart';

part 'vehicle_manager_bloc.freezed.dart';
part 'vehicle_manager_bloc_db.dart';
part 'vehicle_manager_event.dart';
part 'vehicle_manager_state.dart';

/// BLoC that manages both in memory storage of vehicle and tire data and also their persistence.
/// For actual persistence Isar is being used.
class VehicleManagerBloc extends Bloc<VehicleManagerEvent, VehicleManagerState> {
  static const String _databaseName = 'tpmsPersistence';
  static final IList<CollectionSchema> _isarSchemas = [DbVehicleSchema, DbTireSchema].lock;
  final BluetoothBloc bluetoothBloc;
  late final Isar _isar;

  VehicleManagerBloc(this.bluetoothBloc) : super(VehicleManagerState.initial()) {
    // keep listening to sensor readings
    bluetoothBloc.stream.map((s) => s.lastSeenSensor).where((s) => s != null).distinct().listen((s) {
      // new sensor reading
      add(UpsertSensorInfo(s!));
    });

    on<InitializeFromDatabaseEvent>(_onInitializeFromInitialVehiclesEvent);

    // manage in memory vehicle and sensor data
    on<UpsertVehicle>(_onUpsertVehicle);
    on<DeleteVehicle>(_onDeleteVehicle);
    on<UpsertSensorInfo>(_onUpsertSensorInfo);

    // database (vehicle_manager_bloc_db.dart)
    on<UpsertVehicleInDatabase>(_onUpsertVehicleInDatabase, transformer: concurrent());
    on<DeleteVehicleFromDatabase>(_onDeleteVehicleFromDatabase);
  }

  FutureOr<void> _onInitializeFromInitialVehiclesEvent(
      InitializeFromDatabaseEvent event, Emitter<VehicleManagerState> emit) async {
    final dir = await getApplicationSupportDirectory();

    _isar = await Isar.open(
      name: _databaseName,
      schemas: _isarSchemas.unlockLazy,
      directory: dir.path,
      inspector: true,
    );

    emit(state.copyWith(isInitialized: true, vehicles: await _getVehiclesFromIsar()));
  }

  FutureOr<void> _onUpsertVehicle(UpsertVehicle event, Emitter<VehicleManagerState> emit) {
    emit(state.copyWith(
      vehicles: state.vehicles.upsert((v) => v.uuid == event.vehicle.uuid, event.vehicle),
    ));
    add(UpsertVehicleInDatabase(event.vehicle));
  }

  FutureOr<void> _onDeleteVehicle(DeleteVehicle event, Emitter<VehicleManagerState> emit) {
    emit(state.copyWith(
      vehicles: state.vehicles.removeWhere((v) => v.uuid == event.uuid),
    ));
    add(DeleteVehicleFromDatabase(event.uuid));
  }

  FutureOr<void> _onUpsertSensorInfo(UpsertSensorInfo event, Emitter<VehicleManagerState> emit) async {
    final Vehicle? vehicle = state.vehicles
        .firstOrNullWhere((v) => v.tires.any((t) => _uuidOrSensorInfoMatchesTire(t, event.tireUuid, event.sensorInfo)));

    // if there's no match, just ignore this sensor data
    if (vehicle == null) return;

    add(UpsertVehicle(
      // mutate vehicle object
      vehicle.copyWith(
        tires: vehicle.tires.mutate(
          (t) => _uuidOrSensorInfoMatchesTire(t, event.tireUuid, event.sensorInfo),

          // mutate tire object
          (t) => t.copyWith(
            sensorBtAddress: event.sensorInfo.btAddress,
            sensorSerial: event.sensorInfo.serial,
            sensorVendorName: event.sensorInfo.vendorName,
            sensorProductName: event.sensorInfo.productName,
            sensorLastSeen: DateTime.now(),
            lastTirePressureKPa: event.sensorInfo.tirePressureKPa,
            lastTemperatureCelcius: event.sensorInfo.temperatureCelcius,
            lastBatteryPercentage: event.sensorInfo.batteryPercentage,
            lastLeakDetected: event.sensorInfo.leakDetected,
          ),
        ),
      ),
    ));
  }

  bool _uuidOrSensorInfoMatchesTire(Tire tire, UuidValue? tireUuid, SensorInfo sensorInfo) {
    return
        // we already know for sure which tire to update
        tire.uuid == tireUuid ||
            // we might be able to find out to which tire this sensor belongs
            tire.sensorSerial == sensorInfo.serial ||
            // sensor is unknown, but we might be able to auto pair it with a tire
            (tire.sensorSerial == null &&
                tire.sensorAutoPair &&
                tire.locationOnVehicle != null &&
                tire.locationOnVehicle == sensorInfo.suggestsLocationOnVehicle);
  }
}
