// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimulationResult {

 List<CycleStep> get steps; BoardModel get finalBoard; bool get isStable; bool get hitCycleCap;
/// Create a copy of SimulationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimulationResultCopyWith<SimulationResult> get copyWith => _$SimulationResultCopyWithImpl<SimulationResult>(this as SimulationResult, _$identity);

  /// Serializes this SimulationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimulationResult&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.finalBoard, finalBoard) || other.finalBoard == finalBoard)&&(identical(other.isStable, isStable) || other.isStable == isStable)&&(identical(other.hitCycleCap, hitCycleCap) || other.hitCycleCap == hitCycleCap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(steps),finalBoard,isStable,hitCycleCap);

@override
String toString() {
  return 'SimulationResult(steps: $steps, finalBoard: $finalBoard, isStable: $isStable, hitCycleCap: $hitCycleCap)';
}


}

/// @nodoc
abstract mixin class $SimulationResultCopyWith<$Res>  {
  factory $SimulationResultCopyWith(SimulationResult value, $Res Function(SimulationResult) _then) = _$SimulationResultCopyWithImpl;
@useResult
$Res call({
 List<CycleStep> steps, BoardModel finalBoard, bool isStable, bool hitCycleCap
});


$BoardModelCopyWith<$Res> get finalBoard;

}
/// @nodoc
class _$SimulationResultCopyWithImpl<$Res>
    implements $SimulationResultCopyWith<$Res> {
  _$SimulationResultCopyWithImpl(this._self, this._then);

  final SimulationResult _self;
  final $Res Function(SimulationResult) _then;

/// Create a copy of SimulationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? steps = null,Object? finalBoard = null,Object? isStable = null,Object? hitCycleCap = null,}) {
  return _then(_self.copyWith(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<CycleStep>,finalBoard: null == finalBoard ? _self.finalBoard : finalBoard // ignore: cast_nullable_to_non_nullable
as BoardModel,isStable: null == isStable ? _self.isStable : isStable // ignore: cast_nullable_to_non_nullable
as bool,hitCycleCap: null == hitCycleCap ? _self.hitCycleCap : hitCycleCap // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SimulationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get finalBoard {
  
  return $BoardModelCopyWith<$Res>(_self.finalBoard, (value) {
    return _then(_self.copyWith(finalBoard: value));
  });
}
}


/// Adds pattern-matching-related methods to [SimulationResult].
extension SimulationResultPatterns on SimulationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimulationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimulationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimulationResult value)  $default,){
final _that = this;
switch (_that) {
case _SimulationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimulationResult value)?  $default,){
final _that = this;
switch (_that) {
case _SimulationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CycleStep> steps,  BoardModel finalBoard,  bool isStable,  bool hitCycleCap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimulationResult() when $default != null:
return $default(_that.steps,_that.finalBoard,_that.isStable,_that.hitCycleCap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CycleStep> steps,  BoardModel finalBoard,  bool isStable,  bool hitCycleCap)  $default,) {final _that = this;
switch (_that) {
case _SimulationResult():
return $default(_that.steps,_that.finalBoard,_that.isStable,_that.hitCycleCap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CycleStep> steps,  BoardModel finalBoard,  bool isStable,  bool hitCycleCap)?  $default,) {final _that = this;
switch (_that) {
case _SimulationResult() when $default != null:
return $default(_that.steps,_that.finalBoard,_that.isStable,_that.hitCycleCap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimulationResult implements SimulationResult {
  const _SimulationResult({final  List<CycleStep> steps = const [], required this.finalBoard, this.isStable = true, this.hitCycleCap = false}): _steps = steps;
  factory _SimulationResult.fromJson(Map<String, dynamic> json) => _$SimulationResultFromJson(json);

 final  List<CycleStep> _steps;
@override@JsonKey() List<CycleStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  BoardModel finalBoard;
@override@JsonKey() final  bool isStable;
@override@JsonKey() final  bool hitCycleCap;

/// Create a copy of SimulationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimulationResultCopyWith<_SimulationResult> get copyWith => __$SimulationResultCopyWithImpl<_SimulationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimulationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimulationResult&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.finalBoard, finalBoard) || other.finalBoard == finalBoard)&&(identical(other.isStable, isStable) || other.isStable == isStable)&&(identical(other.hitCycleCap, hitCycleCap) || other.hitCycleCap == hitCycleCap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_steps),finalBoard,isStable,hitCycleCap);

@override
String toString() {
  return 'SimulationResult(steps: $steps, finalBoard: $finalBoard, isStable: $isStable, hitCycleCap: $hitCycleCap)';
}


}

/// @nodoc
abstract mixin class _$SimulationResultCopyWith<$Res> implements $SimulationResultCopyWith<$Res> {
  factory _$SimulationResultCopyWith(_SimulationResult value, $Res Function(_SimulationResult) _then) = __$SimulationResultCopyWithImpl;
@override @useResult
$Res call({
 List<CycleStep> steps, BoardModel finalBoard, bool isStable, bool hitCycleCap
});


@override $BoardModelCopyWith<$Res> get finalBoard;

}
/// @nodoc
class __$SimulationResultCopyWithImpl<$Res>
    implements _$SimulationResultCopyWith<$Res> {
  __$SimulationResultCopyWithImpl(this._self, this._then);

  final _SimulationResult _self;
  final $Res Function(_SimulationResult) _then;

/// Create a copy of SimulationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? steps = null,Object? finalBoard = null,Object? isStable = null,Object? hitCycleCap = null,}) {
  return _then(_SimulationResult(
steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<CycleStep>,finalBoard: null == finalBoard ? _self.finalBoard : finalBoard // ignore: cast_nullable_to_non_nullable
as BoardModel,isStable: null == isStable ? _self.isStable : isStable // ignore: cast_nullable_to_non_nullable
as bool,hitCycleCap: null == hitCycleCap ? _self.hitCycleCap : hitCycleCap // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SimulationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardModelCopyWith<$Res> get finalBoard {
  
  return $BoardModelCopyWith<$Res>(_self.finalBoard, (value) {
    return _then(_self.copyWith(finalBoard: value));
  });
}
}

// dart format on
