// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CycleStep {

 int get cycleIndex; List<TileAction> get actions; BoardModel get boardSnapshot;
/// Create a copy of CycleStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleStepCopyWith<CycleStep> get copyWith => _$CycleStepCopyWithImpl<CycleStep>(this as CycleStep, _$identity);

  /// Serializes this CycleStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleStep&&(identical(other.cycleIndex, cycleIndex) || other.cycleIndex == cycleIndex)&&const DeepCollectionEquality().equals(other.actions, actions)&&(identical(other.boardSnapshot, boardSnapshot) || other.boardSnapshot == boardSnapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cycleIndex,const DeepCollectionEquality().hash(actions),boardSnapshot);

@override
String toString() {
  return 'CycleStep(cycleIndex: $cycleIndex, actions: $actions, boardSnapshot: $boardSnapshot)';
}


}

/// @nodoc
abstract mixin class $CycleStepCopyWith<$Res>  {
  factory $CycleStepCopyWith(CycleStep value, $Res Function(CycleStep) _then) = _$CycleStepCopyWithImpl;
@useResult
$Res call({
 int cycleIndex, List<TileAction> actions, BoardModel boardSnapshot
});


$BoardModelCopyWith<$Res> get boardSnapshot;

}
/// @nodoc
class _$CycleStepCopyWithImpl<$Res>
    implements $CycleStepCopyWith<$Res> {
  _$CycleStepCopyWithImpl(this._self, this._then);

  final CycleStep _self;
  final $Res Function(CycleStep) _then;

/// Create a copy of CycleStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cycleIndex = null,Object? actions = null,Object? boardSnapshot = null,}) {
  return _then(_self.copyWith(
cycleIndex: null == cycleIndex ? _self.cycleIndex : cycleIndex // ignore: cast_nullable_to_non_nullable
as int,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<TileAction>,boardSnapshot: null == boardSnapshot ? _self.boardSnapshot : boardSnapshot // ignore: cast_nullable_to_non_nullable
as BoardModel,
  ));
}
/// Create a copy of CycleStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get boardSnapshot {
  
  return $BoardModelCopyWith<$Res>(_self.boardSnapshot, (value) {
    return _then(_self.copyWith(boardSnapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [CycleStep].
extension CycleStepPatterns on CycleStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleStep value)  $default,){
final _that = this;
switch (_that) {
case _CycleStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleStep value)?  $default,){
final _that = this;
switch (_that) {
case _CycleStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cycleIndex,  List<TileAction> actions,  BoardModel boardSnapshot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleStep() when $default != null:
return $default(_that.cycleIndex,_that.actions,_that.boardSnapshot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cycleIndex,  List<TileAction> actions,  BoardModel boardSnapshot)  $default,) {final _that = this;
switch (_that) {
case _CycleStep():
return $default(_that.cycleIndex,_that.actions,_that.boardSnapshot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cycleIndex,  List<TileAction> actions,  BoardModel boardSnapshot)?  $default,) {final _that = this;
switch (_that) {
case _CycleStep() when $default != null:
return $default(_that.cycleIndex,_that.actions,_that.boardSnapshot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleStep implements CycleStep {
  const _CycleStep({required this.cycleIndex, final  List<TileAction> actions = const [], required this.boardSnapshot}): _actions = actions;
  factory _CycleStep.fromJson(Map<String, dynamic> json) => _$CycleStepFromJson(json);

@override final  int cycleIndex;
 final  List<TileAction> _actions;
@override@JsonKey() List<TileAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

@override final  BoardModel boardSnapshot;

/// Create a copy of CycleStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleStepCopyWith<_CycleStep> get copyWith => __$CycleStepCopyWithImpl<_CycleStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleStep&&(identical(other.cycleIndex, cycleIndex) || other.cycleIndex == cycleIndex)&&const DeepCollectionEquality().equals(other._actions, _actions)&&(identical(other.boardSnapshot, boardSnapshot) || other.boardSnapshot == boardSnapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cycleIndex,const DeepCollectionEquality().hash(_actions),boardSnapshot);

@override
String toString() {
  return 'CycleStep(cycleIndex: $cycleIndex, actions: $actions, boardSnapshot: $boardSnapshot)';
}


}

/// @nodoc
abstract mixin class _$CycleStepCopyWith<$Res> implements $CycleStepCopyWith<$Res> {
  factory _$CycleStepCopyWith(_CycleStep value, $Res Function(_CycleStep) _then) = __$CycleStepCopyWithImpl;
@override @useResult
$Res call({
 int cycleIndex, List<TileAction> actions, BoardModel boardSnapshot
});


@override $BoardModelCopyWith<$Res> get boardSnapshot;

}
/// @nodoc
class __$CycleStepCopyWithImpl<$Res>
    implements _$CycleStepCopyWith<$Res> {
  __$CycleStepCopyWithImpl(this._self, this._then);

  final _CycleStep _self;
  final $Res Function(_CycleStep) _then;

/// Create a copy of CycleStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cycleIndex = null,Object? actions = null,Object? boardSnapshot = null,}) {
  return _then(_CycleStep(
cycleIndex: null == cycleIndex ? _self.cycleIndex : cycleIndex // ignore: cast_nullable_to_non_nullable
as int,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<TileAction>,boardSnapshot: null == boardSnapshot ? _self.boardSnapshot : boardSnapshot // ignore: cast_nullable_to_non_nullable
as BoardModel,
  ));
}

/// Create a copy of CycleStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get boardSnapshot {
  
  return $BoardModelCopyWith<$Res>(_self.boardSnapshot, (value) {
    return _then(_self.copyWith(boardSnapshot: value));
  });
}
}

// dart format on
