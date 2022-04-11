// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';

class AppEasyLocalization extends StatelessWidget {
  final Widget child;

  const AppEasyLocalization({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, String?>(
      selector: (state) => state.settings.languageCode,
      builder: (context, languageCode) {
        // TODO: determine locales from asset files
        // TODO: check if fallback to English works (e.g. set device language to Afrikaans, then see what happens)
        return EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('nl')],
          path: 'assets/translations',
          saveLocale: false,
          useOnlyLangCode: true,
          fallbackLocale: const Locale('en'),
          startLocale: languageCode != null ? Locale(languageCode) : null,
          child: child,
        );
      },
    );
  }
}
