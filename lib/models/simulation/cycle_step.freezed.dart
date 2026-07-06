// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CycleStep _$CycleStepFromJson(Map<String, dynamic> json) {
  return _CycleStep.fromJson(json);
}

/// @nodoc
mixin _$CycleStep {
  int get cycleIndex => throw _privateConstructorUsedError;
  List<TileAction> get actions => throw _privateConstructorUsedError;
  BoardModel get boardSnapshot => throw _privateConstructorUsedError;

  /// Serializes this CycleStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CycleStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CycleStepCopyWith<CycleStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CycleStepCopyWith<$Res> {
  factory $CycleStepCopyWith(CycleStep value, $Res Function(CycleStep) then) =
      _$CycleStepCopyWithImpl<$Res, CycleStep>;
  @useResult
  $Res call({
    int cycleIndex,
    List<TileAction> actions,
    BoardModel boardSnapshot,
  });

  $BoardModelCopyWith<$Res> get boardSnapshot;
}

/// @nodoc
class _$CycleStepCopyWithImpl<$Res, $Val extends CycleStep>
    implements $CycleStepCopyWith<$Res> {
  _$CycleStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CycleStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cycleIndex = null,
    Object? actions = null,
    Object? boardSnapshot = null,
  }) {
    return _then(
      _value.copyWith(
            cycleIndex: null == cycleIndex
                ? _value.cycleIndex
                : cycleIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            actions: null == actions
                ? _value.actions
                : actions // ignore: cast_nullable_to_non_nullable
                      as List<TileAction>,
            boardSnapshot: null == boardSnapshot
                ? _value.boardSnapshot
                : boardSnapshot // ignore: cast_nullable_to_non_nullable
                      as BoardModel,
          )
          as $Val,
    );
  }

  /// Create a copy of CycleStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardModelCopyWith<$Res> get boardSnapshot {
    return $BoardModelCopyWith<$Res>(_value.boardSnapshot, (value) {
      return _then(_value.copyWith(boardSnapshot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CycleStepImplCopyWith<$Res>
    implements $CycleStepCopyWith<$Res> {
  factory _$$CycleStepImplCopyWith(
    _$CycleStepImpl value,
    $Res Function(_$CycleStepImpl) then,
  ) = __$$CycleStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int cycleIndex,
    List<TileAction> actions,
    BoardModel boardSnapshot,
  });

  @override
  $BoardModelCopyWith<$Res> get boardSnapshot;
}

/// @nodoc
class __$$CycleStepImplCopyWithImpl<$Res>
    extends _$CycleStepCopyWithImpl<$Res, _$CycleStepImpl>
    implements _$$CycleStepImplCopyWith<$Res> {
  __$$CycleStepImplCopyWithImpl(
    _$CycleStepImpl _value,
    $Res Function(_$CycleStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CycleStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cycleIndex = null,
    Object? actions = null,
    Object? boardSnapshot = null,
  }) {
    return _then(
      _$CycleStepImpl(
        cycleIndex: null == cycleIndex
            ? _value.cycleIndex
            : cycleIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        actions: null == actions
            ? _value._actions
            : actions // ignore: cast_nullable_to_non_nullable
                  as List<TileAction>,
        boardSnapshot: null == boardSnapshot
            ? _value.boardSnapshot
            : boardSnapshot // ignore: cast_nullable_to_non_nullable
                  as BoardModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CycleStepImpl implements _CycleStep {
  const _$CycleStepImpl({
    required this.cycleIndex,
    final List<TileAction> actions = const [],
    required this.boardSnapshot,
  }) : _actions = actions;

  factory _$CycleStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$CycleStepImplFromJson(json);

  @override
  final int cycleIndex;
  final List<TileAction> _actions;
  @override
  @JsonKey()
  List<TileAction> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @override
  final BoardModel boardSnapshot;

  @override
  String toString() {
    return 'CycleStep(cycleIndex: $cycleIndex, actions: $actions, boardSnapshot: $boardSnapshot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CycleStepImpl &&
            (identical(other.cycleIndex, cycleIndex) ||
                other.cycleIndex == cycleIndex) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.boardSnapshot, boardSnapshot) ||
                other.boardSnapshot == boardSnapshot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cycleIndex,
    const DeepCollectionEquality().hash(_actions),
    boardSnapshot,
  );

  /// Create a copy of CycleStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CycleStepImplCopyWith<_$CycleStepImpl> get copyWith =>
      __$$CycleStepImplCopyWithImpl<_$CycleStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CycleStepImplToJson(this);
  }
}

abstract class _CycleStep implements CycleStep {
  const factory _CycleStep({
    required final int cycleIndex,
    final List<TileAction> actions,
    required final BoardModel boardSnapshot,
  }) = _$CycleStepImpl;

  factory _CycleStep.fromJson(Map<String, dynamic> json) =
      _$CycleStepImpl.fromJson;

  @override
  int get cycleIndex;
  @override
  List<TileAction> get actions;
  @override
  BoardModel get boardSnapshot;

  /// Create a copy of CycleStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CycleStepImplCopyWith<_$CycleStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
