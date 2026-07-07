// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'move_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoveRecord {

 String get tileId; Direction get direction;
/// Create a copy of MoveRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoveRecordCopyWith<MoveRecord> get copyWith => _$MoveRecordCopyWithImpl<MoveRecord>(this as MoveRecord, _$identity);

  /// Serializes this MoveRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoveRecord&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tileId,direction);

@override
String toString() {
  return 'MoveRecord(tileId: $tileId, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $MoveRecordCopyWith<$Res>  {
  factory $MoveRecordCopyWith(MoveRecord value, $Res Function(MoveRecord) _then) = _$MoveRecordCopyWithImpl;
@useResult
$Res call({
 String tileId, Direction direction
});




}
/// @nodoc
class _$MoveRecordCopyWithImpl<$Res>
    implements $MoveRecordCopyWith<$Res> {
  _$MoveRecordCopyWithImpl(this._self, this._then);

  final MoveRecord _self;
  final $Res Function(MoveRecord) _then;

/// Create a copy of MoveRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tileId = null,Object? direction = null,}) {
  return _then(_self.copyWith(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,
  ));
}

}


/// Adds pattern-matching-related methods to [MoveRecord].
extension MoveRecordPatterns on MoveRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoveRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoveRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoveRecord value)  $default,){
final _that = this;
switch (_that) {
case _MoveRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoveRecord value)?  $default,){
final _that = this;
switch (_that) {
case _MoveRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tileId,  Direction direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoveRecord() when $default != null:
return $default(_that.tileId,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tileId,  Direction direction)  $default,) {final _that = this;
switch (_that) {
case _MoveRecord():
return $default(_that.tileId,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tileId,  Direction direction)?  $default,) {final _that = this;
switch (_that) {
case _MoveRecord() when $default != null:
return $default(_that.tileId,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoveRecord implements MoveRecord {
  const _MoveRecord({required this.tileId, required this.direction});
  factory _MoveRecord.fromJson(Map<String, dynamic> json) => _$MoveRecordFromJson(json);

@override final  String tileId;
@override final  Direction direction;

/// Create a copy of MoveRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoveRecordCopyWith<_MoveRecord> get copyWith => __$MoveRecordCopyWithImpl<_MoveRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoveRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoveRecord&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tileId,direction);

@override
String toString() {
  return 'MoveRecord(tileId: $tileId, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$MoveRecordCopyWith<$Res> implements $MoveRecordCopyWith<$Res> {
  factory _$MoveRecordCopyWith(_MoveRecord value, $Res Function(_MoveRecord) _then) = __$MoveRecordCopyWithImpl;
@override @useResult
$Res call({
 String tileId, Direction direction
});




}
/// @nodoc
class __$MoveRecordCopyWithImpl<$Res>
    implements _$MoveRecordCopyWith<$Res> {
  __$MoveRecordCopyWithImpl(this._self, this._then);

  final _MoveRecord _self;
  final $Res Function(_MoveRecord) _then;

/// Create a copy of MoveRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tileId = null,Object? direction = null,}) {
  return _then(_MoveRecord(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,
  ));
}


}

// dart format on
