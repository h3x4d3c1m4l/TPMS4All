// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dart_extensions/dart_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:uuid/uuid.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  VehicleType _selectedVehicleType = VehicleType.car;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesBloc, VehiclesState>(
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: BottomSheet(
            description: Text('home.add_vehicle.title'.tr()),
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // vehicle name
                    Text('home.add_vehicle.name'.tr()),
                    const SizedBox(height: 10),
                    TextFormBox(
                      controller: _nameController,
                      placeholder: 'home.add_vehicle.name_placeholder'.tr(),
                      validator: (value) {
                        // check uniqueness of name
                        if (value.isNullOrWhiteSpace) {
                          return 'home.add_vehicle.name_validation_empty'.tr();
                        } else if (state.vehicles.any((v) => v.name.toLowerCase() == value!.toLowerCase())) {
                          return 'home.add_vehicle.name_validation_not_unique'.tr();
                        }
                        return null;
                      },
                    ),

                    // vehicle type
                    Text('home.add_vehicle.type'.tr()),
                    const SizedBox(height: 10),
                    ComboBox<VehicleType>(
                      isExpanded: true,
                      items: getTirePressureUnitOptions(),
                      value: _selectedVehicleType,
                      onChanged: (vehicleType) {
                        _selectedVehicleType = vehicleType!;
                      },
                    ),

                    // add button
                    const SizedBox(height: 20),
                    HyperlinkButton(
                      onPressed: saveVehicle,
                      child: Text('home.add_vehicle.add'.tr()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static List<ComboBoxItem<VehicleType>> getTirePressureUnitOptions() {
    return <ComboBoxItem<VehicleType>>[
      ComboBoxItem<VehicleType>(value: VehicleType.car, child: Text('home.add_vehicle.type_option_car'.tr())),
      ComboBoxItem<VehicleType>(
          value: VehicleType.motorcycle,
          child: Text('home.add_vehicle.type_option_motorcycle'.tr())),
      //ComboboxItem<VehicleType>(child: Text('bar'), value: VehicleType.other), // TODO
    ].lock.unlockView;
  }

  void saveVehicle() {
    if (!_formKey.currentState!.validate()) return;
    Routemaster.of(context).pop(
      Vehicle(
        uuid: UuidValue(const Uuid().v4()),
        name: _nameController.text,
        type: _selectedVehicleType,
        added: DateTime.now(),
        color: Colors.green,
        tires: _selectedVehicleType == VehicleType.car
            ? [
                Tire(
                  uuid: UuidValue(const Uuid().v4()),
                  locationOnVehicle: TireLocation.frontLeft,
                  sensorAutoPair: true,
                ),
                Tire(
                  uuid: UuidValue(const Uuid().v4()),
                  locationOnVehicle: TireLocation.frontRight,
                  sensorAutoPair: true,
                ),
                Tire(
                  uuid: UuidValue(const Uuid().v4()),
                  locationOnVehicle: TireLocation.rearLeft,
                  sensorAutoPair: true,
                ),
                Tire(
                  uuid: UuidValue(const Uuid().v4()),
                  locationOnVehicle: TireLocation.rearRight,
                  sensorAutoPair: true,
                ),
              ].lock
            : [
                Tire(
                  uuid: UuidValue(const Uuid().v4()),
                  locationOnVehicle: TireLocation.front,
                  sensorAutoPair: true,
                ),
                Tire(
                  uuid: UuidValue(const Uuid().v4()),
                  locationOnVehicle: TireLocation.rear,
                  sensorAutoPair: true,
                ),
              ].lock,
      ),
    );
  }
}
