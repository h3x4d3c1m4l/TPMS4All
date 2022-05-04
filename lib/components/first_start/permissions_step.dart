// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';

class PermissionsStep extends StatefulWidget {
  final VoidCallback onNext;

  const PermissionsStep({Key? key, required this.onNext}) : super(key: key);

  @override
  State<PermissionsStep> createState() => _PermissionsStepState();
}

class _PermissionsStepState extends State<PermissionsStep> {
  late final BluetoothBloc _bluetoothBloc;
  bool _failed = false;

  @override
  void initState() {
    super.initState();

    _bluetoothBloc = BlocProvider.of<BluetoothBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BluetoothBloc, BluetoothState>(
      bloc: _bluetoothBloc,
      listenWhen: (previous, current) =>
          previous.permissionStatusIsBeingUpdated && !current.permissionStatusIsBeingUpdated,
      listener: (context, state) {
        if (state.bluetoothPermissionsGranted) {
          // all good
          widget.onNext();
        } else {
          setState(() => _failed = true);
        }
      },
      child: Column(
        children: [
          PageHeader(title: Text('welcome.permissions.title'.tr(), textAlign: TextAlign.center)),
          const Icon(ms.FluentIcons.bluetooth_20_regular, size: 64, color: Color(0xff0082fc)),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('welcome.permissions.explanation'.tr(), style: const TextStyle(height: 1.5)),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // TODO
              if (_failed)
                Expanded(
                  child: Text(
                    'welcome.permissions.try_again'.tr(),
                    style: const TextStyle(color: Colors.errorPrimaryColor),
                  ),
                ),
              FilledButton(
                onPressed: () => _requestPermissions(context),
                child: Text('next'.tr()),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _requestPermissions(BuildContext context) {
    setState(() => _failed = false);
    _bluetoothBloc.add(const BluetoothEvent.requestPermissions());
  }
}
