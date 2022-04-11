// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    String? languageCode,
    required TirePressureUnit tirePressureUnit,
    required TemperatureUnit temperatureUnit,
    required AppTheme appTheme,
  }) = _Settings;
  const Settings._();

  factory Settings.withDefaults() => const Settings(
        tirePressureUnit: TirePressureUnit.bar,
        temperatureUnit: TemperatureUnit.celcius,
        appTheme: AppTheme.byDevice,
      );
}
