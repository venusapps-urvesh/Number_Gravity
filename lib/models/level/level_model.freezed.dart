// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LevelModel {

 int get id; int get world; LevelTier get tier; BoardModel get board; ObjectiveModel get objective; int get minimumMoves; List<String> get solutionMoves;
/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelModelCopyWith<LevelModel> get copyWith => _$LevelModelCopyWithImpl<LevelModel>(this as LevelModel, _$identity);

  /// Serializes this LevelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.world, world) || other.world == world)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.board, board) || other.board == board)&&(identical(other.objective, objective) || other.objective == objective)&&(identical(other.minimumMoves, minimumMoves) || other.minimumMoves == minimumMoves)&&const DeepCollectionEquality().equals(other.solutionMoves, solutionMoves));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,world,tier,board,objective,minimumMoves,const DeepCollectionEquality().hash(solutionMoves));

@override
String toString() {
  return 'LevelModel(id: $id, world: $world, tier: $tier, board: $board, objective: $objective, minimumMoves: $minimumMoves, solutionMoves: $solutionMoves)';
}


}

/// @nodoc
abstract mixin class $LevelModelCopyWith<$Res>  {
  factory $LevelModelCopyWith(LevelModel value, $Res Function(LevelModel) _then) = _$LevelModelCopyWithImpl;
@useResult
$Res call({
 int id, int world, LevelTier tier, BoardModel board, ObjectiveModel objective, int minimumMoves, List<String> solutionMoves
});


$BoardModelCopyWith<$Res> get board;$ObjectiveModelCopyWith<$Res> get objective;

}
/// @nodoc
class _$LevelModelCopyWithImpl<$Res>
    implements $LevelModelCopyWith<$Res> {
  _$LevelModelCopyWithImpl(this._self, this._then);

  final LevelModel _self;
  final $Res Function(LevelModel) _then;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? world = null,Object? tier = null,Object? board = null,Object? objective = null,Object? minimumMoves = null,Object? solutionMoves = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,world: null == world ? _self.world : world // ignore: cast_nullable_to_non_nullable
as int,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as LevelTier,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardModel,objective: null == objective ? _self.objective : objective // ignore: cast_nullable_to_non_nullable
as ObjectiveModel,minimumMoves: null == minimumMoves ? _self.minimumMoves : minimumMoves // ignore: cast_nullable_to_non_nullable
as int,solutionMoves: null == solutionMoves ? _self.solutionMoves : solutionMoves // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get board {
  
  return $BoardModelCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObjectiveModelCopyWith<$Res> get objective {
  
  return $ObjectiveModelCopyWith<$Res>(_self.objective, (value) {
    return _then(_self.copyWith(objective: value));
  });
}
}


/// Adds pattern-matching-related methods to [LevelModel].
extension LevelModelPatterns on LevelModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelModel value)  $default,){
final _that = this;
switch (_that) {
case _LevelModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelModel value)?  $default,){
final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int world,  LevelTier tier,  BoardModel board,  ObjectiveModel objective,  int minimumMoves,  List<String> solutionMoves)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that.id,_that.world,_that.tier,_that.board,_that.objective,_that.minimumMoves,_that.solutionMoves);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int world,  LevelTier tier,  BoardModel board,  ObjectiveModel objective,  int minimumMoves,  List<String> solutionMoves)  $default,) {final _that = this;
switch (_that) {
case _LevelModel():
return $default(_that.id,_that.world,_that.tier,_that.board,_that.objective,_that.minimumMoves,_that.solutionMoves);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int world,  LevelTier tier,  BoardModel board,  ObjectiveModel objective,  int minimumMoves,  List<String> solutionMoves)?  $default,) {final _that = this;
switch (_that) {
case _LevelModel() when $default != null:
return $default(_that.id,_that.world,_that.tier,_that.board,_that.objective,_that.minimumMoves,_that.solutionMoves);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LevelModel implements LevelModel {
  const _LevelModel({required this.id, required this.world, required this.tier, required this.board, required this.objective, required this.minimumMoves, final  List<String> solutionMoves = const []}): _solutionMoves = solutionMoves;
  factory _LevelModel.fromJson(Map<String, dynamic> json) => _$LevelModelFromJson(json);

@override final  int id;
@override final  int world;
@override final  LevelTier tier;
@override final  BoardModel board;
@override final  ObjectiveModel objective;
@override final  int minimumMoves;
 final  List<String> _solutionMoves;
@override@JsonKey() List<String> get solutionMoves {
  if (_solutionMoves is EqualUnmodifiableListView) return _solutionMoves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_solutionMoves);
}


/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelModelCopyWith<_LevelModel> get copyWith => __$LevelModelCopyWithImpl<_LevelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LevelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.world, world) || other.world == world)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.board, board) || other.board == board)&&(identical(other.objective, objective) || other.objective == objective)&&(identical(other.minimumMoves, minimumMoves) || other.minimumMoves == minimumMoves)&&const DeepCollectionEquality().equals(other._solutionMoves, _solutionMoves));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,world,tier,board,objective,minimumMoves,const DeepCollectionEquality().hash(_solutionMoves));

@override
String toString() {
  return 'LevelModel(id: $id, world: $world, tier: $tier, board: $board, objective: $objective, minimumMoves: $minimumMoves, solutionMoves: $solutionMoves)';
}


}

/// @nodoc
abstract mixin class _$LevelModelCopyWith<$Res> implements $LevelModelCopyWith<$Res> {
  factory _$LevelModelCopyWith(_LevelModel value, $Res Function(_LevelModel) _then) = __$LevelModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int world, LevelTier tier, BoardModel board, ObjectiveModel objective, int minimumMoves, List<String> solutionMoves
});


@override $BoardModelCopyWith<$Res> get board;@override $ObjectiveModelCopyWith<$Res> get objective;

}
/// @nodoc
class __$LevelModelCopyWithImpl<$Res>
    implements _$LevelModelCopyWith<$Res> {
  __$LevelModelCopyWithImpl(this._self, this._then);

  final _LevelModel _self;
  final $Res Function(_LevelModel) _then;

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? world = null,Object? tier = null,Object? board = null,Object? objective = null,Object? minimumMoves = null,Object? solutionMoves = null,}) {
  return _then(_LevelModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,world: null == world ? _self.world : world // ignore: cast_nullable_to_non_nullable
as int,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as LevelTier,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as BoardModel,objective: null == objective ? _self.objective : objective // ignore: cast_nullable_to_non_nullable
as ObjectiveModel,minimumMoves: null == minimumMoves ? _self.minimumMoves : minimumMoves // ignore: cast_nullable_to_non_nullable
as int,solutionMoves: null == solutionMoves ? _self._solutionMoves : solutionMoves // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get board {
  
  return $BoardModelCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of LevelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObjectiveModelCopyWith<$Res> get objective {
  
  return $ObjectiveModelCopyWith<$Res>(_self.objective, (value) {
    return _then(_self.copyWith(objective: value));
  });
}
}

// dart format on
