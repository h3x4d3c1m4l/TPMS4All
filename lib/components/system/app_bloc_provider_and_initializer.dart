// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';

class AppBlocProviderAndInitializer extends StatelessWidget {
  final Widget child;

  const AppBlocProviderAndInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final BluetoothBloc bluetoothBloc = BluetoothBloc();

    return MultiBlocProvider(
      providers: [
        // first initialize Settings and Database
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc()..add(const SettingsEvent.blocCreated()),
        ),
        BlocProvider<BluetoothBloc>(
          create: (context) => bluetoothBloc..add(const BluetoothEvent.blocCreated()),
        ),
        BlocProvider<VehiclesBloc>(
          create: (context) => VehiclesBloc(bluetoothBloc)..add(const VehiclesEvent.blocCreated()),
        ),
      ],
      child: BlocListener<BluetoothBloc, BluetoothState>(
        bloc: bluetoothBloc,
        listenWhen: (previousState, state) =>
            !previousState.bluetoothPermissionsGranted && state.bluetoothPermissionsGranted,
        listener: (contect, state) => bluetoothBloc.add(BluetoothEvent.foregroundScanRequested()),
        child: child,
      ),
    );
  }
}
