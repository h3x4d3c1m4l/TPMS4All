// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dart_extensions/dart_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:routemaster/routemaster.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/misc/extensions/ilist_extension.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VehiclesBloc _vehiclesBloc;
  late BluetoothBloc _bluetoothBloc;
  bool vehicleEditModeEnabled = false;
  final Key _someKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _vehiclesBloc = BlocProvider.of<VehiclesBloc>(context);
    _bluetoothBloc = BlocProvider.of<BluetoothBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Text('home.title'.tr()),
        actions: Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(FluentIcons.edit),
              onPressed: () => setState(() => vehicleEditModeEnabled = !vehicleEditModeEnabled),
            ),
          ],
        ),
      ),
      pane: NavigationPane(
        key: _someKey,
        displayMode: PaneDisplayMode.minimal,
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          // TODO: replace Flutter logo
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            body: _homepage,
            title: Text('home.title'.tr()),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.add),
            body: const SizedBox(),
            title: Text('home.add_vehicle.title'.tr()),
            onTap: () {
              setState(() {
                addNewVehicle(context);
              });
            },
            autofocus: true,
          ),
          PaneItemSeparator(),
          PaneItemAction(
            icon: const Icon(FluentIcons.settings),
            body: const SizedBox(),
            title: Text('settings.title'.tr()),
            onTap: () {
              Routemaster.of(context).push('/settings');
            },
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.info),
            body: const SizedBox(),
            title: Text('about.title'.tr()),
            onTap: () {
              Routemaster.of(context).push('/about');
            },
          ),
        ],
        selected: 0,
      ),
    );
  }

  Widget get _homepage {
    return Container(
      margin: const EdgeInsets.all(10),
      child: BlocBuilder<VehiclesBloc, VehiclesState>(
        builder: (context, state) {
          return ResponsiveGridList(
            desiredItemWidth: 300,
            minSpacing: 10,
            children: state.vehicles.map(
              (v) {
                return AnimatedCrossFade(
                  // edit mode
                  firstChild: SettingCard(
                    icon: v.type == VehicleType.car
                        ? ms.FluentIcons.vehicle_car_profile_ltr_16_regular
                        : v.type == VehicleType.motorcycle
                            ? FluentIcons.cycling
                            : FluentIcons.unknown,
                    title: v.name,
                    subtitle: 'home.edit_mode.added_on'.tr() + DateFormat.yMd().format(v.added),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(FluentIcons.edit, color: Colors.warningPrimaryColor),
                          onPressed: () => renameVehicle(context, v),
                        ),
                        IconButton(
                          icon: const Icon(FluentIcons.delete, color: Colors.errorPrimaryColor),
                          onPressed: () => deleteVehicle(context, v),
                        )
                      ],
                    ),
                  ),

                  // normal mode
                  secondChild: VehicleCard(
                    key: ValueKey(v.uuid),
                    vehicle: v,
                    initiallyExpanded: state.vehicles.length == 1,
                    switchToManualSensorSelection: (tireUuid) => configureSensorManually(context, tireUuid),
                    switchToAutoSensorSelection: (tireUuid) => configureSensorAutomatically(tireUuid),
                  ),

                  // animation settings
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: vehicleEditModeEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstCurve: Curves.elasticInOut,
                  secondCurve: Curves.elasticInOut,
                  sizeCurve: Curves.elasticInOut,
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }

  void renameVehicle(BuildContext context, Vehicle vehicle) {
    final formKey = GlobalKey<FormState>();
    String newName = '';

    showDialog(
      barrierDismissible: true,
      context: context,
      // use StatefulBuilder to make set button enable state based on form validation result
      builder: (context) => StatefulBuilder(
        builder: (context, stateSetter) => ContentDialog(
          title: Text('home.rename_vehicle.title'.tr()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('home.rename_vehicle.content'.tr(args: [vehicle.name])),
              const SizedBox(height: 5),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormBox(
                  autofocus: true,
                  onChanged: (value) => stateSetter(() => newName = value),
                  validator: (value) {
                    // check uniqueness of name
                    if (newName == vehicle.name) {
                      return null;
                    } else if (value.isNullOrWhiteSpace) {
                      return 'home.add_vehicle.name_validation_empty'.tr();
                    } else if (_vehiclesBloc.state.vehicles
                        .any((v) => v.name.toLowerCase() == value!.toLowerCase())) {
                      return 'home.add_vehicle.name_validation_not_unique'.tr();
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                Navigator.pop(context);
                _vehiclesBloc.add(VehiclesEvent.vehicleCreatedOrModified(
                  _vehiclesBloc.state.vehicles.firstWhere((v) => v.uuid == vehicle.uuid).copyWith(name: newName),
                ));
              },
              child: Text('rename'.tr()),
            ),
            Button(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel'.tr()),
            )
          ],
        ),
      ),
    );
  }

  void deleteVehicle(BuildContext context, Vehicle vehicle) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => ContentDialog(
        title: Text('home.delete_vehicle.title'.tr()),
        content: Text('home.delete_vehicle.content'.tr(args: [vehicle.name])),
        actions: [
          FilledButton(
            child: Text('delete'.tr()),
            onPressed: () {
              Navigator.pop(context);
              _vehiclesBloc.add(VehiclesEvent.vehicleDeleteConfirmed(vehicle.uuid));
            },
          ),
          Button(
            child: Text('cancel'.tr()),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> addNewVehicle(BuildContext context) async {
    final Vehicle? vehicle = await showBottomSheet(
      backgroundColor: FluentTheme.of(context).micaBackgroundColor,
      context: context,
      builder: (context) {
        return const AddVehicle();
      },
    );

    if (vehicle != null) {
      _vehiclesBloc.add(VehiclesEvent.vehicleCreatedOrModified(vehicle));
    }
  }

  void scan() => _bluetoothBloc.add(BluetoothEvent.extensiveScanRequested(duration: const Duration(minutes: 1)));

  Future<void> configureSensorManually(BuildContext context, UuidValue tireUuid) async {
    _setTireSensorAutoPair(tireUuid, false);

    scan();
    final SensorData? sensorData = await showBottomSheet(
      backgroundColor: FluentTheme.of(context).micaBackgroundColor,
      context: context,
      builder: (context) {
        return ConfigureSensor(retryScan: scan);
      },
    );
    _bluetoothBloc.add(BluetoothEvent.foregroundScanRequested());

    if (sensorData != null) {
      _vehiclesBloc.add(VehiclesEvent.sensorDataReceived(sensorData, tireUuid));
    }
  }

  void configureSensorAutomatically(UuidValue tireUuid) => _setTireSensorAutoPair(tireUuid, true);

  void _setTireSensorAutoPair(UuidValue tireUuid, bool value) {
    Vehicle vehicle = _vehiclesBloc.state.vehicles.firstWhere((v) => v.tires.any((t) => t.uuid == tireUuid));
    vehicle = vehicle.copyWith(
        tires: vehicle.tires.mutate((t) => t.uuid == tireUuid, (t) {
      return t.copyWith(sensorAutoPair: value);
    }));
    _vehiclesBloc.add(VehiclesEvent.vehicleCreatedOrModified(vehicle));
  }
}
