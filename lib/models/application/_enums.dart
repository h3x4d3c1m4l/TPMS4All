// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

// DON'T CHANGE ANY EXISTING VALUES, AS THIS COULD CHANGE NUMERIC VALUES

enum BleScanMode {
  opportunistic,
  lowPower,
  balanced,
  lowLatency,
}

enum TirePressureUnit {
  psi,
  bar,
  atm,
  kpa,
}

enum TemperatureUnit {
  celcius,
  fahrenheit,
}

enum AppTheme {
  byDevice,
  light,
  dark,
}

enum VehicleType {
  car,
  motorcycle,
}

enum TireLocation {
  front,
  rear,
  frontLeft,
  frontRight,
  frontCenter,
  rearLeft,
  rearRight,
  rearCenter,
}