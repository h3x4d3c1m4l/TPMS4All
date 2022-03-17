// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tire.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TireTearOff {
  const _$TireTearOff();

  _Tire call(
      {required UuidValue uuid,
      required TireLocation? locationOnVehicle,
      Uint8List? sensorBtAddress,
      String? sensorSerial,
      String? sensorVendorName,
      String? sensorProductName,
      DateTime? sensorLastSeen,
      required bool sensorAutoPair,
      double? lastTirePressureKPa,
      double? lastTemperatureCelcius,
      double? lastBatteryPercentage,
      bool? lastLeakDetected,
      double? nominalTirePressureKPa,
      double? warnAtTirePressureKPa,
      double? criticalAtTirePressureKPa,
      double? warnAtTemperatureCelcius,
      double? criticalAtTemperatureCelcius}) {
    return _Tire(
      uuid: uuid,
      locationOnVehicle: locationOnVehicle,
      sensorBtAddress: sensorBtAddress,
      sensorSerial: sensorSerial,
      sensorVendorName: sensorVendorName,
      sensorProductName: sensorProductName,
      sensorLastSeen: sensorLastSeen,
      sensorAutoPair: sensorAutoPair,
      lastTirePressureKPa: lastTirePressureKPa,
      lastTemperatureCelcius: lastTemperatureCelcius,
      lastBatteryPercentage: lastBatteryPercentage,
      lastLeakDetected: lastLeakDetected,
      nominalTirePressureKPa: nominalTirePressureKPa,
      warnAtTirePressureKPa: warnAtTirePressureKPa,
      criticalAtTirePressureKPa: criticalAtTirePressureKPa,
      warnAtTemperatureCelcius: warnAtTemperatureCelcius,
      criticalAtTemperatureCelcius: criticalAtTemperatureCelcius,
    );
  }
}

/// @nodoc
const $Tire = _$TireTearOff();

/// @nodoc
mixin _$Tire {
  UuidValue get uuid => throw _privateConstructorUsedError;
  TireLocation? get locationOnVehicle => throw _privateConstructorUsedError;
  Uint8List? get sensorBtAddress => throw _privateConstructorUsedError;
  String? get sensorSerial => throw _privateConstructorUsedError;
  String? get sensorVendorName => throw _privateConstructorUsedError;
  String? get sensorProductName => throw _privateConstructorUsedError;
  DateTime? get sensorLastSeen => throw _privateConstructorUsedError;
  bool get sensorAutoPair => throw _privateConstructorUsedError;
  double? get lastTirePressureKPa => throw _privateConstructorUsedError;
  double? get lastTemperatureCelcius => throw _privateConstructorUsedError;
  double? get lastBatteryPercentage => throw _privateConstructorUsedError;
  bool? get lastLeakDetected => throw _privateConstructorUsedError;
  double? get nominalTirePressureKPa => throw _privateConstructorUsedError;
  double? get warnAtTirePressureKPa => throw _privateConstructorUsedError;
  double? get criticalAtTirePressureKPa => throw _privateConstructorUsedError;
  double? get warnAtTemperatureCelcius => throw _privateConstructorUsedError;
  double? get criticalAtTemperatureCelcius =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TireCopyWith<Tire> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TireCopyWith<$Res> {
  factory $TireCopyWith(Tire value, $Res Function(Tire) then) =
      _$TireCopyWithImpl<$Res>;
  $Res call(
      {UuidValue uuid,
      TireLocation? locationOnVehicle,
      Uint8List? sensorBtAddress,
      String? sensorSerial,
      String? sensorVendorName,
      String? sensorProductName,
      DateTime? sensorLastSeen,
      bool sensorAutoPair,
      double? lastTirePressureKPa,
      double? lastTemperatureCelcius,
      double? lastBatteryPercentage,
      bool? lastLeakDetected,
      double? nominalTirePressureKPa,
      double? warnAtTirePressureKPa,
      double? criticalAtTirePressureKPa,
      double? warnAtTemperatureCelcius,
      double? criticalAtTemperatureCelcius});
}

/// @nodoc
class _$TireCopyWithImpl<$Res> implements $TireCopyWith<$Res> {
  _$TireCopyWithImpl(this._value, this._then);

  final Tire _value;
  // ignore: unused_field
  final $Res Function(Tire) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? locationOnVehicle = freezed,
    Object? sensorBtAddress = freezed,
    Object? sensorSerial = freezed,
    Object? sensorVendorName = freezed,
    Object? sensorProductName = freezed,
    Object? sensorLastSeen = freezed,
    Object? sensorAutoPair = freezed,
    Object? lastTirePressureKPa = freezed,
    Object? lastTemperatureCelcius = freezed,
    Object? lastBatteryPercentage = freezed,
    Object? lastLeakDetected = freezed,
    Object? nominalTirePressureKPa = freezed,
    Object? warnAtTirePressureKPa = freezed,
    Object? criticalAtTirePressureKPa = freezed,
    Object? warnAtTemperatureCelcius = freezed,
    Object? criticalAtTemperatureCelcius = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      locationOnVehicle: locationOnVehicle == freezed
          ? _value.locationOnVehicle
          : locationOnVehicle // ignore: cast_nullable_to_non_nullable
              as TireLocation?,
      sensorBtAddress: sensorBtAddress == freezed
          ? _value.sensorBtAddress
          : sensorBtAddress // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      sensorSerial: sensorSerial == freezed
          ? _value.sensorSerial
          : sensorSerial // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorVendorName: sensorVendorName == freezed
          ? _value.sensorVendorName
          : sensorVendorName // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorProductName: sensorProductName == freezed
          ? _value.sensorProductName
          : sensorProductName // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorLastSeen: sensorLastSeen == freezed
          ? _value.sensorLastSeen
          : sensorLastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sensorAutoPair: sensorAutoPair == freezed
          ? _value.sensorAutoPair
          : sensorAutoPair // ignore: cast_nullable_to_non_nullable
              as bool,
      lastTirePressureKPa: lastTirePressureKPa == freezed
          ? _value.lastTirePressureKPa
          : lastTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      lastTemperatureCelcius: lastTemperatureCelcius == freezed
          ? _value.lastTemperatureCelcius
          : lastTemperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
      lastBatteryPercentage: lastBatteryPercentage == freezed
          ? _value.lastBatteryPercentage
          : lastBatteryPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLeakDetected: lastLeakDetected == freezed
          ? _value.lastLeakDetected
          : lastLeakDetected // ignore: cast_nullable_to_non_nullable
              as bool?,
      nominalTirePressureKPa: nominalTirePressureKPa == freezed
          ? _value.nominalTirePressureKPa
          : nominalTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      warnAtTirePressureKPa: warnAtTirePressureKPa == freezed
          ? _value.warnAtTirePressureKPa
          : warnAtTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      criticalAtTirePressureKPa: criticalAtTirePressureKPa == freezed
          ? _value.criticalAtTirePressureKPa
          : criticalAtTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      warnAtTemperatureCelcius: warnAtTemperatureCelcius == freezed
          ? _value.warnAtTemperatureCelcius
          : warnAtTemperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
      criticalAtTemperatureCelcius: criticalAtTemperatureCelcius == freezed
          ? _value.criticalAtTemperatureCelcius
          : criticalAtTemperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$TireCopyWith<$Res> implements $TireCopyWith<$Res> {
  factory _$TireCopyWith(_Tire value, $Res Function(_Tire) then) =
      __$TireCopyWithImpl<$Res>;
  @override
  $Res call(
      {UuidValue uuid,
      TireLocation? locationOnVehicle,
      Uint8List? sensorBtAddress,
      String? sensorSerial,
      String? sensorVendorName,
      String? sensorProductName,
      DateTime? sensorLastSeen,
      bool sensorAutoPair,
      double? lastTirePressureKPa,
      double? lastTemperatureCelcius,
      double? lastBatteryPercentage,
      bool? lastLeakDetected,
      double? nominalTirePressureKPa,
      double? warnAtTirePressureKPa,
      double? criticalAtTirePressureKPa,
      double? warnAtTemperatureCelcius,
      double? criticalAtTemperatureCelcius});
}

/// @nodoc
class __$TireCopyWithImpl<$Res> extends _$TireCopyWithImpl<$Res>
    implements _$TireCopyWith<$Res> {
  __$TireCopyWithImpl(_Tire _value, $Res Function(_Tire) _then)
      : super(_value, (v) => _then(v as _Tire));

  @override
  _Tire get _value => super._value as _Tire;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? locationOnVehicle = freezed,
    Object? sensorBtAddress = freezed,
    Object? sensorSerial = freezed,
    Object? sensorVendorName = freezed,
    Object? sensorProductName = freezed,
    Object? sensorLastSeen = freezed,
    Object? sensorAutoPair = freezed,
    Object? lastTirePressureKPa = freezed,
    Object? lastTemperatureCelcius = freezed,
    Object? lastBatteryPercentage = freezed,
    Object? lastLeakDetected = freezed,
    Object? nominalTirePressureKPa = freezed,
    Object? warnAtTirePressureKPa = freezed,
    Object? criticalAtTirePressureKPa = freezed,
    Object? warnAtTemperatureCelcius = freezed,
    Object? criticalAtTemperatureCelcius = freezed,
  }) {
    return _then(_Tire(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      locationOnVehicle: locationOnVehicle == freezed
          ? _value.locationOnVehicle
          : locationOnVehicle // ignore: cast_nullable_to_non_nullable
              as TireLocation?,
      sensorBtAddress: sensorBtAddress == freezed
          ? _value.sensorBtAddress
          : sensorBtAddress // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      sensorSerial: sensorSerial == freezed
          ? _value.sensorSerial
          : sensorSerial // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorVendorName: sensorVendorName == freezed
          ? _value.sensorVendorName
          : sensorVendorName // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorProductName: sensorProductName == freezed
          ? _value.sensorProductName
          : sensorProductName // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorLastSeen: sensorLastSeen == freezed
          ? _value.sensorLastSeen
          : sensorLastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sensorAutoPair: sensorAutoPair == freezed
          ? _value.sensorAutoPair
          : sensorAutoPair // ignore: cast_nullable_to_non_nullable
              as bool,
      lastTirePressureKPa: lastTirePressureKPa == freezed
          ? _value.lastTirePressureKPa
          : lastTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      lastTemperatureCelcius: lastTemperatureCelcius == freezed
          ? _value.lastTemperatureCelcius
          : lastTemperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
      lastBatteryPercentage: lastBatteryPercentage == freezed
          ? _value.lastBatteryPercentage
          : lastBatteryPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      lastLeakDetected: lastLeakDetected == freezed
          ? _value.lastLeakDetected
          : lastLeakDetected // ignore: cast_nullable_to_non_nullable
              as bool?,
      nominalTirePressureKPa: nominalTirePressureKPa == freezed
          ? _value.nominalTirePressureKPa
          : nominalTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      warnAtTirePressureKPa: warnAtTirePressureKPa == freezed
          ? _value.warnAtTirePressureKPa
          : warnAtTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      criticalAtTirePressureKPa: criticalAtTirePressureKPa == freezed
          ? _value.criticalAtTirePressureKPa
          : criticalAtTirePressureKPa // ignore: cast_nullable_to_non_nullable
              as double?,
      warnAtTemperatureCelcius: warnAtTemperatureCelcius == freezed
          ? _value.warnAtTemperatureCelcius
          : warnAtTemperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
      criticalAtTemperatureCelcius: criticalAtTemperatureCelcius == freezed
          ? _value.criticalAtTemperatureCelcius
          : criticalAtTemperatureCelcius // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_Tire extends _Tire {
  const _$_Tire(
      {required this.uuid,
      required this.locationOnVehicle,
      this.sensorBtAddress,
      this.sensorSerial,
      this.sensorVendorName,
      this.sensorProductName,
      this.sensorLastSeen,
      required this.sensorAutoPair,
      this.lastTirePressureKPa,
      this.lastTemperatureCelcius,
      this.lastBatteryPercentage,
      this.lastLeakDetected,
      this.nominalTirePressureKPa,
      this.warnAtTirePressureKPa,
      this.criticalAtTirePressureKPa,
      this.warnAtTemperatureCelcius,
      this.criticalAtTemperatureCelcius})
      : super._();

  @override
  final UuidValue uuid;
  @override
  final TireLocation? locationOnVehicle;
  @override
  final Uint8List? sensorBtAddress;
  @override
  final String? sensorSerial;
  @override
  final String? sensorVendorName;
  @override
  final String? sensorProductName;
  @override
  final DateTime? sensorLastSeen;
  @override
  final bool sensorAutoPair;
  @override
  final double? lastTirePressureKPa;
  @override
  final double? lastTemperatureCelcius;
  @override
  final double? lastBatteryPercentage;
  @override
  final bool? lastLeakDetected;
  @override
  final double? nominalTirePressureKPa;
  @override
  final double? warnAtTirePressureKPa;
  @override
  final double? criticalAtTirePressureKPa;
  @override
  final double? warnAtTemperatureCelcius;
  @override
  final double? criticalAtTemperatureCelcius;

  @override
  String toString() {
    return 'Tire(uuid: $uuid, locationOnVehicle: $locationOnVehicle, sensorBtAddress: $sensorBtAddress, sensorSerial: $sensorSerial, sensorVendorName: $sensorVendorName, sensorProductName: $sensorProductName, sensorLastSeen: $sensorLastSeen, sensorAutoPair: $sensorAutoPair, lastTirePressureKPa: $lastTirePressureKPa, lastTemperatureCelcius: $lastTemperatureCelcius, lastBatteryPercentage: $lastBatteryPercentage, lastLeakDetected: $lastLeakDetected, nominalTirePressureKPa: $nominalTirePressureKPa, warnAtTirePressureKPa: $warnAtTirePressureKPa, criticalAtTirePressureKPa: $criticalAtTirePressureKPa, warnAtTemperatureCelcius: $warnAtTemperatureCelcius, criticalAtTemperatureCelcius: $criticalAtTemperatureCelcius)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tire &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality()
                .equals(other.locationOnVehicle, locationOnVehicle) &&
            const DeepCollectionEquality()
                .equals(other.sensorBtAddress, sensorBtAddress) &&
            const DeepCollectionEquality()
                .equals(other.sensorSerial, sensorSerial) &&
            const DeepCollectionEquality()
                .equals(other.sensorVendorName, sensorVendorName) &&
            const DeepCollectionEquality()
                .equals(other.sensorProductName, sensorProductName) &&
            const DeepCollectionEquality()
                .equals(other.sensorLastSeen, sensorLastSeen) &&
            const DeepCollectionEquality()
                .equals(other.sensorAutoPair, sensorAutoPair) &&
            const DeepCollectionEquality()
                .equals(other.lastTirePressureKPa, lastTirePressureKPa) &&
            const DeepCollectionEquality()
                .equals(other.lastTemperatureCelcius, lastTemperatureCelcius) &&
            const DeepCollectionEquality()
                .equals(other.lastBatteryPercentage, lastBatteryPercentage) &&
            const DeepCollectionEquality()
                .equals(other.lastLeakDetected, lastLeakDetected) &&
            const DeepCollectionEquality()
                .equals(other.nominalTirePressureKPa, nominalTirePressureKPa) &&
            const DeepCollectionEquality()
                .equals(other.warnAtTirePressureKPa, warnAtTirePressureKPa) &&
            const DeepCollectionEquality().equals(
                other.criticalAtTirePressureKPa, criticalAtTirePressureKPa) &&
            const DeepCollectionEquality().equals(
                other.warnAtTemperatureCelcius, warnAtTemperatureCelcius) &&
            const DeepCollectionEquality().equals(
                other.criticalAtTemperatureCelcius,
                criticalAtTemperatureCelcius));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(locationOnVehicle),
      const DeepCollectionEquality().hash(sensorBtAddress),
      const DeepCollectionEquality().hash(sensorSerial),
      const DeepCollectionEquality().hash(sensorVendorName),
      const DeepCollectionEquality().hash(sensorProductName),
      const DeepCollectionEquality().hash(sensorLastSeen),
      const DeepCollectionEquality().hash(sensorAutoPair),
      const DeepCollectionEquality().hash(lastTirePressureKPa),
      const DeepCollectionEquality().hash(lastTemperatureCelcius),
      const DeepCollectionEquality().hash(lastBatteryPercentage),
      const DeepCollectionEquality().hash(lastLeakDetected),
      const DeepCollectionEquality().hash(nominalTirePressureKPa),
      const DeepCollectionEquality().hash(warnAtTirePressureKPa),
      const DeepCollectionEquality().hash(criticalAtTirePressureKPa),
      const DeepCollectionEquality().hash(warnAtTemperatureCelcius),
      const DeepCollectionEquality().hash(criticalAtTemperatureCelcius));

  @JsonKey(ignore: true)
  @override
  _$TireCopyWith<_Tire> get copyWith =>
      __$TireCopyWithImpl<_Tire>(this, _$identity);
}

abstract class _Tire extends Tire {
  const factory _Tire(
      {required UuidValue uuid,
      required TireLocation? locationOnVehicle,
      Uint8List? sensorBtAddress,
      String? sensorSerial,
      String? sensorVendorName,
      String? sensorProductName,
      DateTime? sensorLastSeen,
      required bool sensorAutoPair,
      double? lastTirePressureKPa,
      double? lastTemperatureCelcius,
      double? lastBatteryPercentage,
      bool? lastLeakDetected,
      double? nominalTirePressureKPa,
      double? warnAtTirePressureKPa,
      double? criticalAtTirePressureKPa,
      double? warnAtTemperatureCelcius,
      double? criticalAtTemperatureCelcius}) = _$_Tire;
  const _Tire._() : super._();

  @override
  UuidValue get uuid;
  @override
  TireLocation? get locationOnVehicle;
  @override
  Uint8List? get sensorBtAddress;
  @override
  String? get sensorSerial;
  @override
  String? get sensorVendorName;
  @override
  String? get sensorProductName;
  @override
  DateTime? get sensorLastSeen;
  @override
  bool get sensorAutoPair;
  @override
  double? get lastTirePressureKPa;
  @override
  double? get lastTemperatureCelcius;
  @override
  double? get lastBatteryPercentage;
  @override
  bool? get lastLeakDetected;
  @override
  double? get nominalTirePressureKPa;
  @override
  double? get warnAtTirePressureKPa;
  @override
  double? get criticalAtTirePressureKPa;
  @override
  double? get warnAtTemperatureCelcius;
  @override
  double? get criticalAtTemperatureCelcius;
  @override
  @JsonKey(ignore: true)
  _$TireCopyWith<_Tire> get copyWith => throw _privateConstructorUsedError;
}
