// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'settings_bloc.dart';

@Freezed(
  copyWith: false,
  equal: false,
)
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.blocCreated() = _SettingsBlocCreated;

  /// Save updated settings in memory
  const factory SettingsEvent.settingsChanged(Settings settings) = _SettingsChanged;

  const factory SettingsEvent.settingsEmitted(Settings settings) = _SettingsEmitted;
}
