// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

@immutable
class LoadSettingsFromStorageEvent extends SettingsEvent {}

/// Save updated settings in memory. Also an [WriteSettingsToStorage] event should be sent to
/// persist setting asynchronously.
@immutable
class SaveSettings extends SettingsEvent {
  final Settings settings;

  SaveSettings(this.settings);
}

/// Persist updated settings. This should be send automatically by the handler of the [SaveSettings] event.
@immutable
class WriteSettingsToStorage extends SettingsEvent {
  final Settings settings;

  WriteSettingsToStorage(this.settings);
}
