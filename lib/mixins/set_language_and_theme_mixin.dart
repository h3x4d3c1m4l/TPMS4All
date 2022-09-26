// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';

mixin SetLanguageAndThemeMixin<T extends StatefulWidget> on State<T> {
  late SettingsBloc settingsBloc;

  List<ComboBoxItem<String?>> getLanguageOptions() {
    return <ComboBoxItem<String?>>[
      ComboBoxItem<String>(child: Text('settings.settings.language.options.default'.tr())),
      ...settingsBloc.state.availableTranslations.map((languageCode) => ComboBoxItem<String>(
          value: languageCode, child: Text('settings.settings.language.options.$languageCode'.tr()))),
    ].lock.unlockView;
  }

  Future applyAndStoreLanguage(String? languageCode) async {
    // save setting
    settingsBloc.add(SettingsEvent.settingsChanged(
      settingsBloc.state.settings.copyWith(languageCode: languageCode),
    ));

    // set UI
    if (languageCode != null) {
      // user picked an actual language option
      await context.setLocale(Locale(languageCode));
    } else {
      // user picked 'default' option (meaning: set to device language with fallback)

      // note: we should be able to use context.resetLocale() but
      // it force sets the locale to the first device preferred locale even if not supported
      // by us; this will make Flutter crash :(

      // check if we support any locales the user has set as preferred in their OS
      final Locale? supportedLocale = WidgetsBinding.instance.window.locales.firstWhereOrNull((deviceLocale) =>
          context.supportedLocales.any((supportedLocale) => supportedLocale.languageCode == deviceLocale.languageCode));

      if (supportedLocale != null) {
        await context.setLocale(Locale(supportedLocale.languageCode));
      } else {
        await context.setLocale(context.fallbackLocale!);
      }
    }
  }

  static List<ComboBoxItem<AppTheme>> getAppThemeOptions() {
    return <ComboBoxItem<AppTheme>>[
      ComboBoxItem<AppTheme>(value: AppTheme.byDevice, child: Text('settings.settings.theme.options.default'.tr())),
      ComboBoxItem<AppTheme>(value: AppTheme.light, child: Text('settings.settings.theme.options.light'.tr())),
      ComboBoxItem<AppTheme>(value: AppTheme.dark, child: Text('settings.settings.theme.options.dark'.tr())),
    ].lock.unlockView;
  }

  void applyAndStoreAppTheme(AppTheme appTheme) {
    settingsBloc.add(SettingsEvent.settingsChanged(
      settingsBloc.state.settings.copyWith(appTheme: appTheme),
    ));
  }
}
