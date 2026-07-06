// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'force_vector.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ForceVector _$ForceVectorFromJson(Map<String, dynamic> json) {
  return _ForceVector.fromJson(json);
}

/// @nodoc
mixin _$ForceVector {
  String get sourceTileId => throw _privateConstructorUsedError;
  String get targetTileId => throw _privateConstructorUsedError;
  double get force => throw _privateConstructorUsedError;
  Direction get direction => throw _privateConstructorUsedError;
  bool get isRepulsion => throw _privateConstructorUsedError;

  /// Serializes this ForceVector to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForceVector
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForceVectorCopyWith<ForceVector> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForceVectorCopyWith<$Res> {
  factory $ForceVectorCopyWith(
    ForceVector value,
    $Res Function(ForceVector) then,
  ) = _$ForceVectorCopyWithImpl<$Res, ForceVector>;
  @useResult
  $Res call({
    String sourceTileId,
    String targetTileId,
    double force,
    Direction direction,
    bool isRepulsion,
  });
}

/// @nodoc
class _$ForceVectorCopyWithImpl<$Res, $Val extends ForceVector>
    implements $ForceVectorCopyWith<$Res> {
  _$ForceVectorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForceVector
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceTileId = null,
    Object? targetTileId = null,
    Object? force = null,
    Object? direction = null,
    Object? isRepulsion = null,
  }) {
    return _then(
      _value.copyWith(
            sourceTileId: null == sourceTileId
                ? _value.sourceTileId
                : sourceTileId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetTileId: null == targetTileId
                ? _value.targetTileId
                : targetTileId // ignore: cast_nullable_to_non_nullable
                      as String,
            force: null == force
                ? _value.force
                : force // ignore: cast_nullable_to_non_nullable
                      as double,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as Direction,
            isRepulsion: null == isRepulsion
                ? _value.isRepulsion
                : isRepulsion // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForceVectorImplCopyWith<$Res>
    implements $ForceVectorCopyWith<$Res> {
  factory _$$ForceVectorImplCopyWith(
    _$ForceVectorImpl value,
    $Res Function(_$ForceVectorImpl) then,
  ) = __$$ForceVectorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sourceTileId,
    String targetTileId,
    double force,
    Direction direction,
    bool isRepulsion,
  });
}

/// @nodoc
class __$$ForceVectorImplCopyWithImpl<$Res>
    extends _$ForceVectorCopyWithImpl<$Res, _$ForceVectorImpl>
    implements _$$ForceVectorImplCopyWith<$Res> {
  __$$ForceVectorImplCopyWithImpl(
    _$ForceVectorImpl _value,
    $Res Function(_$ForceVectorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForceVector
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceTileId = null,
    Object? targetTileId = null,
    Object? force = null,
    Object? direction = null,
    Object? isRepulsion = null,
  }) {
    return _then(
      _$ForceVectorImpl(
        sourceTileId: null == sourceTileId
            ? _value.sourceTileId
            : sourceTileId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetTileId: null == targetTileId
            ? _value.targetTileId
            : targetTileId // ignore: cast_nullable_to_non_nullable
                  as String,
        force: null == force
            ? _value.force
            : force // ignore: cast_nullable_to_non_nullable
                  as double,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as Direction,
        isRepulsion: null == isRepulsion
            ? _value.isRepulsion
            : isRepulsion // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForceVectorImpl implements _ForceVector {
  const _$ForceVectorImpl({
    required this.sourceTileId,
    required this.targetTileId,
    required this.force,
    required this.direction,
    required this.isRepulsion,
  });

  factory _$ForceVectorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForceVectorImplFromJson(json);

  @override
  final String sourceTileId;
  @override
  final String targetTileId;
  @override
  final double force;
  @override
  final Direction direction;
  @override
  final bool isRepulsion;

  @override
  String toString() {
    return 'ForceVector(sourceTileId: $sourceTileId, targetTileId: $targetTileId, force: $force, direction: $direction, isRepulsion: $isRepulsion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForceVectorImpl &&
            (identical(other.sourceTileId, sourceTileId) ||
                other.sourceTileId == sourceTileId) &&
            (identical(other.targetTileId, targetTileId) ||
                other.targetTileId == targetTileId) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.isRepulsion, isRepulsion) ||
                other.isRepulsion == isRepulsion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    sourceTileId,
    targetTileId,
    force,
    direction,
    isRepulsion,
  );

  /// Create a copy of ForceVector
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForceVectorImplCopyWith<_$ForceVectorImpl> get copyWith =>
      __$$ForceVectorImplCopyWithImpl<_$ForceVectorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForceVectorImplToJson(this);
  }
}

abstract class _ForceVector implements ForceVector {
  const factory _ForceVector({
    required final String sourceTileId,
    required final String targetTileId,
    required final double force,
    required final Direction direction,
    required final bool isRepulsion,
  }) = _$ForceVectorImpl;

  factory _ForceVector.fromJson(Map<String, dynamic> json) =
      _$ForceVectorImpl.fromJson;

  @override
  String get sourceTileId;
  @override
  String get targetTileId;
  @override
  double get force;
  @override
  Direction get direction;
  @override
  bool get isRepulsion;

  /// Create a copy of ForceVector
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForceVectorImplCopyWith<_$ForceVectorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
