// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool isInitialized,
    required Settings settings,
    required IList<String> availableTranslations,
  }) = _SettingsState;
  const SettingsState._();

  factory SettingsState.initial() => SettingsState(
        isInitialized: false,
        settings: Settings.withDefaults(),
        availableTranslations: const IListConst([]),
      );
}
