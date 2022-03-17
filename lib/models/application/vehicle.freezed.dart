// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VehicleTearOff {
  const _$VehicleTearOff();

  _Vehicle call(
      {required UuidValue uuid,
      required VehicleType? type,
      required String name,
      required DateTime added,
      required Color color,
      required IList<Tire> tires}) {
    return _Vehicle(
      uuid: uuid,
      type: type,
      name: name,
      added: added,
      color: color,
      tires: tires,
    );
  }
}

/// @nodoc
const $Vehicle = _$VehicleTearOff();

/// @nodoc
mixin _$Vehicle {
  UuidValue get uuid => throw _privateConstructorUsedError;
  VehicleType? get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get added => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;
  IList<Tire> get tires => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res>;
  $Res call(
      {UuidValue uuid,
      VehicleType? type,
      String name,
      DateTime added,
      Color color,
      IList<Tire> tires});
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res> implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  final Vehicle _value;
  // ignore: unused_field
  final $Res Function(Vehicle) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? added = freezed,
    Object? color = freezed,
    Object? tires = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VehicleType?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      added: added == freezed
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as DateTime,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      tires: tires == freezed
          ? _value.tires
          : tires // ignore: cast_nullable_to_non_nullable
              as IList<Tire>,
    ));
  }
}

/// @nodoc
abstract class _$VehicleCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$VehicleCopyWith(_Vehicle value, $Res Function(_Vehicle) then) =
      __$VehicleCopyWithImpl<$Res>;
  @override
  $Res call(
      {UuidValue uuid,
      VehicleType? type,
      String name,
      DateTime added,
      Color color,
      IList<Tire> tires});
}

/// @nodoc
class __$VehicleCopyWithImpl<$Res> extends _$VehicleCopyWithImpl<$Res>
    implements _$VehicleCopyWith<$Res> {
  __$VehicleCopyWithImpl(_Vehicle _value, $Res Function(_Vehicle) _then)
      : super(_value, (v) => _then(v as _Vehicle));

  @override
  _Vehicle get _value => super._value as _Vehicle;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? added = freezed,
    Object? color = freezed,
    Object? tires = freezed,
  }) {
    return _then(_Vehicle(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as VehicleType?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      added: added == freezed
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as DateTime,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      tires: tires == freezed
          ? _value.tires
          : tires // ignore: cast_nullable_to_non_nullable
              as IList<Tire>,
    ));
  }
}

/// @nodoc

class _$_Vehicle extends _Vehicle {
  const _$_Vehicle(
      {required this.uuid,
      required this.type,
      required this.name,
      required this.added,
      required this.color,
      required this.tires})
      : super._();

  @override
  final UuidValue uuid;
  @override
  final VehicleType? type;
  @override
  final String name;
  @override
  final DateTime added;
  @override
  final Color color;
  @override
  final IList<Tire> tires;

  @override
  String toString() {
    return 'Vehicle(uuid: $uuid, type: $type, name: $name, added: $added, color: $color, tires: $tires)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Vehicle &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.added, added) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.tires, tires));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(added),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(tires));

  @JsonKey(ignore: true)
  @override
  _$VehicleCopyWith<_Vehicle> get copyWith =>
      __$VehicleCopyWithImpl<_Vehicle>(this, _$identity);
}

abstract class _Vehicle extends Vehicle {
  const factory _Vehicle(
      {required UuidValue uuid,
      required VehicleType? type,
      required String name,
      required DateTime added,
      required Color color,
      required IList<Tire> tires}) = _$_Vehicle;
  const _Vehicle._() : super._();

  @override
  UuidValue get uuid;
  @override
  VehicleType? get type;
  @override
  String get name;
  @override
  DateTime get added;
  @override
  Color get color;
  @override
  IList<Tire> get tires;
  @override
  @JsonKey(ignore: true)
  _$VehicleCopyWith<_Vehicle> get copyWith =>
      throw _privateConstructorUsedError;
}
