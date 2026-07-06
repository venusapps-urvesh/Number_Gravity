// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationResult _$SimulationResultFromJson(Map<String, dynamic> json) {
  return _SimulationResult.fromJson(json);
}

/// @nodoc
mixin _$SimulationResult {
  List<CycleStep> get steps => throw _privateConstructorUsedError;
  BoardModel get finalBoard => throw _privateConstructorUsedError;
  bool get isStable => throw _privateConstructorUsedError;
  bool get hitCycleCap => throw _privateConstructorUsedError;

  /// Serializes this SimulationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationResultCopyWith<SimulationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationResultCopyWith<$Res> {
  factory $SimulationResultCopyWith(
    SimulationResult value,
    $Res Function(SimulationResult) then,
  ) = _$SimulationResultCopyWithImpl<$Res, SimulationResult>;
  @useResult
  $Res call({
    List<CycleStep> steps,
    BoardModel finalBoard,
    bool isStable,
    bool hitCycleCap,
  });

  $BoardModelCopyWith<$Res> get finalBoard;
}

/// @nodoc
class _$SimulationResultCopyWithImpl<$Res, $Val extends SimulationResult>
    implements $SimulationResultCopyWith<$Res> {
  _$SimulationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? finalBoard = null,
    Object? isStable = null,
    Object? hitCycleCap = null,
  }) {
    return _then(
      _value.copyWith(
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<CycleStep>,
            finalBoard: null == finalBoard
                ? _value.finalBoard
                : finalBoard // ignore: cast_nullable_to_non_nullable
                      as BoardModel,
            isStable: null == isStable
                ? _value.isStable
                : isStable // ignore: cast_nullable_to_non_nullable
                      as bool,
            hitCycleCap: null == hitCycleCap
                ? _value.hitCycleCap
                : hitCycleCap // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardModelCopyWith<$Res> get finalBoard {
    return $BoardModelCopyWith<$Res>(_value.finalBoard, (value) {
      return _then(_value.copyWith(finalBoard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SimulationResultImplCopyWith<$Res>
    implements $SimulationResultCopyWith<$Res> {
  factory _$$SimulationResultImplCopyWith(
    _$SimulationResultImpl value,
    $Res Function(_$SimulationResultImpl) then,
  ) = __$$SimulationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<CycleStep> steps,
    BoardModel finalBoard,
    bool isStable,
    bool hitCycleCap,
  });

  @override
  $BoardModelCopyWith<$Res> get finalBoard;
}

/// @nodoc
class __$$SimulationResultImplCopyWithImpl<$Res>
    extends _$SimulationResultCopyWithImpl<$Res, _$SimulationResultImpl>
    implements _$$SimulationResultImplCopyWith<$Res> {
  __$$SimulationResultImplCopyWithImpl(
    _$SimulationResultImpl _value,
    $Res Function(_$SimulationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? finalBoard = null,
    Object? isStable = null,
    Object? hitCycleCap = null,
  }) {
    return _then(
      _$SimulationResultImpl(
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<CycleStep>,
        finalBoard: null == finalBoard
            ? _value.finalBoard
            : finalBoard // ignore: cast_nullable_to_non_nullable
                  as BoardModel,
        isStable: null == isStable
            ? _value.isStable
            : isStable // ignore: cast_nullable_to_non_nullable
                  as bool,
        hitCycleCap: null == hitCycleCap
            ? _value.hitCycleCap
            : hitCycleCap // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationResultImpl implements _SimulationResult {
  const _$SimulationResultImpl({
    final List<CycleStep> steps = const [],
    required this.finalBoard,
    this.isStable = true,
    this.hitCycleCap = false,
  }) : _steps = steps;

  factory _$SimulationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationResultImplFromJson(json);

  final List<CycleStep> _steps;
  @override
  @JsonKey()
  List<CycleStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final BoardModel finalBoard;
  @override
  @JsonKey()
  final bool isStable;
  @override
  @JsonKey()
  final bool hitCycleCap;

  @override
  String toString() {
    return 'SimulationResult(steps: $steps, finalBoard: $finalBoard, isStable: $isStable, hitCycleCap: $hitCycleCap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationResultImpl &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.finalBoard, finalBoard) ||
                other.finalBoard == finalBoard) &&
            (identical(other.isStable, isStable) ||
                other.isStable == isStable) &&
            (identical(other.hitCycleCap, hitCycleCap) ||
                other.hitCycleCap == hitCycleCap));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_steps),
    finalBoard,
    isStable,
    hitCycleCap,
  );

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationResultImplCopyWith<_$SimulationResultImpl> get copyWith =>
      __$$SimulationResultImplCopyWithImpl<_$SimulationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationResultImplToJson(this);
  }
}

abstract class _SimulationResult implements SimulationResult {
  const factory _SimulationResult({
    final List<CycleStep> steps,
    required final BoardModel finalBoard,
    final bool isStable,
    final bool hitCycleCap,
  }) = _$SimulationResultImpl;

  factory _SimulationResult.fromJson(Map<String, dynamic> json) =
      _$SimulationResultImpl.fromJson;

  @override
  List<CycleStep> get steps;
  @override
  BoardModel get finalBoard;
  @override
  bool get isStable;
  @override
  bool get hitCycleCap;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationResultImplCopyWith<_$SimulationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
