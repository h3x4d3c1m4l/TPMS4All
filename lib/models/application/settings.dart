// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_tpms_reader/models/application/_enums.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    String? languageCode,
    required TirePressureUnit tirePressureUnit,
    required TemperatureUnit temperatureUnit,
    required AppTheme appTheme,
    required IList<String> firstStartKeys,
    required int firstStartBuild,
    required String firstStartVersion,
  }) = _Settings;
  const Settings._();

  factory Settings.withDefaults() => Settings(
        tirePressureUnit: TirePressureUnit.bar,
        temperatureUnit: TemperatureUnit.celcius,
        appTheme: AppTheme.byDevice,
        firstStartKeys: const IListConst<String>([]),
        firstStartBuild: int.parse(GetIt.I<PackageInfo>().buildNumber),
        firstStartVersion: GetIt.I<PackageInfo>().version,
      );
}
