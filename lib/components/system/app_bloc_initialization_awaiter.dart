// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';

class AppBlocInitializationAwaiter extends StatelessWidget {
  final Widget child;

  const AppBlocInitializationAwaiter({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, bool>(
      selector: (state) => state.isInitialized,
      builder: (context, settingsIsInitialized) {
        return BlocSelector<VehicleManagerBloc, VehicleManagerState, bool>(
          selector: (state) => state.isInitialized,
          builder: (context, vehicleManagerIsInitialized) {
            return BlocSelector<BluetoothBloc, BluetoothState, bool>(
              selector: (state) => state.isInitialized,
              builder: (context, bluetoothIsInitialized) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: settingsIsInitialized && vehicleManagerIsInitialized && bluetoothIsInitialized
                      ? child
                      : Container(
                          color: FluentTheme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                          child: const Center(
                            child: RepaintBoundary(
                              child: ProgressRing(),
                            ),
                          ),
                        ),
                  transitionBuilder: (child, animation) => DrillInPageTransition(animation: animation, child: child),
                );
              },
            );
          },
        );
      },
    );
  }
}
