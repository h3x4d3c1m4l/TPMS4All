// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'vehicle_manager_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VehicleManagerStateTearOff {
  const _$VehicleManagerStateTearOff();

  _VehicleManager call(
      {required bool isInitialized, required IList<Vehicle> vehicles}) {
    return _VehicleManager(
      isInitialized: isInitialized,
      vehicles: vehicles,
    );
  }
}

/// @nodoc
const $VehicleManagerState = _$VehicleManagerStateTearOff();

/// @nodoc
mixin _$VehicleManagerState {
  bool get isInitialized => throw _privateConstructorUsedError;
  IList<Vehicle> get vehicles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VehicleManagerStateCopyWith<VehicleManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleManagerStateCopyWith<$Res> {
  factory $VehicleManagerStateCopyWith(
          VehicleManagerState value, $Res Function(VehicleManagerState) then) =
      _$VehicleManagerStateCopyWithImpl<$Res>;
  $Res call({bool isInitialized, IList<Vehicle> vehicles});
}

/// @nodoc
class _$VehicleManagerStateCopyWithImpl<$Res>
    implements $VehicleManagerStateCopyWith<$Res> {
  _$VehicleManagerStateCopyWithImpl(this._value, this._then);

  final VehicleManagerState _value;
  // ignore: unused_field
  final $Res Function(VehicleManagerState) _then;

  @override
  $Res call({
    Object? isInitialized = freezed,
    Object? vehicles = freezed,
  }) {
    return _then(_value.copyWith(
      isInitialized: isInitialized == freezed
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      vehicles: vehicles == freezed
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as IList<Vehicle>,
    ));
  }
}

/// @nodoc
abstract class _$VehicleManagerCopyWith<$Res>
    implements $VehicleManagerStateCopyWith<$Res> {
  factory _$VehicleManagerCopyWith(
          _VehicleManager value, $Res Function(_VehicleManager) then) =
      __$VehicleManagerCopyWithImpl<$Res>;
  @override
  $Res call({bool isInitialized, IList<Vehicle> vehicles});
}

/// @nodoc
class __$VehicleManagerCopyWithImpl<$Res>
    extends _$VehicleManagerStateCopyWithImpl<$Res>
    implements _$VehicleManagerCopyWith<$Res> {
  __$VehicleManagerCopyWithImpl(
      _VehicleManager _value, $Res Function(_VehicleManager) _then)
      : super(_value, (v) => _then(v as _VehicleManager));

  @override
  _VehicleManager get _value => super._value as _VehicleManager;

  @override
  $Res call({
    Object? isInitialized = freezed,
    Object? vehicles = freezed,
  }) {
    return _then(_VehicleManager(
      isInitialized: isInitialized == freezed
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      vehicles: vehicles == freezed
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as IList<Vehicle>,
    ));
  }
}

/// @nodoc

class _$_VehicleManager extends _VehicleManager {
  _$_VehicleManager({required this.isInitialized, required this.vehicles})
      : super._();

  @override
  final bool isInitialized;
  @override
  final IList<Vehicle> vehicles;

  @override
  String toString() {
    return 'VehicleManagerState(isInitialized: $isInitialized, vehicles: $vehicles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VehicleManager &&
            const DeepCollectionEquality()
                .equals(other.isInitialized, isInitialized) &&
            const DeepCollectionEquality().equals(other.vehicles, vehicles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isInitialized),
      const DeepCollectionEquality().hash(vehicles));

  @JsonKey(ignore: true)
  @override
  _$VehicleManagerCopyWith<_VehicleManager> get copyWith =>
      __$VehicleManagerCopyWithImpl<_VehicleManager>(this, _$identity);
}

abstract class _VehicleManager extends VehicleManagerState {
  factory _VehicleManager(
      {required bool isInitialized,
      required IList<Vehicle> vehicles}) = _$_VehicleManager;
  _VehicleManager._() : super._();

  @override
  bool get isInitialized;
  @override
  IList<Vehicle> get vehicles;
  @override
  @JsonKey(ignore: true)
  _$VehicleManagerCopyWith<_VehicleManager> get copyWith =>
      throw _privateConstructorUsedError;
}
