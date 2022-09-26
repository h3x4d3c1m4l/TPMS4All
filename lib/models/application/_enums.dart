// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

// DON'T CHANGE ANY EXISTING VALUES, AS THIS COULD CHANGE NUMERIC VALUES

import 'package:isar/isar.dart';

enum BleScanMode {
  opportunistic,
  lowPower,
  balanced,
  lowLatency,
}

enum TirePressureUnit {
  psi(0),
  bar(1),
  atm(2),
  kpa(3);

  const TirePressureUnit(this.value);

  final short value;
}

enum TemperatureUnit {
  celcius(0),
  fahrenheit(1);

  const TemperatureUnit(this.value);

  final short value;
}

enum AppTheme {
  byDevice(0),
  light(1),
  dark(2);

  const AppTheme(this.value);

  final short value;
}

enum VehicleType {
  unknown(0),
  car(1),
  motorcycle(2);

  const VehicleType(this.value);

  final short value;
}

enum TireLocation {
  unknown(0),
  front(1),
  rear(2),
  frontLeft(3),
  frontRight(4),
  frontCenter(5),
  rearLeft(6),
  rearRight(7),
  rearCenter(8);

  const TireLocation(this.value);

  final short value;
}
