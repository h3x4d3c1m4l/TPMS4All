// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SettingsTearOff {
  const _$SettingsTearOff();

  _Settings call(
      {String? languageCode,
      required TirePressureUnit tirePressureUnit,
      required TemperatureUnit temperatureUnit,
      required AppTheme appTheme}) {
    return _Settings(
      languageCode: languageCode,
      tirePressureUnit: tirePressureUnit,
      temperatureUnit: temperatureUnit,
      appTheme: appTheme,
    );
  }
}

/// @nodoc
const $Settings = _$SettingsTearOff();

/// @nodoc
mixin _$Settings {
  String? get languageCode => throw _privateConstructorUsedError;
  TirePressureUnit get tirePressureUnit => throw _privateConstructorUsedError;
  TemperatureUnit get temperatureUnit => throw _privateConstructorUsedError;
  AppTheme get appTheme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res>;
  $Res call(
      {String? languageCode,
      TirePressureUnit tirePressureUnit,
      TemperatureUnit temperatureUnit,
      AppTheme appTheme});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res> implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  final Settings _value;
  // ignore: unused_field
  final $Res Function(Settings) _then;

  @override
  $Res call({
    Object? languageCode = freezed,
    Object? tirePressureUnit = freezed,
    Object? temperatureUnit = freezed,
    Object? appTheme = freezed,
  }) {
    return _then(_value.copyWith(
      languageCode: languageCode == freezed
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      tirePressureUnit: tirePressureUnit == freezed
          ? _value.tirePressureUnit
          : tirePressureUnit // ignore: cast_nullable_to_non_nullable
              as TirePressureUnit,
      temperatureUnit: temperatureUnit == freezed
          ? _value.temperatureUnit
          : temperatureUnit // ignore: cast_nullable_to_non_nullable
              as TemperatureUnit,
      appTheme: appTheme == freezed
          ? _value.appTheme
          : appTheme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
    ));
  }
}

/// @nodoc
abstract class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) then) =
      __$SettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? languageCode,
      TirePressureUnit tirePressureUnit,
      TemperatureUnit temperatureUnit,
      AppTheme appTheme});
}

/// @nodoc
class __$SettingsCopyWithImpl<$Res> extends _$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(_Settings _value, $Res Function(_Settings) _then)
      : super(_value, (v) => _then(v as _Settings));

  @override
  _Settings get _value => super._value as _Settings;

  @override
  $Res call({
    Object? languageCode = freezed,
    Object? tirePressureUnit = freezed,
    Object? temperatureUnit = freezed,
    Object? appTheme = freezed,
  }) {
    return _then(_Settings(
      languageCode: languageCode == freezed
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      tirePressureUnit: tirePressureUnit == freezed
          ? _value.tirePressureUnit
          : tirePressureUnit // ignore: cast_nullable_to_non_nullable
              as TirePressureUnit,
      temperatureUnit: temperatureUnit == freezed
          ? _value.temperatureUnit
          : temperatureUnit // ignore: cast_nullable_to_non_nullable
              as TemperatureUnit,
      appTheme: appTheme == freezed
          ? _value.appTheme
          : appTheme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
    ));
  }
}

/// @nodoc

class _$_Settings extends _Settings {
  const _$_Settings(
      {this.languageCode,
      required this.tirePressureUnit,
      required this.temperatureUnit,
      required this.appTheme})
      : super._();

  @override
  final String? languageCode;
  @override
  final TirePressureUnit tirePressureUnit;
  @override
  final TemperatureUnit temperatureUnit;
  @override
  final AppTheme appTheme;

  @override
  String toString() {
    return 'Settings(languageCode: $languageCode, tirePressureUnit: $tirePressureUnit, temperatureUnit: $temperatureUnit, appTheme: $appTheme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Settings &&
            const DeepCollectionEquality()
                .equals(other.languageCode, languageCode) &&
            const DeepCollectionEquality()
                .equals(other.tirePressureUnit, tirePressureUnit) &&
            const DeepCollectionEquality()
                .equals(other.temperatureUnit, temperatureUnit) &&
            const DeepCollectionEquality().equals(other.appTheme, appTheme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(languageCode),
      const DeepCollectionEquality().hash(tirePressureUnit),
      const DeepCollectionEquality().hash(temperatureUnit),
      const DeepCollectionEquality().hash(appTheme));

  @JsonKey(ignore: true)
  @override
  _$SettingsCopyWith<_Settings> get copyWith =>
      __$SettingsCopyWithImpl<_Settings>(this, _$identity);
}

abstract class _Settings extends Settings {
  const factory _Settings(
      {String? languageCode,
      required TirePressureUnit tirePressureUnit,
      required TemperatureUnit temperatureUnit,
      required AppTheme appTheme}) = _$_Settings;
  const _Settings._() : super._();

  @override
  String? get languageCode;
  @override
  TirePressureUnit get tirePressureUnit;
  @override
  TemperatureUnit get temperatureUnit;
  @override
  AppTheme get appTheme;
  @override
  @JsonKey(ignore: true)
  _$SettingsCopyWith<_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}
