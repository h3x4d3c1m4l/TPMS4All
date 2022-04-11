// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

part of 'bluetooth_bloc.dart';

@freezed
class BluetoothState with _$BluetoothState {
  factory BluetoothState({
    @Default(BluetoothScanState.idle) BluetoothScanState scanState,
    DateTime? scanStart,
    BleScanMode? scanMode,
    Duration? scanDuration,
    @Default(IListConst<SensorInfo>([])) IList<SensorInfo> foundSensors,
    SensorInfo? lastSeenSensor,
    PermissionStatus? permissionForBluetooth,
    PermissionStatus? permissionForLocation,
  }) = _BluetoothState;
  const BluetoothState._();

  factory BluetoothState.defaultState() => BluetoothState();

  bool get bluetoothPermissionsGranted =>
      (permissionForBluetooth == PermissionStatus.granted || permissionForBluetooth == PermissionStatus.limited) &&
      (permissionForLocation == PermissionStatus.granted || permissionForBluetooth == PermissionStatus.limited);
}

enum BluetoothScanState {
  idle,
  throttling,
  scanning,
}
