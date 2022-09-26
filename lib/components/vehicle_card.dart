// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:uuid/uuid.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final bool initiallyExpanded;
  final void Function(UuidValue) switchToManualSensorSelection;
  final void Function(UuidValue) switchToAutoSensorSelection;

  const VehicleCard({
    super.key,
    required this.vehicle,
    this.initiallyExpanded = false,
    required this.switchToManualSensorSelection,
    required this.switchToAutoSensorSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Expander(
      // indicator LED
      leading: Glow(
        glowColor: vehicle.critical
            ? Colors.red
            : vehicle.warning
                ? Colors.orange
                : Colors.green,
        glowRadius: 10,
        repeat: vehicle.critical || vehicle.warning,
        child: LedIndicator(
          color: vehicle.critical
              ? LedColor.red
              : vehicle.warning
                  ? LedColor.orange
                  : vehicle.unconfigured
                      ? null
                      : LedColor.green,
          size: 8,
        ),
      ),

      // vehicle name + type icon
      header: Row(
        children: [
          Text(vehicle.name),
          if (vehicle.type == VehicleType.unknown) const SizedBox(width: 5),
          if (vehicle.type == VehicleType.car) const Icon(ms.FluentIcons.vehicle_car_profile_ltr_16_regular),
          if (vehicle.type == VehicleType.motorcycle) const Icon(FluentIcons.cycling),
        ],
      ),

      // Bluetooth state icon
      trailing: vehicle.unconfigured
          ? const Glow(
              glowRadius: 20,
              child: Icon(ms.FluentIcons.bluetooth_disabled_24_regular, color: Colors.grey),
            )
          : vehicle.anySensorUnavailable
              ? Glow(
                  glowRadius: 20,
                  glowColor: Colors.red,
                  child: Icon(ms.FluentIcons.bluetooth_searching_24_regular, color: Colors.orange),
                )
              : Glow(
                  glowRadius: 20,
                  glowColor: Colors.blue,
                  repeat: false,
                  child: Icon(ms.FluentIcons.bluetooth_connected_24_filled, color: Colors.blue),
                ),

      // tire info, use hack to block long press for content
      content: Column(
        children: [
          // 2x2 grid with tire info
          TireLayoutGrid(
            crossAxisCount: 2,
            children: vehicle.tires
                .sort((a, b) => a.locationOnVehicle.index.compareTo(b.locationOnVehicle.index))
                .map(
                  (t) => TireInfo(
                    tire: t,
                    ignoreTireLayout: false,
                    switchToManualSensorSelection: () => switchToManualSensorSelection(t.uuid),
                    switchToAutoSensorSelection: () => switchToAutoSensorSelection(t.uuid),
                  ),
                )
                .toList(),
          ),

          // warnings
          const SizedBox(height: 20),
          if (vehicle.someSensorsUnavailable && !vehicle.unconfigured)
            Text(
              'home.vehicle_card.some_sensors_unavailable'.tr(),
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          if (vehicle.allSensorUnavailable && !vehicle.unconfigured)
            Text(
              'home.vehicle_card.all_sensors_unavailable'.tr(),
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          if (vehicle.unconfigured)
            Text(
              'home.vehicle_card.sensors_not_configured'.tr(),
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
        ],
      ),

      initiallyExpanded: initiallyExpanded,
    );
  }
}
