// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'bluetooth_bloc.dart';

@freezed
class BluetoothState with _$BluetoothState {
  const factory BluetoothState({
    required bool isInitialized,
    required BluetoothScanState scanState,
    required IList<SensorData> foundSensors,
    required bool permissionStatusIsBeingUpdated,
    DateTime? scanStart,
    BleScanMode? scanMode,
    Duration? scanDuration,
    SensorData? lastSeenSensor,
    PermissionStatus? permissionForBluetooth,
    PermissionStatus? permissionForLocation,
  }) = _BluetoothState;
  const BluetoothState._();

  factory BluetoothState.initial() => const BluetoothState(
    isInitialized: false,
    scanState: BluetoothScanState.idle,
    foundSensors: IListConst<SensorData>([]),
    permissionStatusIsBeingUpdated: false,
  );

  bool get bluetoothPermissionsGranted =>
      (permissionForBluetooth == PermissionStatus.granted || permissionForBluetooth == PermissionStatus.limited) &&
      (permissionForLocation == PermissionStatus.granted || permissionForLocation == PermissionStatus.limited);

  bool get bluetoothPermissionsArePermanentlyDenied =>
      permissionForBluetooth == PermissionStatus.permanentlyDenied ||
      permissionForLocation == PermissionStatus.permanentlyDenied;

  bool get bluetoothPermissionsAreDenied =>
      permissionForBluetooth == PermissionStatus.denied || permissionForLocation == PermissionStatus.denied;
}

enum BluetoothScanState {
  idle,
  throttling,
  scanning,
}
