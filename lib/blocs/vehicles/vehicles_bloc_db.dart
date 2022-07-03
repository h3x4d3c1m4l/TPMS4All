// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'vehicles_bloc.dart';

/// This extension contains the persistence functions of the Vehicle Manager BLoC. This is doing just to keep
/// vehicle_manager_bloc.dart more manageable in terms of line count.
extension VehiclesBlocDb on VehiclesBloc {
  FutureOr<void> _onNewOrUpdatedVehicleEmitted(_VehiclesNewOrUpdatedVehicleEmitted event, Emitter<VehiclesState> emit) async {
    await _isar.writeTxn((isar) async {
      final DbVehicle? dbVehicle = await isar.vehicle.filter().uuidEqualTo(event.vehicle.uuid).findFirst();
      if (dbVehicle == null) {
        // insert
        final dbVehicle = DbVehicle()
          ..uuid = event.vehicle.uuid
          ..name = event.vehicle.name
          ..type = event.vehicle.type
          ..added = event.vehicle.added
          ..color = event.vehicle.color
          ..tires.addAll(
            event.vehicle.tires.map(
              (t) => DbTire()
                ..uuid = t.uuid
                ..locationOnVehicle = t.locationOnVehicle
                ..sensorAutoPair = t.sensorAutoPair,
            ),
          );
        await isar.vehicle.put(dbVehicle, saveLinks: true);
      } else {
        // update
        await dbVehicle.tires.load();

        // vehicle
        dbVehicle
          ..name = event.vehicle.name
          ..type = event.vehicle.type
          ..color = event.vehicle.color;

        // tires
        final List<DbTire> updatedTires = dbVehicle.tires.toList();
        for (final DbTire dbTire in updatedTires) {
          final Tire tire = event.vehicle.tires.firstWhere((t) => t.uuid == dbTire.uuid);

          dbTire
            ..sensorBtAddress = tire.sensorBtAddress
            ..sensorSerial = tire.sensorSerial
            ..sensorVendorName = tire.sensorVendorName
            ..sensorProductName = tire.sensorProductName
            ..sensorLastSeen = tire.sensorLastSeen
            ..sensorAutoPair = tire.sensorAutoPair
            ..lastTirePressureKPa = tire.lastTirePressureKPa
            ..lastTemperatureCelcius = tire.lastTemperatureCelcius
            ..lastBatteryPercentage = tire.lastBatteryPercentage
            ..lastLeakDetected = tire.lastLeakDetected
            ..nominalTirePressureKPa = tire.nominalTirePressureKPa
            ..warnAtTirePressureKPa = tire.warnAtTirePressureKPa
            ..criticalAtTirePressureKPa = tire.criticalAtTirePressureKPa
            ..warnAtTemperatureCelcius = tire.warnAtTemperatureCelcius
            ..criticalAtTemperatureCelcius = tire.criticalAtTemperatureCelcius;
        }

        await dbVehicle.tires.save();
        await isar.vehicle.put(dbVehicle);
        await isar.tire.putAll(updatedTires);
      }
    });
  }

  FutureOr<void> _onVehicleDeleteEmitted(
      _VehiclesVehicleDeleteEmitted event, Emitter<VehiclesState> emit) async {
    await _isar.writeTxn((isar) async {
      final DbVehicle dbVehicle = (await isar.vehicle.filter().uuidEqualTo(event.vehicleUuid).findFirst())!;
      await dbVehicle.tires.load();

      await isar.vehicle.delete(dbVehicle.id!);
      await isar.tire.deleteAll(dbVehicle.tires.map((t) => t.id!).toList());
    });
  }

  Future<IList<Vehicle>> _getVehiclesFromIsar() async {
    final List<DbVehicle> dbVehicles = await _isar.vehicle.where().findAll();
    for (final DbVehicle v in dbVehicles) {
      // tires have to be lazy loaded
      await v.tires.load();
    }
    return dbVehicles
        .map(
          (v) => Vehicle(
            uuid: v.uuid,
            type: v.type,
            name: v.name,
            added: v.added,
            color: v.color,
            tires: v.tires
                .map(
                  (t) => Tire(
                    uuid: t.uuid,
                    locationOnVehicle: t.locationOnVehicle,
                    sensorBtAddress: t.sensorBtAddress,
                    sensorSerial: t.sensorSerial,
                    sensorVendorName: t.sensorVendorName,
                    sensorProductName: t.sensorProductName,
                    sensorLastSeen: t.sensorLastSeen,
                    sensorAutoPair: t.sensorAutoPair,
                    lastTirePressureKPa: t.lastTirePressureKPa,
                    lastTemperatureCelcius: t.lastTemperatureCelcius,
                    lastBatteryPercentage: t.lastBatteryPercentage,
                    lastLeakDetected: t.lastLeakDetected,
                    nominalTirePressureKPa: t.nominalTirePressureKPa,
                    warnAtTirePressureKPa: t.warnAtTirePressureKPa,
                    criticalAtTirePressureKPa: t.criticalAtTirePressureKPa,
                    warnAtTemperatureCelcius: t.warnAtTemperatureCelcius,
                    criticalAtTemperatureCelcius: t.criticalAtTemperatureCelcius,
                  ),
                )
                .toIList(),
          ),
        )
        .toIList();
  }
}