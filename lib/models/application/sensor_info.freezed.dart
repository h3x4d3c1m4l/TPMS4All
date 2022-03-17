// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sensor_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SensorInfoTearOff {
  const _$SensorInfoTearOff();

  _SensorInfo call(
      {required Uint8List btAddress,
      required String serial,
      required DateTime lastSeen,
      required String vendorName,
      required String productName,
      TireLocation? suggestsLocationOnVehicle,
      required double tirePressureKPa,
      double? temperatureCelcius,
      double? batteryPercentage,
      bool? leakDetected}) {
    return _SensorInfo(
      btAddress: btAddress,
      serial: serial,
      lastSeen: lastSeen,
      vendorName: vendorName,
      productName: productName,
      suggestsLocationOnVehicle: suggestsLocationOnVehicle,
      tirePressureKPa: tirePressureKPa,
      temperatureCelcius: temperatureCelcius,
      batteryPercentage: batteryPercentage,
      leakDetected: leakDetected,
    );
  }
}

/// @nodoc
const $SensorInfo = _$SensorInfoTearOff();

/// @nodoc
mixin _$SensorInfo {
  Uint8List get btAddress => throw _privateConstructorUsedError;
  String get serial => throw _privateConstructorUsedError;
  DateTime get lastSeen => throw _privateConstructorUsedError;
  String get vendorName => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  TireLocation? get suggestsLocationOnVehicle =>
      throw _privateConstructorUsedError;
  double get tirePressureKPa => throw _privateConstructorUsedError;
  double? get temperatureCelcius => throw _privateConstructorUsedError;
  double? get batteryPercentage => throw _privateConstructorUsedError;
  bool? get leakDetected => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SensorInfoCopyWith<SensorInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorInfoCopyWith<$Res> {
  factory $SensorInfoCopyWith(
          SensorInfo value, $Res Function(SensorInfo) then) =
      _$SensorInfoCopyWithImpl<$Res>;
  $Res call(
      {Uint8List btAddress,
      String serial,
      DateTime lastSeen,
      String vendorName,
      String productName,
      TireLocation? suggestsLocationOnVehicle,
      double tirePressureKPa,
      double? temperatureCelcius,
      double? batteryPercentage,
      bool? leakDetected});
}

/// @nodoc
class _$SensorInfoCopyWithImpl<$Res> implements $SensorInfoCopyWith<$Res> {
  _$SensorInfoCopyWithImpl(this._value, this._then);

  final SensorInfo _value;
  // ignore: unused_field
  final $Res Function(SensorInfo) _then;

  @override
  $Res call({
    Object? btAddress = freezed,
    Object? serial = freezed,
    Object? lastSeen = freezed,
    Object? vendorName = freezed,
    Object? productName = freezed,
    Object? suggestsLocationOnVehicle = freezed,
    Object? tirePressureKPa = freezed,
    Object? temperatureCelcius = freezed,
    Object? batteryPercentage = freezed,
    Object? leakDetected = freezed,
  }) {
    return _then(_value.copyWith(
      btAddress: btAddress == freezed
          ? _value.btAddress
          : btAddress // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      serial: serial == freezed
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      lastSeen: lastSeen == freezed
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
      vendorName: vendorName == freezed
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String,
      productName: productName == freezed
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      suggestsLocationOnVehicle: suggestsLocationOnVehicle == freezed
          ? _value.suggestsLocationOnVehicle
          : suggestsLocationOnVehicle // ignore: cast_nullable_to_non_nullable
              as TireLocation?,
      tirePressureKPa: tirePressureKPa == freezed
          ? _value.tirePressureKPa
          : tirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureCelcius: temperatureCelcius == freezed
          ? _value.temperatureCelcius
          : temperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
      batteryPercentage: batteryPercentage == freezed
          ? _value.batteryPercentage
          : batteryPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      leakDetected: leakDetected == freezed
          ? _value.leakDetected
          : leakDetected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$SensorInfoCopyWith<$Res> implements $SensorInfoCopyWith<$Res> {
  factory _$SensorInfoCopyWith(
          _SensorInfo value, $Res Function(_SensorInfo) then) =
      __$SensorInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {Uint8List btAddress,
      String serial,
      DateTime lastSeen,
      String vendorName,
      String productName,
      TireLocation? suggestsLocationOnVehicle,
      double tirePressureKPa,
      double? temperatureCelcius,
      double? batteryPercentage,
      bool? leakDetected});
}

/// @nodoc
class __$SensorInfoCopyWithImpl<$Res> extends _$SensorInfoCopyWithImpl<$Res>
    implements _$SensorInfoCopyWith<$Res> {
  __$SensorInfoCopyWithImpl(
      _SensorInfo _value, $Res Function(_SensorInfo) _then)
      : super(_value, (v) => _then(v as _SensorInfo));

  @override
  _SensorInfo get _value => super._value as _SensorInfo;

  @override
  $Res call({
    Object? btAddress = freezed,
    Object? serial = freezed,
    Object? lastSeen = freezed,
    Object? vendorName = freezed,
    Object? productName = freezed,
    Object? suggestsLocationOnVehicle = freezed,
    Object? tirePressureKPa = freezed,
    Object? temperatureCelcius = freezed,
    Object? batteryPercentage = freezed,
    Object? leakDetected = freezed,
  }) {
    return _then(_SensorInfo(
      btAddress: btAddress == freezed
          ? _value.btAddress
          : btAddress // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      serial: serial == freezed
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String,
      lastSeen: lastSeen == freezed
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
      vendorName: vendorName == freezed
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String,
      productName: productName == freezed
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      suggestsLocationOnVehicle: suggestsLocationOnVehicle == freezed
          ? _value.suggestsLocationOnVehicle
          : suggestsLocationOnVehicle // ignore: cast_nullable_to_non_nullable
              as TireLocation?,
      tirePressureKPa: tirePressureKPa == freezed
          ? _value.tirePressureKPa
          : tirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureCelcius: temperatureCelcius == freezed
          ? _value.temperatureCelcius
          : temperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
      batteryPercentage: batteryPercentage == freezed
          ? _value.batteryPercentage
          : batteryPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      leakDetected: leakDetected == freezed
          ? _value.leakDetected
          : leakDetected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_SensorInfo extends _SensorInfo {
  const _$_SensorInfo(
      {required this.btAddress,
      required this.serial,
      required this.lastSeen,
      required this.vendorName,
      required this.productName,
      this.suggestsLocationOnVehicle,
      required this.tirePressureKPa,
      this.temperatureCelcius,
      this.batteryPercentage,
      this.leakDetected})
      : super._();

  @override
  final Uint8List btAddress;
  @override
  final String serial;
  @override
  final DateTime lastSeen;
  @override
  final String vendorName;
  @override
  final String productName;
  @override
  final TireLocation? suggestsLocationOnVehicle;
  @override
  final double tirePressureKPa;
  @override
  final double? temperatureCelcius;
  @override
  final double? batteryPercentage;
  @override
  final bool? leakDetected;

  @override
  String toString() {
    return 'SensorInfo(btAddress: $btAddress, serial: $serial, lastSeen: $lastSeen, vendorName: $vendorName, productName: $productName, suggestsLocationOnVehicle: $suggestsLocationOnVehicle, tirePressureKPa: $tirePressureKPa, temperatureCelcius: $temperatureCelcius, batteryPercentage: $batteryPercentage, leakDetected: $leakDetected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SensorInfo &&
            const DeepCollectionEquality().equals(other.btAddress, btAddress) &&
            const DeepCollectionEquality().equals(other.serial, serial) &&
            const DeepCollectionEquality().equals(other.lastSeen, lastSeen) &&
            const DeepCollectionEquality()
                .equals(other.vendorName, vendorName) &&
            const DeepCollectionEquality()
                .equals(other.productName, productName) &&
            const DeepCollectionEquality().equals(
                other.suggestsLocationOnVehicle, suggestsLocationOnVehicle) &&
            const DeepCollectionEquality()
                .equals(other.tirePressureKPa, tirePressureKPa) &&
            const DeepCollectionEquality()
                .equals(other.temperatureCelcius, temperatureCelcius) &&
            const DeepCollectionEquality()
                .equals(other.batteryPercentage, batteryPercentage) &&
            const DeepCollectionEquality()
                .equals(other.leakDetected, leakDetected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(btAddress),
      const DeepCollectionEquality().hash(serial),
      const DeepCollectionEquality().hash(lastSeen),
      const DeepCollectionEquality().hash(vendorName),
      const DeepCollectionEquality().hash(productName),
      const DeepCollectionEquality().hash(suggestsLocationOnVehicle),
      const DeepCollectionEquality().hash(tirePressureKPa),
      const DeepCollectionEquality().hash(temperatureCelcius),
      const DeepCollectionEquality().hash(batteryPercentage),
      const DeepCollectionEquality().hash(leakDetected));

  @JsonKey(ignore: true)
  @override
  _$SensorInfoCopyWith<_SensorInfo> get copyWith =>
      __$SensorInfoCopyWithImpl<_SensorInfo>(this, _$identity);
}

abstract class _SensorInfo extends SensorInfo {
  const factory _SensorInfo(
      {required Uint8List btAddress,
      required String serial,
      required DateTime lastSeen,
      required String vendorName,
      required String productName,
      TireLocation? suggestsLocationOnVehicle,
      required double tirePressureKPa,
      double? temperatureCelcius,
      double? batteryPercentage,
      bool? leakDetected}) = _$_SensorInfo;
  const _SensorInfo._() : super._();

  @override
  Uint8List get btAddress;
  @override
  String get serial;
  @override
  DateTime get lastSeen;
  @override
  String get vendorName;
  @override
  String get productName;
  @override
  TireLocation? get suggestsLocationOnVehicle;
  @override
  double get tirePressureKPa;
  @override
  double? get temperatureCelcius;
  @override
  double? get batteryPercentage;
  @override
  bool? get leakDetected;
  @override
  @JsonKey(ignore: true)
  _$SensorInfoCopyWith<_SensorInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
