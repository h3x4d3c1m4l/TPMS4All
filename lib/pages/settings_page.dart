// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dart_extensions/dart_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_tpms_reader/blocs/settings/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/application/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc settingsBloc;

  @override
  void initState() {
    super.initState();
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, Settings>(
      bloc: settingsBloc,
      selector: (state) => state.settings,
      builder: (context, settings) {
        return GenericPage(
          title: 'settings.title'.tr(),
          content: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    // language
                    SettingCard(
                      icon: FluentIcons.locale_language,
                      title: 'settings.settings.language.title'.tr(),
                      subtitle: 'settings.settings.language.subtitle'.tr(),
                      child: SizedBox(
                        width: 125,
                        child: Combobox<String?>(
                          placeholder: Text('settings.settings.language.options.default'.tr()),
                          isExpanded: true,
                          items: getLanguageOptions(),
                          value: settings.languageCode,
                          onChanged: (String? languageCode) {
                            setAndStoreLanguage(languageCode);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // tire pressure unit
                    SettingCard(
                      icon: FluentIcons.auto_racing,
                      title: 'settings.settings.tire_pressure_unit.title'.tr(),
                      subtitle: 'settings.settings.tire_pressure_unit.subtitle'.tr(),
                      child: SizedBox(
                        width: 100,
                        child: Combobox<TirePressureUnit>(
                          isExpanded: true,
                          items: getTirePressureUnitOptions(),
                          value: settings.tirePressureUnit,
                          onChanged: (tirePressureUnit) {
                            settingsBloc.add(SaveSettings(
                              settingsBloc.state.settings.copyWith(tirePressureUnit: tirePressureUnit!),
                            ));
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // temperature unit
                    SettingCard(
                      icon: FluentIcons.brightness,
                      title: 'settings.settings.temperature_unit.title'.tr(),
                      subtitle: 'settings.settings.temperature_unit.subtitle'.tr(),
                      child: SizedBox(
                        width: 100,
                        child: Combobox<TemperatureUnit>(
                          isExpanded: true,
                          items: getTemperatureUnitOptions(),
                          value: settings.temperatureUnit,
                          onChanged: (temperatureUnit) {
                            settingsBloc.add(SaveSettings(
                              settingsBloc.state.settings.copyWith(temperatureUnit: temperatureUnit!),
                            ));
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // app theme
                    SettingCard(
                      icon: FluentIcons.color,
                      title: 'settings.settings.theme.title'.tr(),
                      subtitle: 'settings.settings.theme.subtitle'.tr(),
                      child: SizedBox(
                        width: 100,
                        child: Combobox<AppTheme>(
                          isExpanded: true,
                          items: getAppThemeOptions(),
                          value: settings.appTheme,
                          onChanged: (appTheme) {
                            settingsBloc.add(SaveSettings(
                              settingsBloc.state.settings.copyWith(appTheme: appTheme!),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InfoBar(title: Text('settings.changes_will_be_saved_automatically'.tr())),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  static List<ComboboxItem<String?>> getLanguageOptions() {
    return <ComboboxItem<String?>>[
      ComboboxItem<String>(child: Text('settings.settings.language.options.default'.tr()), value: null),
      ComboboxItem<String>(child: Text('settings.settings.language.options.english'.tr()), value: 'en'),
      ComboboxItem<String>(child: Text('settings.settings.language.options.dutch'.tr()), value: 'nl'),
    ].lock.unlockView;
  }

  static List<ComboboxItem<TirePressureUnit>> getTirePressureUnitOptions() {
    return const <ComboboxItem<TirePressureUnit>>[
      ComboboxItem<TirePressureUnit>(child: Text('psi'), value: TirePressureUnit.psi),
      ComboboxItem<TirePressureUnit>(child: Text('atm'), value: TirePressureUnit.atm),
      ComboboxItem<TirePressureUnit>(child: Text('bar'), value: TirePressureUnit.bar),
      ComboboxItem<TirePressureUnit>(child: Text('kPa'), value: TirePressureUnit.kpa),
    ].lock.unlockView;
  }

  static List<ComboboxItem<TemperatureUnit>> getTemperatureUnitOptions() {
    return const <ComboboxItem<TemperatureUnit>>[
      ComboboxItem<TemperatureUnit>(child: Text('°C'), value: TemperatureUnit.celcius),
      ComboboxItem<TemperatureUnit>(child: Text('°F'), value: TemperatureUnit.fahrenheit),
    ].lock.unlockView;
  }

  static List<ComboboxItem<AppTheme>> getAppThemeOptions() {
    return <ComboboxItem<AppTheme>>[
      ComboboxItem<AppTheme>(child: Text('settings.settings.theme.options.default'.tr()), value: AppTheme.byDevice),
      ComboboxItem<AppTheme>(child: Text('settings.settings.theme.options.light'.tr()), value: AppTheme.light),
      ComboboxItem<AppTheme>(child: Text('settings.settings.theme.options.dark'.tr()), value: AppTheme.dark),
    ].lock.unlockView;
  }

  void setAndStoreLanguage(String? languageCode) {
    // save setting
    settingsBloc.add(SaveSettings(
      settingsBloc.state.settings.copyWith(languageCode: languageCode),
    ));

    // set UI
    if (languageCode != null) {
      // user picked an actual language option
      context.setLocale(Locale(languageCode));
    } else {
      // user picked 'default' option (meaning: set to device language with fallback)

      // note: we should be able to use context.resetLocale() but
      // it force sets the locale to the first device preferred locale even if not supported
      // by us; this will make Flutter crash :(

      // check if we support any locales the user has set as preferred in their OS
      Locale? supportedLocale = WidgetsBinding.instance!.window.locales.firstOrNullWhere((deviceLocale) =>
          context.supportedLocales.any((supportedLocale) => supportedLocale.languageCode == deviceLocale.languageCode));

      if (supportedLocale != null) {
        context.setLocale(Locale(supportedLocale.languageCode));
      } else {
        context.setLocale(context.fallbackLocale!);
      }
    }
  }
}
