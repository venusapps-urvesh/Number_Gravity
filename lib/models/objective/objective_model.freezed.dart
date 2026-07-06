// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'objective_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ObjectiveModel _$ObjectiveModelFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'position':
      return PositionObjective.fromJson(json);
    case 'sequence':
      return SequenceObjective.fromJson(json);
    case 'sum':
      return SumObjective.fromJson(json);
    case 'balance':
      return BalanceObjective.fromJson(json);
    case 'collection':
      return CollectionObjective.fromJson(json);
    case 'chain':
      return ChainObjective.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'type',
        'ObjectiveModel',
        'Invalid union type "${json['type']}"!',
      );
  }
}

/// @nodoc
mixin _$ObjectiveModel {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this ObjectiveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObjectiveModelCopyWith<$Res> {
  factory $ObjectiveModelCopyWith(
    ObjectiveModel value,
    $Res Function(ObjectiveModel) then,
  ) = _$ObjectiveModelCopyWithImpl<$Res, ObjectiveModel>;
}

/// @nodoc
class _$ObjectiveModelCopyWithImpl<$Res, $Val extends ObjectiveModel>
    implements $ObjectiveModelCopyWith<$Res> {
  _$ObjectiveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PositionObjectiveImplCopyWith<$Res> {
  factory _$$PositionObjectiveImplCopyWith(
    _$PositionObjectiveImpl value,
    $Res Function(_$PositionObjectiveImpl) then,
  ) = __$$PositionObjectiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tileId, int goalRow, int goalCol});
}

/// @nodoc
class __$$PositionObjectiveImplCopyWithImpl<$Res>
    extends _$ObjectiveModelCopyWithImpl<$Res, _$PositionObjectiveImpl>
    implements _$$PositionObjectiveImplCopyWith<$Res> {
  __$$PositionObjectiveImplCopyWithImpl(
    _$PositionObjectiveImpl _value,
    $Res Function(_$PositionObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? goalRow = null,
    Object? goalCol = null,
  }) {
    return _then(
      _$PositionObjectiveImpl(
        tileId: null == tileId
            ? _value.tileId
            : tileId // ignore: cast_nullable_to_non_nullable
                  as String,
        goalRow: null == goalRow
            ? _value.goalRow
            : goalRow // ignore: cast_nullable_to_non_nullable
                  as int,
        goalCol: null == goalCol
            ? _value.goalCol
            : goalCol // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PositionObjectiveImpl extends PositionObjective {
  const _$PositionObjectiveImpl({
    required this.tileId,
    required this.goalRow,
    required this.goalCol,
    final String? $type,
  }) : $type = $type ?? 'position',
       super._();

  factory _$PositionObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$PositionObjectiveImplFromJson(json);

  @override
  final String tileId;
  @override
  final int goalRow;
  @override
  final int goalCol;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ObjectiveModel.position(tileId: $tileId, goalRow: $goalRow, goalCol: $goalCol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionObjectiveImpl &&
            (identical(other.tileId, tileId) || other.tileId == tileId) &&
            (identical(other.goalRow, goalRow) || other.goalRow == goalRow) &&
            (identical(other.goalCol, goalCol) || other.goalCol == goalCol));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tileId, goalRow, goalCol);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionObjectiveImplCopyWith<_$PositionObjectiveImpl> get copyWith =>
      __$$PositionObjectiveImplCopyWithImpl<_$PositionObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) {
    return position(tileId, goalRow, goalCol);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) {
    return position?.call(tileId, goalRow, goalCol);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) {
    if (position != null) {
      return position(tileId, goalRow, goalCol);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) {
    return position(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) {
    return position?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) {
    if (position != null) {
      return position(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionObjectiveImplToJson(this);
  }
}

abstract class PositionObjective extends ObjectiveModel {
  const factory PositionObjective({
    required final String tileId,
    required final int goalRow,
    required final int goalCol,
  }) = _$PositionObjectiveImpl;
  const PositionObjective._() : super._();

  factory PositionObjective.fromJson(Map<String, dynamic> json) =
      _$PositionObjectiveImpl.fromJson;

  String get tileId;
  int get goalRow;
  int get goalCol;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PositionObjectiveImplCopyWith<_$PositionObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SequenceObjectiveImplCopyWith<$Res> {
  factory _$$SequenceObjectiveImplCopyWith(
    _$SequenceObjectiveImpl value,
    $Res Function(_$SequenceObjectiveImpl) then,
  ) = __$$SequenceObjectiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> tileIds, List<int> targetValues});
}

/// @nodoc
class __$$SequenceObjectiveImplCopyWithImpl<$Res>
    extends _$ObjectiveModelCopyWithImpl<$Res, _$SequenceObjectiveImpl>
    implements _$$SequenceObjectiveImplCopyWith<$Res> {
  __$$SequenceObjectiveImplCopyWithImpl(
    _$SequenceObjectiveImpl _value,
    $Res Function(_$SequenceObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tileIds = null, Object? targetValues = null}) {
    return _then(
      _$SequenceObjectiveImpl(
        tileIds: null == tileIds
            ? _value._tileIds
            : tileIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        targetValues: null == targetValues
            ? _value._targetValues
            : targetValues // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SequenceObjectiveImpl extends SequenceObjective {
  const _$SequenceObjectiveImpl({
    required final List<String> tileIds,
    required final List<int> targetValues,
    final String? $type,
  }) : _tileIds = tileIds,
       _targetValues = targetValues,
       $type = $type ?? 'sequence',
       super._();

  factory _$SequenceObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$SequenceObjectiveImplFromJson(json);

  final List<String> _tileIds;
  @override
  List<String> get tileIds {
    if (_tileIds is EqualUnmodifiableListView) return _tileIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tileIds);
  }

  final List<int> _targetValues;
  @override
  List<int> get targetValues {
    if (_targetValues is EqualUnmodifiableListView) return _targetValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetValues);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ObjectiveModel.sequence(tileIds: $tileIds, targetValues: $targetValues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SequenceObjectiveImpl &&
            const DeepCollectionEquality().equals(other._tileIds, _tileIds) &&
            const DeepCollectionEquality().equals(
              other._targetValues,
              _targetValues,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tileIds),
    const DeepCollectionEquality().hash(_targetValues),
  );

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SequenceObjectiveImplCopyWith<_$SequenceObjectiveImpl> get copyWith =>
      __$$SequenceObjectiveImplCopyWithImpl<_$SequenceObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) {
    return sequence(tileIds, targetValues);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) {
    return sequence?.call(tileIds, targetValues);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) {
    if (sequence != null) {
      return sequence(tileIds, targetValues);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) {
    return sequence(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) {
    return sequence?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) {
    if (sequence != null) {
      return sequence(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SequenceObjectiveImplToJson(this);
  }
}

abstract class SequenceObjective extends ObjectiveModel {
  const factory SequenceObjective({
    required final List<String> tileIds,
    required final List<int> targetValues,
  }) = _$SequenceObjectiveImpl;
  const SequenceObjective._() : super._();

  factory SequenceObjective.fromJson(Map<String, dynamic> json) =
      _$SequenceObjectiveImpl.fromJson;

  List<String> get tileIds;
  List<int> get targetValues;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SequenceObjectiveImplCopyWith<_$SequenceObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SumObjectiveImplCopyWith<$Res> {
  factory _$$SumObjectiveImplCopyWith(
    _$SumObjectiveImpl value,
    $Res Function(_$SumObjectiveImpl) then,
  ) = __$$SumObjectiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> tileIds, int targetSum});
}

/// @nodoc
class __$$SumObjectiveImplCopyWithImpl<$Res>
    extends _$ObjectiveModelCopyWithImpl<$Res, _$SumObjectiveImpl>
    implements _$$SumObjectiveImplCopyWith<$Res> {
  __$$SumObjectiveImplCopyWithImpl(
    _$SumObjectiveImpl _value,
    $Res Function(_$SumObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tileIds = null, Object? targetSum = null}) {
    return _then(
      _$SumObjectiveImpl(
        tileIds: null == tileIds
            ? _value._tileIds
            : tileIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        targetSum: null == targetSum
            ? _value.targetSum
            : targetSum // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SumObjectiveImpl extends SumObjective {
  const _$SumObjectiveImpl({
    required final List<String> tileIds,
    required this.targetSum,
    final String? $type,
  }) : _tileIds = tileIds,
       $type = $type ?? 'sum',
       super._();

  factory _$SumObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$SumObjectiveImplFromJson(json);

  final List<String> _tileIds;
  @override
  List<String> get tileIds {
    if (_tileIds is EqualUnmodifiableListView) return _tileIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tileIds);
  }

  @override
  final int targetSum;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ObjectiveModel.sum(tileIds: $tileIds, targetSum: $targetSum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SumObjectiveImpl &&
            const DeepCollectionEquality().equals(other._tileIds, _tileIds) &&
            (identical(other.targetSum, targetSum) ||
                other.targetSum == targetSum));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tileIds),
    targetSum,
  );

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SumObjectiveImplCopyWith<_$SumObjectiveImpl> get copyWith =>
      __$$SumObjectiveImplCopyWithImpl<_$SumObjectiveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) {
    return sum(tileIds, targetSum);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) {
    return sum?.call(tileIds, targetSum);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) {
    if (sum != null) {
      return sum(tileIds, targetSum);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) {
    return sum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) {
    return sum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) {
    if (sum != null) {
      return sum(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SumObjectiveImplToJson(this);
  }
}

abstract class SumObjective extends ObjectiveModel {
  const factory SumObjective({
    required final List<String> tileIds,
    required final int targetSum,
  }) = _$SumObjectiveImpl;
  const SumObjective._() : super._();

  factory SumObjective.fromJson(Map<String, dynamic> json) =
      _$SumObjectiveImpl.fromJson;

  List<String> get tileIds;
  int get targetSum;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SumObjectiveImplCopyWith<_$SumObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BalanceObjectiveImplCopyWith<$Res> {
  factory _$$BalanceObjectiveImplCopyWith(
    _$BalanceObjectiveImpl value,
    $Res Function(_$BalanceObjectiveImpl) then,
  ) = __$$BalanceObjectiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> regionTileIds, int targetValue});
}

/// @nodoc
class __$$BalanceObjectiveImplCopyWithImpl<$Res>
    extends _$ObjectiveModelCopyWithImpl<$Res, _$BalanceObjectiveImpl>
    implements _$$BalanceObjectiveImplCopyWith<$Res> {
  __$$BalanceObjectiveImplCopyWithImpl(
    _$BalanceObjectiveImpl _value,
    $Res Function(_$BalanceObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regionTileIds = null, Object? targetValue = null}) {
    return _then(
      _$BalanceObjectiveImpl(
        regionTileIds: null == regionTileIds
            ? _value._regionTileIds
            : regionTileIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        targetValue: null == targetValue
            ? _value.targetValue
            : targetValue // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceObjectiveImpl extends BalanceObjective {
  const _$BalanceObjectiveImpl({
    required final List<String> regionTileIds,
    required this.targetValue,
    final String? $type,
  }) : _regionTileIds = regionTileIds,
       $type = $type ?? 'balance',
       super._();

  factory _$BalanceObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceObjectiveImplFromJson(json);

  final List<String> _regionTileIds;
  @override
  List<String> get regionTileIds {
    if (_regionTileIds is EqualUnmodifiableListView) return _regionTileIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regionTileIds);
  }

  @override
  final int targetValue;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ObjectiveModel.balance(regionTileIds: $regionTileIds, targetValue: $targetValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceObjectiveImpl &&
            const DeepCollectionEquality().equals(
              other._regionTileIds,
              _regionTileIds,
            ) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_regionTileIds),
    targetValue,
  );

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceObjectiveImplCopyWith<_$BalanceObjectiveImpl> get copyWith =>
      __$$BalanceObjectiveImplCopyWithImpl<_$BalanceObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) {
    return balance(regionTileIds, targetValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) {
    return balance?.call(regionTileIds, targetValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) {
    if (balance != null) {
      return balance(regionTileIds, targetValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) {
    return balance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) {
    return balance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) {
    if (balance != null) {
      return balance(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceObjectiveImplToJson(this);
  }
}

abstract class BalanceObjective extends ObjectiveModel {
  const factory BalanceObjective({
    required final List<String> regionTileIds,
    required final int targetValue,
  }) = _$BalanceObjectiveImpl;
  const BalanceObjective._() : super._();

  factory BalanceObjective.fromJson(Map<String, dynamic> json) =
      _$BalanceObjectiveImpl.fromJson;

  List<String> get regionTileIds;
  int get targetValue;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceObjectiveImplCopyWith<_$BalanceObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CollectionObjectiveImplCopyWith<$Res> {
  factory _$$CollectionObjectiveImplCopyWith(
    _$CollectionObjectiveImpl value,
    $Res Function(_$CollectionObjectiveImpl) then,
  ) = __$$CollectionObjectiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, List<int>> tileGoals});
}

/// @nodoc
class __$$CollectionObjectiveImplCopyWithImpl<$Res>
    extends _$ObjectiveModelCopyWithImpl<$Res, _$CollectionObjectiveImpl>
    implements _$$CollectionObjectiveImplCopyWith<$Res> {
  __$$CollectionObjectiveImplCopyWithImpl(
    _$CollectionObjectiveImpl _value,
    $Res Function(_$CollectionObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tileGoals = null}) {
    return _then(
      _$CollectionObjectiveImpl(
        tileGoals: null == tileGoals
            ? _value._tileGoals
            : tileGoals // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<int>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionObjectiveImpl extends CollectionObjective {
  const _$CollectionObjectiveImpl({
    required final Map<String, List<int>> tileGoals,
    final String? $type,
  }) : _tileGoals = tileGoals,
       $type = $type ?? 'collection',
       super._();

  factory _$CollectionObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionObjectiveImplFromJson(json);

  final Map<String, List<int>> _tileGoals;
  @override
  Map<String, List<int>> get tileGoals {
    if (_tileGoals is EqualUnmodifiableMapView) return _tileGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tileGoals);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ObjectiveModel.collection(tileGoals: $tileGoals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionObjectiveImpl &&
            const DeepCollectionEquality().equals(
              other._tileGoals,
              _tileGoals,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tileGoals));

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionObjectiveImplCopyWith<_$CollectionObjectiveImpl> get copyWith =>
      __$$CollectionObjectiveImplCopyWithImpl<_$CollectionObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) {
    return collection(tileGoals);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) {
    return collection?.call(tileGoals);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) {
    if (collection != null) {
      return collection(tileGoals);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) {
    return collection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) {
    return collection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) {
    if (collection != null) {
      return collection(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionObjectiveImplToJson(this);
  }
}

abstract class CollectionObjective extends ObjectiveModel {
  const factory CollectionObjective({
    required final Map<String, List<int>> tileGoals,
  }) = _$CollectionObjectiveImpl;
  const CollectionObjective._() : super._();

  factory CollectionObjective.fromJson(Map<String, dynamic> json) =
      _$CollectionObjectiveImpl.fromJson;

  Map<String, List<int>> get tileGoals;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionObjectiveImplCopyWith<_$CollectionObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChainObjectiveImplCopyWith<$Res> {
  factory _$$ChainObjectiveImplCopyWith(
    _$ChainObjectiveImpl value,
    $Res Function(_$ChainObjectiveImpl) then,
  ) = __$$ChainObjectiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> subObjectiveIds});
}

/// @nodoc
class __$$ChainObjectiveImplCopyWithImpl<$Res>
    extends _$ObjectiveModelCopyWithImpl<$Res, _$ChainObjectiveImpl>
    implements _$$ChainObjectiveImplCopyWith<$Res> {
  __$$ChainObjectiveImplCopyWithImpl(
    _$ChainObjectiveImpl _value,
    $Res Function(_$ChainObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subObjectiveIds = null}) {
    return _then(
      _$ChainObjectiveImpl(
        subObjectiveIds: null == subObjectiveIds
            ? _value._subObjectiveIds
            : subObjectiveIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChainObjectiveImpl extends ChainObjective {
  const _$ChainObjectiveImpl({
    required final List<String> subObjectiveIds,
    final String? $type,
  }) : _subObjectiveIds = subObjectiveIds,
       $type = $type ?? 'chain',
       super._();

  factory _$ChainObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChainObjectiveImplFromJson(json);

  final List<String> _subObjectiveIds;
  @override
  List<String> get subObjectiveIds {
    if (_subObjectiveIds is EqualUnmodifiableListView) return _subObjectiveIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subObjectiveIds);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ObjectiveModel.chain(subObjectiveIds: $subObjectiveIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChainObjectiveImpl &&
            const DeepCollectionEquality().equals(
              other._subObjectiveIds,
              _subObjectiveIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_subObjectiveIds),
  );

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChainObjectiveImplCopyWith<_$ChainObjectiveImpl> get copyWith =>
      __$$ChainObjectiveImplCopyWithImpl<_$ChainObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tileId, int goalRow, int goalCol) position,
    required TResult Function(List<String> tileIds, List<int> targetValues)
    sequence,
    required TResult Function(List<String> tileIds, int targetSum) sum,
    required TResult Function(List<String> regionTileIds, int targetValue)
    balance,
    required TResult Function(Map<String, List<int>> tileGoals) collection,
    required TResult Function(List<String> subObjectiveIds) chain,
  }) {
    return chain(subObjectiveIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tileId, int goalRow, int goalCol)? position,
    TResult? Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult? Function(List<String> tileIds, int targetSum)? sum,
    TResult? Function(List<String> regionTileIds, int targetValue)? balance,
    TResult? Function(Map<String, List<int>> tileGoals)? collection,
    TResult? Function(List<String> subObjectiveIds)? chain,
  }) {
    return chain?.call(subObjectiveIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tileId, int goalRow, int goalCol)? position,
    TResult Function(List<String> tileIds, List<int> targetValues)? sequence,
    TResult Function(List<String> tileIds, int targetSum)? sum,
    TResult Function(List<String> regionTileIds, int targetValue)? balance,
    TResult Function(Map<String, List<int>> tileGoals)? collection,
    TResult Function(List<String> subObjectiveIds)? chain,
    required TResult orElse(),
  }) {
    if (chain != null) {
      return chain(subObjectiveIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PositionObjective value) position,
    required TResult Function(SequenceObjective value) sequence,
    required TResult Function(SumObjective value) sum,
    required TResult Function(BalanceObjective value) balance,
    required TResult Function(CollectionObjective value) collection,
    required TResult Function(ChainObjective value) chain,
  }) {
    return chain(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PositionObjective value)? position,
    TResult? Function(SequenceObjective value)? sequence,
    TResult? Function(SumObjective value)? sum,
    TResult? Function(BalanceObjective value)? balance,
    TResult? Function(CollectionObjective value)? collection,
    TResult? Function(ChainObjective value)? chain,
  }) {
    return chain?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PositionObjective value)? position,
    TResult Function(SequenceObjective value)? sequence,
    TResult Function(SumObjective value)? sum,
    TResult Function(BalanceObjective value)? balance,
    TResult Function(CollectionObjective value)? collection,
    TResult Function(ChainObjective value)? chain,
    required TResult orElse(),
  }) {
    if (chain != null) {
      return chain(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ChainObjectiveImplToJson(this);
  }
}

abstract class ChainObjective extends ObjectiveModel {
  const factory ChainObjective({required final List<String> subObjectiveIds}) =
      _$ChainObjectiveImpl;
  const ChainObjective._() : super._();

  factory ChainObjective.fromJson(Map<String, dynamic> json) =
      _$ChainObjectiveImpl.fromJson;

  List<String> get subObjectiveIds;

  /// Create a copy of ObjectiveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChainObjectiveImplCopyWith<_$ChainObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
