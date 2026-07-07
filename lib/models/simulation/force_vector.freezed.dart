// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'force_vector.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForceVector {

 String get sourceTileId; String get targetTileId; double get force; Direction get direction; bool get isRepulsion;
/// Create a copy of ForceVector
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForceVectorCopyWith<ForceVector> get copyWith => _$ForceVectorCopyWithImpl<ForceVector>(this as ForceVector, _$identity);

  /// Serializes this ForceVector to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForceVector&&(identical(other.sourceTileId, sourceTileId) || other.sourceTileId == sourceTileId)&&(identical(other.targetTileId, targetTileId) || other.targetTileId == targetTileId)&&(identical(other.force, force) || other.force == force)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.isRepulsion, isRepulsion) || other.isRepulsion == isRepulsion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceTileId,targetTileId,force,direction,isRepulsion);

@override
String toString() {
  return 'ForceVector(sourceTileId: $sourceTileId, targetTileId: $targetTileId, force: $force, direction: $direction, isRepulsion: $isRepulsion)';
}


}

/// @nodoc
abstract mixin class $ForceVectorCopyWith<$Res>  {
  factory $ForceVectorCopyWith(ForceVector value, $Res Function(ForceVector) _then) = _$ForceVectorCopyWithImpl;
@useResult
$Res call({
 String sourceTileId, String targetTileId, double force, Direction direction, bool isRepulsion
});




}
/// @nodoc
class _$ForceVectorCopyWithImpl<$Res>
    implements $ForceVectorCopyWith<$Res> {
  _$ForceVectorCopyWithImpl(this._self, this._then);

  final ForceVector _self;
  final $Res Function(ForceVector) _then;

/// Create a copy of ForceVector
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceTileId = null,Object? targetTileId = null,Object? force = null,Object? direction = null,Object? isRepulsion = null,}) {
  return _then(_self.copyWith(
sourceTileId: null == sourceTileId ? _self.sourceTileId : sourceTileId // ignore: cast_nullable_to_non_nullable
as String,targetTileId: null == targetTileId ? _self.targetTileId : targetTileId // ignore: cast_nullable_to_non_nullable
as String,force: null == force ? _self.force : force // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,isRepulsion: null == isRepulsion ? _self.isRepulsion : isRepulsion // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ForceVector].
extension ForceVectorPatterns on ForceVector {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForceVector value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForceVector() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForceVector value)  $default,){
final _that = this;
switch (_that) {
case _ForceVector():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForceVector value)?  $default,){
final _that = this;
switch (_that) {
case _ForceVector() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceTileId,  String targetTileId,  double force,  Direction direction,  bool isRepulsion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForceVector() when $default != null:
return $default(_that.sourceTileId,_that.targetTileId,_that.force,_that.direction,_that.isRepulsion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceTileId,  String targetTileId,  double force,  Direction direction,  bool isRepulsion)  $default,) {final _that = this;
switch (_that) {
case _ForceVector():
return $default(_that.sourceTileId,_that.targetTileId,_that.force,_that.direction,_that.isRepulsion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceTileId,  String targetTileId,  double force,  Direction direction,  bool isRepulsion)?  $default,) {final _that = this;
switch (_that) {
case _ForceVector() when $default != null:
return $default(_that.sourceTileId,_that.targetTileId,_that.force,_that.direction,_that.isRepulsion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForceVector implements ForceVector {
  const _ForceVector({required this.sourceTileId, required this.targetTileId, required this.force, required this.direction, required this.isRepulsion});
  factory _ForceVector.fromJson(Map<String, dynamic> json) => _$ForceVectorFromJson(json);

@override final  String sourceTileId;
@override final  String targetTileId;
@override final  double force;
@override final  Direction direction;
@override final  bool isRepulsion;

/// Create a copy of ForceVector
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForceVectorCopyWith<_ForceVector> get copyWith => __$ForceVectorCopyWithImpl<_ForceVector>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForceVectorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForceVector&&(identical(other.sourceTileId, sourceTileId) || other.sourceTileId == sourceTileId)&&(identical(other.targetTileId, targetTileId) || other.targetTileId == targetTileId)&&(identical(other.force, force) || other.force == force)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.isRepulsion, isRepulsion) || other.isRepulsion == isRepulsion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceTileId,targetTileId,force,direction,isRepulsion);

@override
String toString() {
  return 'ForceVector(sourceTileId: $sourceTileId, targetTileId: $targetTileId, force: $force, direction: $direction, isRepulsion: $isRepulsion)';
}


}

/// @nodoc
abstract mixin class _$ForceVectorCopyWith<$Res> implements $ForceVectorCopyWith<$Res> {
  factory _$ForceVectorCopyWith(_ForceVector value, $Res Function(_ForceVector) _then) = __$ForceVectorCopyWithImpl;
@override @useResult
$Res call({
 String sourceTileId, String targetTileId, double force, Direction direction, bool isRepulsion
});




}
/// @nodoc
class __$ForceVectorCopyWithImpl<$Res>
    implements _$ForceVectorCopyWith<$Res> {
  __$ForceVectorCopyWithImpl(this._self, this._then);

  final _ForceVector _self;
  final $Res Function(_ForceVector) _then;

/// Create a copy of ForceVector
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceTileId = null,Object? targetTileId = null,Object? force = null,Object? direction = null,Object? isRepulsion = null,}) {
  return _then(_ForceVector(
sourceTileId: null == sourceTileId ? _self.sourceTileId : sourceTileId // ignore: cast_nullable_to_non_nullable
as String,targetTileId: null == targetTileId ? _self.targetTileId : targetTileId // ignore: cast_nullable_to_non_nullable
as String,force: null == force ? _self.force : force // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,isRepulsion: null == isRepulsion ? _self.isRepulsion : isRepulsion // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
