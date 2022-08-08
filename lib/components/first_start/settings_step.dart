// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';

class SettingsStep extends StatelessWidget {
  final VoidCallback onNext;

  const SettingsStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(title: Text('welcome.settings.title'.tr(), textAlign: TextAlign.center)),
        const Expanded(
          child: FlutterLogo(size: 128),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () => {},
            ),
            const SizedBox(width: 20),
            FilledButton(
              onPressed: onNext,
              child: Text('next'.tr()),
            ),
          ],
        )
      ],
    );
  }
}
