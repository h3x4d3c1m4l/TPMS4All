// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'bluetooth_bloc.dart';

@Freezed(
  copyWith: false,
  equal: false,
)
class BluetoothEvent with _$BluetoothEvent {
  const factory BluetoothEvent.blocCreated() = _BluetoothBlocCreated;

  /// Generic event to request a Bluetooth scan.
  const factory BluetoothEvent.scanRequested({
    required BleScanMode scanMode,
    Duration? duration,
    required bool storeSeenSensors,
  }) = _BluetoothScanRequested;

  /// Event to request a low latency Bluetooth scan.
  factory BluetoothEvent.extensiveScanRequested({
    required Duration duration,
  }) =>
      BluetoothEvent.scanRequested(
        scanMode: BleScanMode.lowLatency,
        duration: duration,
        storeSeenSensors: true,
      );

  /// Event to request a 'balanced' Bluetooth scan.
  factory BluetoothEvent.foregroundScanRequested() => const BluetoothEvent.scanRequested(
        scanMode: BleScanMode.balanced,
        storeSeenSensors: false,
      );

  /// Event to request permissions necessary to utilize Bluetooth.
  const factory BluetoothEvent.permissionsRequested() = _BluetoothPermissionsRequested;

  /// Event to cancel the ongoing Bluetooth scan.
  const factory BluetoothEvent.scanCancelRequested() = _BluetoothScanCancelRequested;

  // Could Have:
  // add a permanent notification (to be enable by setting) to run the background scan while the app is minimized
  // factory BluetoothEvent.backgroundScanRequested() => const BluetoothEvent.scanRequested(
  //       scanMode: BleScanMode.lowPower,
  //       storeSeenSensors: false,
  //     );
}
