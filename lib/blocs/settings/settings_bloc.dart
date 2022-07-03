// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/application/settings.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

/// BLoC that uses shared_preferences to load and save settings (e.g. language, units of measure).
///
/// Note: This does not manage vehicle and/or tire data persistence. For those look at VehiclesBloc.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late SharedPreferences _sharedPreferences;

  SettingsBloc() : super(SettingsState.initial()) {
    on<_SettingsBlocCreated>(_onBlocCreated);
    on<_SettingsChanged>(_onChanged, transformer: sequential());
    on<_SettingsEmitted>(_onEmitted, transformer: sequential());
  }

  FutureOr<void> _onBlocCreated(_SettingsBlocCreated event, Emitter<SettingsState> emit) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    emit(state.copyWith(
      isInitialized: true,
      settings: await _readSettings(),
      availableTranslations: await _getKnownLanguageCodes(),
    ));
  }

  FutureOr<void> _onChanged(_SettingsChanged event, Emitter<SettingsState> emit) {
    if (event.settings != state.settings) {
      emit(state.copyWith(settings: event.settings));
      add(_SettingsEmitted(event.settings));
    }
  }

  FutureOr<void> _onEmitted(_SettingsEmitted event, Emitter<SettingsState> emit) async {
    await _writeSettings(event.settings);
  }

  Future<Settings> _readSettings() async {
    final defaultSettings = Settings.withDefaults();

    return Settings(
      languageCode: _sharedPreferences.getString('languageCode') ?? defaultSettings.languageCode,
      tirePressureUnit: TirePressureUnit
          .values[_sharedPreferences.getInt('tirePressureUnit') ?? defaultSettings.tirePressureUnit.index],
      temperatureUnit:
          TemperatureUnit.values[_sharedPreferences.getInt('temperatureUnit') ?? defaultSettings.temperatureUnit.index],
      appTheme: AppTheme.values[_sharedPreferences.getInt('appTheme') ?? defaultSettings.appTheme.index],
      firstStartKeys: _sharedPreferences.getStringList('firstStartKeys')?.lock ?? const IListConst([]),
      firstStartBuild: _sharedPreferences.getInt('firstStartBuild') ?? defaultSettings.firstStartBuild,
      firstStartVersion: _sharedPreferences.getString('firstStartVersion') ?? defaultSettings.firstStartVersion,
    );
  }

  Future<void> _writeSettings(Settings settings) async {
    if (settings.languageCode != null) {
      await _sharedPreferences.setString('languageCode', settings.languageCode!);
    } else {
      await _sharedPreferences.remove('languageCode');
    }
    await _sharedPreferences.setInt('tirePressureUnit', settings.tirePressureUnit.index);
    await _sharedPreferences.setInt('temperatureUnit', settings.temperatureUnit.index);
    await _sharedPreferences.setInt('appTheme', settings.appTheme.index);
    await _sharedPreferences.setStringList('firstStartKeys', settings.firstStartKeys.unlockView);
    await _sharedPreferences.setInt('firstStartBuild', settings.firstStartBuild);
    await _sharedPreferences.setString('firstStartVersion', settings.firstStartVersion);
  }

  Future<IList<String>> _getKnownLanguageCodes() async {
    // get resource map
    final String manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent) as Map<String, dynamic>;

    // get language codes from file names
    const String translationsPath = 'assets/translations';
    return manifestMap.keys
        .where((fileName) => path.dirname(fileName) == translationsPath)
        .map((fileName) => path.basenameWithoutExtension(fileName))
        .toIList();
  }
}
