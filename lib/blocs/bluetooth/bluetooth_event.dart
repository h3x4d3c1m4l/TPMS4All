// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'bluetooth_bloc.dart';

@freezed
class BluetoothEvent with _$BluetoothEvent {
  const factory BluetoothEvent.started() = _Started;

  /// Generic event to request a Bluetooth scan.
  const factory BluetoothEvent.setScanMode({
    required BleScanMode scanMode,
    Duration? duration,
    required bool storeSeenSensors,
  }) = SetScanModeRequest;

  /// Event to request a low latency Bluetooth scan.
  factory BluetoothEvent.requestExtensiveScan({
    required Duration duration,
  }) =>
      BluetoothEvent.setScanMode(
        scanMode: BleScanMode.lowLatency,
        duration: duration,
        storeSeenSensors: true,
      );

  /// Event to request a 'balanced' Bluetooth scan.
  factory BluetoothEvent.requestForegroundScan() => const BluetoothEvent.setScanMode(
        scanMode: BleScanMode.balanced,
        storeSeenSensors: false,
      );

  // TODO: add some kind of permanent notification (to be enable by setting) to run this type while the app is minimized
  // factory BluetoothEvent.requestBackgroundScan() => const BluetoothEvent.setScanMode(
  //       scanMode: BleScanMode.lowPower,
  //       storeSeenSensors: false,
  //     );

  /// Event to request updating the BLoC state with current permission state for utilizing Bluetooth
  const factory BluetoothEvent.initialize() = InitializeRequest;

  /// Event to request permissions necessary to utilize Bluetooth.
  const factory BluetoothEvent.requestPermissions() = RequestPermissionsRequest;

  /// Event to cancel the ongoing Bluetooth scan.
  const factory BluetoothEvent.cancelScanEvent() = CancelScanRequest;
}
