// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/misc/converter.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';

class TireInfo extends StatelessWidget {
  final Tire tire;
  final bool ignoreTireLayout;
  final VoidCallback switchToManualSensorSelection;
  final VoidCallback switchToAutoSensorSelection;

  const TireInfo({
    super.key,
    required this.tire,
    required this.ignoreTireLayout,
    required this.switchToManualSensorSelection,
    required this.switchToAutoSensorSelection,
  });

  @override
  Widget build(BuildContext context) {
    if (tire.isUnconfigured && tire.sensorAutoPair) {
      // auto pair enabled
      return DottedBorder(
        child: Column(
          children: [
            const RepaintBoundary(child: ProgressRing()),
            const SizedBox(height: 20),
            Text('home.vehicle_card.finding_sensor'.tr(), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            TextButton(
              onPressed: switchToManualSensorSelection,
              child: Text('home.vehicle_card.select_manually_instead'.tr(), textAlign: TextAlign.center),
            ),
          ],
        ),
      );
    } else if (tire.isUnconfigured && !tire.sensorAutoPair) {
      // manual pair enabled
      return DottedBorder(
        child: Column(
          children: [
            TextButton(
              onPressed: switchToManualSensorSelection,
              child: Text('home.vehicle_card.select_sensor'.tr()),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: switchToAutoSensorSelection,
              child: Text('home.vehicle_card.auto_find_sensor'.tr(), textAlign: TextAlign.center),
            ),
          ],
        ),
      );
    }

    // sensor is configured
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Row(
          textDirection: getTextDirection(tire.locationOnVehicle),
          children: [
            // text info
            Column(
              verticalDirection: getVerticalDirection(tire.locationOnVehicle),
              crossAxisAlignment: getColumnCrossAxisAlignment(tire.locationOnVehicle),
              mainAxisSize: MainAxisSize.min,
              children: [
                // tire pressure
                Row(
                  textDirection: getTextDirection(tire.locationOnVehicle),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Converter().kPaToUnitFormatted(tire.lastTirePressureKPa!, state.settings.tirePressureUnit),
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(width: 5),
                    Text(Converter().getPressureSymbol(state.settings.tirePressureUnit)),
                  ],
                ),
                const SizedBox(height: 20),

                // temperature
                if (tire.lastTemperatureCelcius != null) ...[
                  Row(
                    textDirection: getTextDirection(tire.locationOnVehicle),
                    children: [
                      const SizedBox(width: 10),
                      Glow(
                        glowColor: getTemperatureIconGlowColor(tire),
                        glowRadius: 15,
                        child: Icon(
                          ms.FluentIcons.temperature_16_regular,
                          color: getTemperatureIconColor(tire),
                        ),
                      ),
                      Text(
                        '${Converter().celciusToUnitFormatted(tire.lastTemperatureCelcius!, state.settings.temperatureUnit)} ${Converter().getTemperatureSymbol(state.settings.temperatureUnit)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],

                // battery
                if (tire.lastBatteryPercentage != null) ...[
                  Row(
                    textDirection: getTextDirection(tire.locationOnVehicle),
                    children: [
                      const SizedBox(width: 10),
                      Glow(
                        glowColor: getBatteryIconGlowColor(tire),
                        glowRadius: 15,
                        child: Icon(
                          getBatteryIconData(tire.lastBatteryPercentage!),
                          color: getBatteryIconColor(tire),
                        ),
                      ),
                      Text("${tire.lastBatteryPercentage!.toStringAsFixed(0)} %"),
                    ],
                  ),
                ],
              ],
            ),

            // indicator
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                verticalDirection: getVerticalDirection(tire.locationOnVehicle),
                textDirection: getTextDirection(tire.locationOnVehicle),
                children: [
                  Builder(builder: (context) {
                    if (tire.sensorUnavailable) {
                      return Glow(
                        glowRadius: 15,
                        glowColor: Colors.red,
                        child: Icon(ms.FluentIcons.bluetooth_searching_24_regular, color: Colors.orange),
                      );
                    } else if (tire.warning) {
                      return Icon(ms.FluentIcons.warning_12_filled, color: Colors.orange, size: 24);
                    } else if (tire.critical) {
                      return Icon(ms.FluentIcons.error_circle_12_filled, color: Colors.red, size: 24);
                    }
                    return Icon(ms.FluentIcons.checkmark_circle_12_regular, color: Colors.green, size: 24);
                  }),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  VerticalDirection getVerticalDirection(TireLocation tireLocation) {
    if (ignoreTireLayout) {
      return VerticalDirection.down;
    }

    switch (tireLocation) {
      case TireLocation.front:
      case TireLocation.frontLeft:
      case TireLocation.frontRight:
      case TireLocation.frontCenter:
        return VerticalDirection.down;
      case TireLocation.rear:
      case TireLocation.rearLeft:
      case TireLocation.rearRight:
      case TireLocation.rearCenter:
      case TireLocation.unknown:
        return VerticalDirection.up;
    }
  }

  ui.TextDirection getTextDirection(TireLocation tireLocation) {
    if (ignoreTireLayout || tireLocation == null) {
      return ui.TextDirection.ltr;
    }

    switch (tireLocation) {
      case TireLocation.frontLeft:
      case TireLocation.rearLeft:
        return ui.TextDirection.ltr;
      case TireLocation.frontRight:
      case TireLocation.rearRight:
        return ui.TextDirection.rtl;
      case TireLocation.front:
      case TireLocation.frontCenter:
      case TireLocation.rear:
      case TireLocation.rearCenter:
      case TireLocation.unknown:
        return ui.TextDirection.ltr;
    }
  }

  AlignmentGeometry getIndicatorAlignment(TireLocation tireLocation) {
    if (ignoreTireLayout) {
      return Alignment.center;
    }

    switch (tireLocation) {
      case TireLocation.frontLeft:
        return Alignment.centerRight;
      case TireLocation.rearLeft:
        return Alignment.centerRight;
      case TireLocation.frontRight:
        return Alignment.centerLeft;
      case TireLocation.rearRight:
        return Alignment.centerLeft;
      case TireLocation.front:
      case TireLocation.frontCenter:
      case TireLocation.rear:
      case TireLocation.rearCenter:
      case TireLocation.unknown:
        return Alignment.center;
    }
  }

  CrossAxisAlignment getColumnCrossAxisAlignment(TireLocation tireLocation) {
    if (ignoreTireLayout || tireLocation == null) {
      return CrossAxisAlignment.start;
    }

    switch (tireLocation) {
      case TireLocation.frontLeft:
      case TireLocation.rearLeft:
        return CrossAxisAlignment.start;
      case TireLocation.frontRight:
      case TireLocation.rearRight:
        return CrossAxisAlignment.end;
      case TireLocation.front:
      case TireLocation.frontCenter:
      case TireLocation.rear:
      case TireLocation.rearCenter:
      case TireLocation.unknown:
        return CrossAxisAlignment.start;
    }
  }

  IconData getBatteryIconData(double batteryPercentage) {
    if (batteryPercentage < 10) {
      return ms.FluentIcons.battery_0_20_regular;
    } else if (batteryPercentage < 20) {
      return ms.FluentIcons.battery_1_20_regular;
    } else if (batteryPercentage < 30) {
      return ms.FluentIcons.battery_2_20_regular;
    } else if (batteryPercentage < 40) {
      return ms.FluentIcons.battery_3_20_regular;
    } else if (batteryPercentage < 50) {
      return ms.FluentIcons.battery_4_20_regular;
    } else if (batteryPercentage < 60) {
      return ms.FluentIcons.battery_5_20_regular;
    } else if (batteryPercentage < 70) {
      return ms.FluentIcons.battery_6_20_regular;
    } else if (batteryPercentage < 80) {
      return ms.FluentIcons.battery_7_20_regular;
    } else if (batteryPercentage < 90) {
      return ms.FluentIcons.battery_8_20_regular;
    } else {
      return ms.FluentIcons.battery_9_20_regular;
    }
  }

  Color getBatteryIconColor(Tire tire) {
    if (tire.batteryCritical) {
      return Colors.red;
    } else if (tire.batteryWarning) {
      return Colors.orange;
    }
    return Colors.green;
  }

  Color? getBatteryIconGlowColor(Tire tire) {
    if (tire.batteryCritical) {
      return Colors.red;
    } else if (tire.batteryWarning) {
      return Colors.orange;
    }
    return null;
  }

  Color getTemperatureIconColor(Tire tire) {
    if (tire.temperatureIsCritical) {
      return Colors.red;
    } else if (tire.temperatureWarning) {
      return Colors.yellow;
    }
    return Colors.blue;
  }

  Color? getTemperatureIconGlowColor(Tire tire) {
    if (tire.temperatureIsCritical) {
      return Colors.red;
    } else if (tire.temperatureWarning) {
      return Colors.yellow;
    }
    return null;
  }
}
