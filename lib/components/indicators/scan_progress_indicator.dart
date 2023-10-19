// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';

class ScanProgressIndicator extends StatelessWidget {
  final VoidCallback retryScan;

  const ScanProgressIndicator({super.key, required this.retryScan});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // awaiting throttling
            if (state.scanState == BluetoothScanState.throttling) ...[
              const RepaintBoundary(child: ProgressRing()),
              const SizedBox(height: 20),
              Text('home.configure_sensor.please_wait'.tr()),
            ],

            // scanning but no results
            if (state.scanMode == BleScanMode.lowLatency && state.foundSensors.isEmpty) ...[
              RepaintBoundary(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1000),
                  duration: state.scanDuration! - DateTime.now().difference(state.scanStart!),
                  builder: (BuildContext context, double progressValue, Widget? child) {
                    return ProgressRing(
                      value: progressValue / 10,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text('home.configure_sensor.please_wait'.tr()),
            ],

            // scanning done but nothing found
            if (state.scanState != BluetoothScanState.throttling &&
                state.scanMode != BleScanMode.lowLatency &&
                state.foundSensors.isEmpty) ...[
              Text('home.configure_sensor.no_results'.tr()),
              const SizedBox(height: 20),
              HyperlinkButton(
                onPressed: retryScan,
                child: Text('home.configure_sensor.try_again'.tr()),
              ),
            ],
          ],
        );
      },
    );
  }
}
