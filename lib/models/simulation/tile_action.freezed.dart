// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TileAction {

 String get tileId; TileActionType get actionType; int get fromRow; int get fromCol; int get toRow; int get toCol; int? get resultingValue; String? get relatedTileId; Direction? get direction;
/// Create a copy of TileAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TileActionCopyWith<TileAction> get copyWith => _$TileActionCopyWithImpl<TileAction>(this as TileAction, _$identity);

  /// Serializes this TileAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TileAction&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.fromRow, fromRow) || other.fromRow == fromRow)&&(identical(other.fromCol, fromCol) || other.fromCol == fromCol)&&(identical(other.toRow, toRow) || other.toRow == toRow)&&(identical(other.toCol, toCol) || other.toCol == toCol)&&(identical(other.resultingValue, resultingValue) || other.resultingValue == resultingValue)&&(identical(other.relatedTileId, relatedTileId) || other.relatedTileId == relatedTileId)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tileId,actionType,fromRow,fromCol,toRow,toCol,resultingValue,relatedTileId,direction);

@override
String toString() {
  return 'TileAction(tileId: $tileId, actionType: $actionType, fromRow: $fromRow, fromCol: $fromCol, toRow: $toRow, toCol: $toCol, resultingValue: $resultingValue, relatedTileId: $relatedTileId, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $TileActionCopyWith<$Res>  {
  factory $TileActionCopyWith(TileAction value, $Res Function(TileAction) _then) = _$TileActionCopyWithImpl;
@useResult
$Res call({
 String tileId, TileActionType actionType, int fromRow, int fromCol, int toRow, int toCol, int? resultingValue, String? relatedTileId, Direction? direction
});




}
/// @nodoc
class _$TileActionCopyWithImpl<$Res>
    implements $TileActionCopyWith<$Res> {
  _$TileActionCopyWithImpl(this._self, this._then);

  final TileAction _self;
  final $Res Function(TileAction) _then;

/// Create a copy of TileAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tileId = null,Object? actionType = null,Object? fromRow = null,Object? fromCol = null,Object? toRow = null,Object? toCol = null,Object? resultingValue = freezed,Object? relatedTileId = freezed,Object? direction = freezed,}) {
  return _then(_self.copyWith(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as TileActionType,fromRow: null == fromRow ? _self.fromRow : fromRow // ignore: cast_nullable_to_non_nullable
as int,fromCol: null == fromCol ? _self.fromCol : fromCol // ignore: cast_nullable_to_non_nullable
as int,toRow: null == toRow ? _self.toRow : toRow // ignore: cast_nullable_to_non_nullable
as int,toCol: null == toCol ? _self.toCol : toCol // ignore: cast_nullable_to_non_nullable
as int,resultingValue: freezed == resultingValue ? _self.resultingValue : resultingValue // ignore: cast_nullable_to_non_nullable
as int?,relatedTileId: freezed == relatedTileId ? _self.relatedTileId : relatedTileId // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction?,
  ));
}

}


/// Adds pattern-matching-related methods to [TileAction].
extension TileActionPatterns on TileAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TileAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TileAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TileAction value)  $default,){
final _that = this;
switch (_that) {
case _TileAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TileAction value)?  $default,){
final _that = this;
switch (_that) {
case _TileAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tileId,  TileActionType actionType,  int fromRow,  int fromCol,  int toRow,  int toCol,  int? resultingValue,  String? relatedTileId,  Direction? direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TileAction() when $default != null:
return $default(_that.tileId,_that.actionType,_that.fromRow,_that.fromCol,_that.toRow,_that.toCol,_that.resultingValue,_that.relatedTileId,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tileId,  TileActionType actionType,  int fromRow,  int fromCol,  int toRow,  int toCol,  int? resultingValue,  String? relatedTileId,  Direction? direction)  $default,) {final _that = this;
switch (_that) {
case _TileAction():
return $default(_that.tileId,_that.actionType,_that.fromRow,_that.fromCol,_that.toRow,_that.toCol,_that.resultingValue,_that.relatedTileId,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tileId,  TileActionType actionType,  int fromRow,  int fromCol,  int toRow,  int toCol,  int? resultingValue,  String? relatedTileId,  Direction? direction)?  $default,) {final _that = this;
switch (_that) {
case _TileAction() when $default != null:
return $default(_that.tileId,_that.actionType,_that.fromRow,_that.fromCol,_that.toRow,_that.toCol,_that.resultingValue,_that.relatedTileId,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TileAction implements TileAction {
  const _TileAction({required this.tileId, required this.actionType, required this.fromRow, required this.fromCol, required this.toRow, required this.toCol, this.resultingValue, this.relatedTileId, this.direction});
  factory _TileAction.fromJson(Map<String, dynamic> json) => _$TileActionFromJson(json);

@override final  String tileId;
@override final  TileActionType actionType;
@override final  int fromRow;
@override final  int fromCol;
@override final  int toRow;
@override final  int toCol;
@override final  int? resultingValue;
@override final  String? relatedTileId;
@override final  Direction? direction;

/// Create a copy of TileAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TileActionCopyWith<_TileAction> get copyWith => __$TileActionCopyWithImpl<_TileAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TileActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TileAction&&(identical(other.tileId, tileId) || other.tileId == tileId)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.fromRow, fromRow) || other.fromRow == fromRow)&&(identical(other.fromCol, fromCol) || other.fromCol == fromCol)&&(identical(other.toRow, toRow) || other.toRow == toRow)&&(identical(other.toCol, toCol) || other.toCol == toCol)&&(identical(other.resultingValue, resultingValue) || other.resultingValue == resultingValue)&&(identical(other.relatedTileId, relatedTileId) || other.relatedTileId == relatedTileId)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tileId,actionType,fromRow,fromCol,toRow,toCol,resultingValue,relatedTileId,direction);

@override
String toString() {
  return 'TileAction(tileId: $tileId, actionType: $actionType, fromRow: $fromRow, fromCol: $fromCol, toRow: $toRow, toCol: $toCol, resultingValue: $resultingValue, relatedTileId: $relatedTileId, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$TileActionCopyWith<$Res> implements $TileActionCopyWith<$Res> {
  factory _$TileActionCopyWith(_TileAction value, $Res Function(_TileAction) _then) = __$TileActionCopyWithImpl;
@override @useResult
$Res call({
 String tileId, TileActionType actionType, int fromRow, int fromCol, int toRow, int toCol, int? resultingValue, String? relatedTileId, Direction? direction
});




}
/// @nodoc
class __$TileActionCopyWithImpl<$Res>
    implements _$TileActionCopyWith<$Res> {
  __$TileActionCopyWithImpl(this._self, this._then);

  final _TileAction _self;
  final $Res Function(_TileAction) _then;

/// Create a copy of TileAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tileId = null,Object? actionType = null,Object? fromRow = null,Object? fromCol = null,Object? toRow = null,Object? toCol = null,Object? resultingValue = freezed,Object? relatedTileId = freezed,Object? direction = freezed,}) {
  return _then(_TileAction(
tileId: null == tileId ? _self.tileId : tileId // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as TileActionType,fromRow: null == fromRow ? _self.fromRow : fromRow // ignore: cast_nullable_to_non_nullable
as int,fromCol: null == fromCol ? _self.fromCol : fromCol // ignore: cast_nullable_to_non_nullable
as int,toRow: null == toRow ? _self.toRow : toRow // ignore: cast_nullable_to_non_nullable
as int,toCol: null == toCol ? _self.toCol : toCol // ignore: cast_nullable_to_non_nullable
as int,resultingValue: freezed == resultingValue ? _self.resultingValue : resultingValue // ignore: cast_nullable_to_non_nullable
as int?,relatedTileId: freezed == relatedTileId ? _self.relatedTileId : relatedTileId // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction?,
  ));
}


}

// dart format on
