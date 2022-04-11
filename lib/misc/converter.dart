// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:universal_tpms_reader/models/application/_enums.dart';

class Converter {
  double kPaToUnit(double valueInKPa, TirePressureUnit convertToUnit) {
    switch (convertToUnit) {
      case TirePressureUnit.psi:
        return valueInKPa / 6.89475728;
      case TirePressureUnit.bar:
        return valueInKPa / 100;
      case TirePressureUnit.atm:
        return valueInKPa / 101.325;
      case TirePressureUnit.kpa:
        return valueInKPa;
    }
  }

  String kPaToUnitFormatted(double valueInKPa, TirePressureUnit convertToUnit) {
    int fractionDigits;
    switch (convertToUnit) {
      case TirePressureUnit.psi:
      case TirePressureUnit.kpa:
        fractionDigits = 0;
        break;
      case TirePressureUnit.bar:
      case TirePressureUnit.atm:
        fractionDigits = 1;
        break;
    }

    return kPaToUnit(valueInKPa, convertToUnit).toStringAsFixed(fractionDigits);
  }

  String getPressureSymbol(TirePressureUnit unit) {
    switch (unit) {
      case TirePressureUnit.psi:
        return 'psi';
      case TirePressureUnit.bar:
        return 'bar';
      case TirePressureUnit.atm:
        return 'atm';
      case TirePressureUnit.kpa:
        return 'kPa';
    }
  }

  double celciusToUnit(double valueInCelcius, TemperatureUnit convertToUnit) {
    switch (convertToUnit) {
      case TemperatureUnit.celcius:
        return valueInCelcius;
      case TemperatureUnit.fahrenheit:
        return valueInCelcius * 1.8 + 32;
    }
  }

  String celciusToUnitFormatted(double valueInCelcius, TemperatureUnit convertToUnit) {
    return celciusToUnit(valueInCelcius, convertToUnit).toStringAsFixed(1);
  }

  String getTemperatureSymbol(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celcius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
    }
  }
}
