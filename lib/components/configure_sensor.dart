// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/misc/definitions.dart';

class ConfigureSensor extends StatefulWidget {
  final Event retryScan;

  const ConfigureSensor({super.key, required this.retryScan});

  @override
  _ConfigureSensorState createState() => _ConfigureSensorState();
}

class _ConfigureSensorState extends State<ConfigureSensor> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesBloc, VehiclesState>(
      builder: (context, vehiclesState) {
        return BlocBuilder<BluetoothBloc, BluetoothState>(
          builder: (context, bluetoothState) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: CustomBottomSheet(
                description: 'home.configure_sensor.title'.tr(),
                child: (bluetoothState.scanState == BluetoothScanState.scanning ||
                            bluetoothState.scanState == BluetoothScanState.throttling) &&
                        bluetoothState.foundSensors.isEmpty
                    ? ScanProgressIndicator(retryScan: widget.retryScan)
                    : ListView(
                        shrinkWrap: true,
                        children: bluetoothState.foundSensors
                            .where((s) => !vehiclesState.vehicles
                                .any((v) => v.tires.any((t) => t.sensorSerial == s.serial)))
                            .map((s) => ListTile.selectable(
                                  leading: const Icon(ms.FluentIcons.bluetooth_20_regular),
                                  title: Text('${s.vendorName} ${s.productName}'),
                                  subtitle: Text(s.serial),
                                  onPressed: () => Routemaster.of(context).pop(s),
                                ))
                            .toList(),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
