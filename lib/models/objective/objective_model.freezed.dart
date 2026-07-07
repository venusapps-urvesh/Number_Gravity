// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'objective_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ObjectiveModel _$ObjectiveModelFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'position':
          return PositionObjective.fromJson(
            json
          );
                case 'sequence':
          return SequenceObjective.fromJson(
            json
          );
                case 'sum':
          return SumObjective.fromJson(
            json
          );
                case 'balance':
          return BalanceObjective.fromJson(
            json
          );
                case 'collection':
          return CollectionObjective.fromJson(
            json
          );
                case 'chain':
          return ChainObjective.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ObjectiveModel',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ObjectiveModel {



  /// Serializes this ObjectiveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObjectiveModel);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObjectiveModel()';
}


}

/// @nodoc
class $ObjectiveModelCopyWith<$Res>  {
$ObjectiveModelCopyWith(ObjectiveModel _, $Res Function(ObjectiveModel) __);
}


/// Adds pattern-matching-related methods to [ObjectiveModel].
extension ObjectiveModelPatterns on ObjectiveModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PositionObjective value)?  position,TResult Function( SequenceObjective value)?  sequence,TResult Function( SumObjective value)?  sum,TResult Function( BalanceObjective value)?  balance,TResult Function( CollectionObjective value)?  collection,TResult Function( ChainObjective value)?  chain,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PositionObjective() when position != null:
return position(_that);case SequenceObjective() when sequence != null:
return sequence(_that);case SumObjective() when sum != null:
return sum(_that);case BalanceObjective() when balance != null:
return balance(_that);case CollectionObjective() when collection != null:
return collection(_that);case ChainObjective() when chain != null:
return chain(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PositionObjective value)  position,required TResult Function( SequenceObjective value)  sequence,required TResult Function( SumObjective value)  sum,required TResult Function( BalanceObjective value)  balance,required TResult Function( CollectionObjective value)  collection,required TResult Function( ChainObjective value)  chain,}){
final _that = this;
switch (_that) {
case PositionObjective():
return position(_that);case SequenceObjective():
return sequence(_that);case SumObjective():
return sum(_that);case BalanceObjective():
return balance(_that);case CollectionObjective():
return collection(_that);case ChainObjective():
return chain(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PositionObjective value)?  position,TResult? Function( SequenceObjective value)?  sequence,TResult? Function( SumObjective value)?  sum,TResult? Function( BalanceObjective value)?  balance,TResult? Function( CollectionObjective value)?  collection,TResult? Function( ChainObjective value)?  chain,}){
final _that = this;
switch (_that) {
case PositionObjective() when position != null:
return position(_that);case SequenceObjective() when sequence != null:
return sequence(_that);case SumObjective() when sum != null:
return sum(_that);case BalanceObjective() when balance != null:
return balance(_that);case CollectionObjective() when collection != null:
return collection(_that);case ChainObjective() when chain != null:
return chain(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tileId,  int goalRow,  int goalCol)?  position,TResult Function( List<String> tileIds,  List<int> targetValues)?  sequence,TResult Function( List<String> tileIds,  int targetSum)?  sum,TResult Function( List<String> regionTileIds,  int targetValue)?  balance,TResult Function( Map<String, List<int>> tileGoals)?  collection,TResult Function( List<String> subObjectiveIds)?  chain,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PositionObjective() when position != null:
return position(_that.tileId,_that.goalRow,_that.goalCol);case SequenceObjective() when sequence != null:
return sequence(_that.tileIds,_that.targetValues);case SumObjective() when sum != null:
return sum(_that.tileIds,_that.targetSum);case BalanceObjective() when balance != null:
return balance(_that.regionTileIds,_that.targetValue);case CollectionObjective() when collection != null:
return collection(_that.tileGoals);case ChainObjective() when chain != null:
return chain(_that.subObjectiveIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tileId,  int goalRow,  int goalCol)  position,required TResult Function( List<String> tileIds,  List<int> targetValues)  sequence,required TResult Function( List<String> tileIds,  int targetSum)  sum,required TResult Function( List<String> regionTileIds,  int targetValue)  balance,required TResult Function( Map<String, List<int>> tileGoals)  collection,required TResult Function( List<String> subObjectiveIds)  chain,}) {final _that = this;
switch (_that) {
case PositionObjective():
return position(_that.tileId,_that.goalRow,_that.goalCol);case SequenceObjective():
return sequence(_that.tileIds,_that.targetValues);case SumObjective():
return sum(_that.tileIds,_that.targetSum);case BalanceObjective():
return balance(_that.regionTileIds,_that.targetValue);case CollectionObjective():
return collection(_that.tileGoals);case ChainObjective():
return chain(_that.subObjectiveIds);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tileId,  int goalRow,  int goalCol)?  position,TResult? Function( List<String> tileIds,  List<int> targetValues)?  sequence,TResult? Function( List<String> tileIds,  int targetSum)?  sum,TResult? Function( List<String> regionTileIds,  int targetValue)?  balance,TResult? Function( Map<String, List<int>> tileGoals)?  collection,TResult? Function( List<String> subObjectiveIds)?  chain,}) {final _that = this;
switch (_that) {
case PositionObjective() when position != null:
return position(_that.tileId,_that.goalRow,_that.goalCol);case SequenceObjective() when sequence != null:
return sequence(_that.tileIds,_that.targetValues);case SumObjective() when sum != null:
return sum(_that.tileIds,_that.targetSum);case BalanceObjective() when balance != null:
return balance(_that.regionTileIds,_that.targetValue);case CollectionObjective() when collection != null:
return collection(_that.tileGoals);case ChainObjective() when chain != null:
return chain(_that.subObjectiveIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PositionObjective extends ObjectiveModel {
  const PositionObjective({required this.tileId, required this.goalRow, required this.goalCol, final  String? $type}): $type = $type ?? 'position',super._();
  factory PositionObjective.fromJson(Map<String, dynamic> json) => _$PositionObjectiveFromJson(json);

 final  String tileId;
 final  int goalRow;
 final  int goalCol;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionObjectiveCopyWith<PositionObjective> get copyWith => _$PositionObjectiveCopyWithImpl<PositionObjective>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PositionObjectiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PositionObjective&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.goalRow, goalRow) || other.goalRow == goalRow)&&(identical(other.goalCol, goalCol) || other.goalCol == goalCol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tileId,goalRow,goalCol);

@override
String toString() {
  return 'ObjectiveModel.position(tileId: $tileId, goalRow: $goalRow, goalCol: $goalCol)';
}


}

/// @nodoc
abstract mixin class $PositionObjectiveCopyWith<$Res> implements $ObjectiveModelCopyWith<$Res> {
  factory $PositionObjectiveCopyWith(PositionObjective value, $Res Function(PositionObjective) _then) = _$PositionObjectiveCopyWithImpl;
@useResult
$Res call({
 String tileId, int goalRow, int goalCol
});




}
/// @nodoc
class _$PositionObjectiveCopyWithImpl<$Res>
    implements $PositionObjectiveCopyWith<$Res> {
  _$PositionObjectiveCopyWithImpl(this._self, this._then);

  final PositionObjective _self;
  final $Res Function(PositionObjective) _then;

/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tileId = null,Object? goalRow = null,Object? goalCol = null,}) {
  return _then(PositionObjective(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,goalRow: null == goalRow ? _self.goalRow : goalRow // ignore: cast_nullable_to_non_nullable
as int,goalCol: null == goalCol ? _self.goalCol : goalCol // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SequenceObjective extends ObjectiveModel {
  const SequenceObjective({required final  List<String> tileIds, required final  List<int> targetValues, final  String? $type}): _tileIds = tileIds,_targetValues = targetValues,$type = $type ?? 'sequence',super._();
  factory SequenceObjective.fromJson(Map<String, dynamic> json) => _$SequenceObjectiveFromJson(json);

 final  List<String> _tileIds;
 List<String> get tileIds {
  if (_tileIds is EqualUnmodifiableListView) return _tileIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tileIds);
}

 final  List<int> _targetValues;
 List<int> get targetValues {
  if (_targetValues is EqualUnmodifiableListView) return _targetValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetValues);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SequenceObjectiveCopyWith<SequenceObjective> get copyWith => _$SequenceObjectiveCopyWithImpl<SequenceObjective>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SequenceObjectiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SequenceObjective&&const DeepCollectionEquality().equals(other._tileIds, _tileIds)&&const DeepCollectionEquality().equals(other._targetValues, _targetValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tileIds),const DeepCollectionEquality().hash(_targetValues));

@override
String toString() {
  return 'ObjectiveModel.sequence(tileIds: $tileIds, targetValues: $targetValues)';
}


}

/// @nodoc
abstract mixin class $SequenceObjectiveCopyWith<$Res> implements $ObjectiveModelCopyWith<$Res> {
  factory $SequenceObjectiveCopyWith(SequenceObjective value, $Res Function(SequenceObjective) _then) = _$SequenceObjectiveCopyWithImpl;
@useResult
$Res call({
 List<String> tileIds, List<int> targetValues
});




}
/// @nodoc
class _$SequenceObjectiveCopyWithImpl<$Res>
    implements $SequenceObjectiveCopyWith<$Res> {
  _$SequenceObjectiveCopyWithImpl(this._self, this._then);

  final SequenceObjective _self;
  final $Res Function(SequenceObjective) _then;

/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tileIds = null,Object? targetValues = null,}) {
  return _then(SequenceObjective(
tileIds: null == tileIds ? _self._tileIds : tileIds // ignore: cast_nullable_to_non_nullable
as List<String>,targetValues: null == targetValues ? _self._targetValues : targetValues // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SumObjective extends ObjectiveModel {
  const SumObjective({required final  List<String> tileIds, required this.targetSum, final  String? $type}): _tileIds = tileIds,$type = $type ?? 'sum',super._();
  factory SumObjective.fromJson(Map<String, dynamic> json) => _$SumObjectiveFromJson(json);

 final  List<String> _tileIds;
 List<String> get tileIds {
  if (_tileIds is EqualUnmodifiableListView) return _tileIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tileIds);
}

 final  int targetSum;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SumObjectiveCopyWith<SumObjective> get copyWith => _$SumObjectiveCopyWithImpl<SumObjective>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SumObjectiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SumObjective&&const DeepCollectionEquality().equals(other._tileIds, _tileIds)&&(identical(other.targetSum, targetSum) || other.targetSum == targetSum));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tileIds),targetSum);

@override
String toString() {
  return 'ObjectiveModel.sum(tileIds: $tileIds, targetSum: $targetSum)';
}


}

/// @nodoc
abstract mixin class $SumObjectiveCopyWith<$Res> implements $ObjectiveModelCopyWith<$Res> {
  factory $SumObjectiveCopyWith(SumObjective value, $Res Function(SumObjective) _then) = _$SumObjectiveCopyWithImpl;
@useResult
$Res call({
 List<String> tileIds, int targetSum
});




}
/// @nodoc
class _$SumObjectiveCopyWithImpl<$Res>
    implements $SumObjectiveCopyWith<$Res> {
  _$SumObjectiveCopyWithImpl(this._self, this._then);

  final SumObjective _self;
  final $Res Function(SumObjective) _then;

/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tileIds = null,Object? targetSum = null,}) {
  return _then(SumObjective(
tileIds: null == tileIds ? _self._tileIds : tileIds // ignore: cast_nullable_to_non_nullable
as List<String>,targetSum: null == targetSum ? _self.targetSum : targetSum // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BalanceObjective extends ObjectiveModel {
  const BalanceObjective({required final  List<String> regionTileIds, required this.targetValue, final  String? $type}): _regionTileIds = regionTileIds,$type = $type ?? 'balance',super._();
  factory BalanceObjective.fromJson(Map<String, dynamic> json) => _$BalanceObjectiveFromJson(json);

 final  List<String> _regionTileIds;
 List<String> get regionTileIds {
  if (_regionTileIds is EqualUnmodifiableListView) return _regionTileIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regionTileIds);
}

 final  int targetValue;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceObjectiveCopyWith<BalanceObjective> get copyWith => _$BalanceObjectiveCopyWithImpl<BalanceObjective>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceObjectiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceObjective&&const DeepCollectionEquality().equals(other._regionTileIds, _regionTileIds)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regionTileIds),targetValue);

@override
String toString() {
  return 'ObjectiveModel.balance(regionTileIds: $regionTileIds, targetValue: $targetValue)';
}


}

/// @nodoc
abstract mixin class $BalanceObjectiveCopyWith<$Res> implements $ObjectiveModelCopyWith<$Res> {
  factory $BalanceObjectiveCopyWith(BalanceObjective value, $Res Function(BalanceObjective) _then) = _$BalanceObjectiveCopyWithImpl;
@useResult
$Res call({
 List<String> regionTileIds, int targetValue
});




}
/// @nodoc
class _$BalanceObjectiveCopyWithImpl<$Res>
    implements $BalanceObjectiveCopyWith<$Res> {
  _$BalanceObjectiveCopyWithImpl(this._self, this._then);

  final BalanceObjective _self;
  final $Res Function(BalanceObjective) _then;

/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? regionTileIds = null,Object? targetValue = null,}) {
  return _then(BalanceObjective(
regionTileIds: null == regionTileIds ? _self._regionTileIds : regionTileIds // ignore: cast_nullable_to_non_nullable
as List<String>,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CollectionObjective extends ObjectiveModel {
  const CollectionObjective({required final  Map<String, List<int>> tileGoals, final  String? $type}): _tileGoals = tileGoals,$type = $type ?? 'collection',super._();
  factory CollectionObjective.fromJson(Map<String, dynamic> json) => _$CollectionObjectiveFromJson(json);

 final  Map<String, List<int>> _tileGoals;
 Map<String, List<int>> get tileGoals {
  if (_tileGoals is EqualUnmodifiableMapView) return _tileGoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tileGoals);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionObjectiveCopyWith<CollectionObjective> get copyWith => _$CollectionObjectiveCopyWithImpl<CollectionObjective>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionObjectiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionObjective&&const DeepCollectionEquality().equals(other._tileGoals, _tileGoals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tileGoals));

@override
String toString() {
  return 'ObjectiveModel.collection(tileGoals: $tileGoals)';
}


}

/// @nodoc
abstract mixin class $CollectionObjectiveCopyWith<$Res> implements $ObjectiveModelCopyWith<$Res> {
  factory $CollectionObjectiveCopyWith(CollectionObjective value, $Res Function(CollectionObjective) _then) = _$CollectionObjectiveCopyWithImpl;
@useResult
$Res call({
 Map<String, List<int>> tileGoals
});




}
/// @nodoc
class _$CollectionObjectiveCopyWithImpl<$Res>
    implements $CollectionObjectiveCopyWith<$Res> {
  _$CollectionObjectiveCopyWithImpl(this._self, this._then);

  final CollectionObjective _self;
  final $Res Function(CollectionObjective) _then;

/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tileGoals = null,}) {
  return _then(CollectionObjective(
tileGoals: null == tileGoals ? _self._tileGoals : tileGoals // ignore: cast_nullable_to_non_nullable
as Map<String, List<int>>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ChainObjective extends ObjectiveModel {
  const ChainObjective({required final  List<String> subObjectiveIds, final  String? $type}): _subObjectiveIds = subObjectiveIds,$type = $type ?? 'chain',super._();
  factory ChainObjective.fromJson(Map<String, dynamic> json) => _$ChainObjectiveFromJson(json);

 final  List<String> _subObjectiveIds;
 List<String> get subObjectiveIds {
  if (_subObjectiveIds is EqualUnmodifiableListView) return _subObjectiveIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subObjectiveIds);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChainObjectiveCopyWith<ChainObjective> get copyWith => _$ChainObjectiveCopyWithImpl<ChainObjective>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChainObjectiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChainObjective&&const DeepCollectionEquality().equals(other._subObjectiveIds, _subObjectiveIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_subObjectiveIds));

@override
String toString() {
  return 'ObjectiveModel.chain(subObjectiveIds: $subObjectiveIds)';
}


}

/// @nodoc
abstract mixin class $ChainObjectiveCopyWith<$Res> implements $ObjectiveModelCopyWith<$Res> {
  factory $ChainObjectiveCopyWith(ChainObjective value, $Res Function(ChainObjective) _then) = _$ChainObjectiveCopyWithImpl;
@useResult
$Res call({
 List<String> subObjectiveIds
});




}
/// @nodoc
class _$ChainObjectiveCopyWithImpl<$Res>
    implements $ChainObjectiveCopyWith<$Res> {
  _$ChainObjectiveCopyWithImpl(this._self, this._then);

  final ChainObjective _self;
  final $Res Function(ChainObjective) _then;

/// Create a copy of ObjectiveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subObjectiveIds = null,}) {
  return _then(ChainObjective(
subObjectiveIds: null == subObjectiveIds ? _self._subObjectiveIds : subObjectiveIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
