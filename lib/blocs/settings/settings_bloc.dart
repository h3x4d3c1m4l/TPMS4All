// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';
import 'package:universal_tpms_reader/models/application/settings.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

/// BLoC that uses shared_preferences to load and save settings (e.g. language, units of measure).
/// 
/// Note: This does not manage vehicle and/or tire data persistence. For those look at VehicleManagerBloc.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.withDefaultSettings()) {
    on<LoadSettingsFromStorageEvent>(_onLoadSettingsFromStorage);
    on<SaveSettings>(_onSaveSettingsEvent, transformer: sequential());
    on<WriteSettingsToStorage>(_onWriteSettingsToStorageEvent, transformer: sequential());
  }

  FutureOr<void> _onLoadSettingsFromStorage(LoadSettingsFromStorageEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(
      isInitialized: true,
      settings: await _readSettings(),
    ));
  }

  FutureOr<void> _onSaveSettingsEvent(SaveSettings event, Emitter<SettingsState> emit) {
    emit(state.copyWith(settings: event.settings));
    add(WriteSettingsToStorage(event.settings));
  }

  FutureOr<void> _onWriteSettingsToStorageEvent(WriteSettingsToStorage event, Emitter<SettingsState> emit) async {
    await _writeSettings(event.settings);
  }

  static Future<Settings> _readSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultSettings = Settings.withDefaults();

    return Settings(
      languageCode: prefs.getString('languageCode') ?? defaultSettings.languageCode,
      tirePressureUnit:
          TirePressureUnit.values[prefs.getInt('tirePressureUnit') ?? defaultSettings.tirePressureUnit.index],
      temperatureUnit: TemperatureUnit.values[prefs.getInt('temperatureUnit') ?? defaultSettings.temperatureUnit.index],
      appTheme: AppTheme.values[prefs.getInt('appTheme') ?? defaultSettings.appTheme.index],
    );
  }

  static Future<void> _writeSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();

    if (settings.languageCode != null) {
      await prefs.setString('languageCode', settings.languageCode!);
    } else {
      await prefs.remove('languageCode');
    }
    await prefs.setInt('tirePressureUnit', settings.tirePressureUnit.index);
    await prefs.setInt('temperatureUnit', settings.temperatureUnit.index);
    await prefs.setInt('appTheme', settings.appTheme.index);
  }
}
