// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) {
  return _LevelModel.fromJson(json);
}

/// @nodoc
mixin _$LevelModel {
  int get id => throw _privateConstructorUsedError;
  int get world => throw _privateConstructorUsedError;
  LevelTier get tier => throw _privateConstructorUsedError;
  BoardModel get board => throw _privateConstructorUsedError;
  ObjectiveModel get objective => throw _privateConstructorUsedError;
  int get minimumMoves => throw _privateConstructorUsedError;
  List<String> get solutionMoves => throw _privateConstructorUsedError;

  /// Serializes this LevelModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LevelModelCopyWith<LevelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelModelCopyWith<$Res> {
  factory $LevelModelCopyWith(
    LevelModel value,
    $Res Function(LevelModel) then,
  ) = _$LevelModelCopyWithImpl<$Res, LevelModel>;
  @useResult
  $Res call({
    int id,
    int world,
    LevelTier tier,
    BoardModel board,
    ObjectiveModel objective,
    int minimumMoves,
    List<String> solutionMoves,
  });

  $BoardModelCopyWith<$Res> get board;
  $ObjectiveModelCopyWith<$Res> get objective;
}

/// @nodoc
class _$LevelModelCopyWithImpl<$Res, $Val extends LevelModel>
    implements $LevelModelCopyWith<$Res> {
  _$LevelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? world = null,
    Object? tier = null,
    Object? board = null,
    Object? objective = null,
    Object? minimumMoves = null,
    Object? solutionMoves = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            world: null == world
                ? _value.world
                : world // ignore: cast_nullable_to_non_nullable
                      as int,
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as LevelTier,
            board: null == board
                ? _value.board
                : board // ignore: cast_nullable_to_non_nullable
                      as BoardModel,
            objective: null == objective
                ? _value.objective
                : objective // ignore: cast_nullable_to_non_nullable
                      as ObjectiveModel,
            minimumMoves: null == minimumMoves
                ? _value.minimumMoves
                : minimumMoves // ignore: cast_nullable_to_non_nullable
                      as int,
            solutionMoves: null == solutionMoves
                ? _value.solutionMoves
                : solutionMoves // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardModelCopyWith<$Res> get board {
    return $BoardModelCopyWith<$Res>(_value.board, (value) {
      return _then(_value.copyWith(board: value) as $Val);
    });
  }

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ObjectiveModelCopyWith<$Res> get objective {
    return $ObjectiveModelCopyWith<$Res>(_value.objective, (value) {
      return _then(_value.copyWith(objective: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LevelModelImplCopyWith<$Res>
    implements $LevelModelCopyWith<$Res> {
  factory _$$LevelModelImplCopyWith(
    _$LevelModelImpl value,
    $Res Function(_$LevelModelImpl) then,
  ) = __$$LevelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int world,
    LevelTier tier,
    BoardModel board,
    ObjectiveModel objective,
    int minimumMoves,
    List<String> solutionMoves,
  });

  @override
  $BoardModelCopyWith<$Res> get board;
  @override
  $ObjectiveModelCopyWith<$Res> get objective;
}

/// @nodoc
class __$$LevelModelImplCopyWithImpl<$Res>
    extends _$LevelModelCopyWithImpl<$Res, _$LevelModelImpl>
    implements _$$LevelModelImplCopyWith<$Res> {
  __$$LevelModelImplCopyWithImpl(
    _$LevelModelImpl _value,
    $Res Function(_$LevelModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? world = null,
    Object? tier = null,
    Object? board = null,
    Object? objective = null,
    Object? minimumMoves = null,
    Object? solutionMoves = null,
  }) {
    return _then(
      _$LevelModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        world: null == world
            ? _value.world
            : world // ignore: cast_nullable_to_non_nullable
                  as int,
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as LevelTier,
        board: null == board
            ? _value.board
            : board // ignore: cast_nullable_to_non_nullable
                  as BoardModel,
        objective: null == objective
            ? _value.objective
            : objective // ignore: cast_nullable_to_non_nullable
                  as ObjectiveModel,
        minimumMoves: null == minimumMoves
            ? _value.minimumMoves
            : minimumMoves // ignore: cast_nullable_to_non_nullable
                  as int,
        solutionMoves: null == solutionMoves
            ? _value._solutionMoves
            : solutionMoves // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelModelImpl implements _LevelModel {
  const _$LevelModelImpl({
    required this.id,
    required this.world,
    required this.tier,
    required this.board,
    required this.objective,
    required this.minimumMoves,
    final List<String> solutionMoves = const [],
  }) : _solutionMoves = solutionMoves;

  factory _$LevelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelModelImplFromJson(json);

  @override
  final int id;
  @override
  final int world;
  @override
  final LevelTier tier;
  @override
  final BoardModel board;
  @override
  final ObjectiveModel objective;
  @override
  final int minimumMoves;
  final List<String> _solutionMoves;
  @override
  @JsonKey()
  List<String> get solutionMoves {
    if (_solutionMoves is EqualUnmodifiableListView) return _solutionMoves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_solutionMoves);
  }

  @override
  String toString() {
    return 'LevelModel(id: $id, world: $world, tier: $tier, board: $board, objective: $objective, minimumMoves: $minimumMoves, solutionMoves: $solutionMoves)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.world, world) || other.world == world) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.board, board) || other.board == board) &&
            (identical(other.objective, objective) ||
                other.objective == objective) &&
            (identical(other.minimumMoves, minimumMoves) ||
                other.minimumMoves == minimumMoves) &&
            const DeepCollectionEquality().equals(
              other._solutionMoves,
              _solutionMoves,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    world,
    tier,
    board,
    objective,
    minimumMoves,
    const DeepCollectionEquality().hash(_solutionMoves),
  );

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelModelImplCopyWith<_$LevelModelImpl> get copyWith =>
      __$$LevelModelImplCopyWithImpl<_$LevelModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelModelImplToJson(this);
  }
}

abstract class _LevelModel implements LevelModel {
  const factory _LevelModel({
    required final int id,
    required final int world,
    required final LevelTier tier,
    required final BoardModel board,
    required final ObjectiveModel objective,
    required final int minimumMoves,
    final List<String> solutionMoves,
  }) = _$LevelModelImpl;

  factory _LevelModel.fromJson(Map<String, dynamic> json) =
      _$LevelModelImpl.fromJson;

  @override
  int get id;
  @override
  int get world;
  @override
  LevelTier get tier;
  @override
  BoardModel get board;
  @override
  ObjectiveModel get objective;
  @override
  int get minimumMoves;
  @override
  List<String> get solutionMoves;

  /// Create a copy of LevelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelModelImplCopyWith<_$LevelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
