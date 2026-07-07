// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TileModel {

 String get id; TileType get type; int get value; int get row; int get col; bool get isLocked; String? get portalPairId; String? get switchId; String? get doorId; bool get isDoorOpen; bool get allowsMerge; bool get allowsSplit; int get modifierFactor;
/// Create a copy of TileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TileModelCopyWith<TileModel> get copyWith => _$TileModelCopyWithImpl<TileModel>(this as TileModel, _$identity);

  /// Serializes this TileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.portalPairId, portalPairId) || other.portalPairId == portalPairId)&&(identical(other.switchId, switchId) || other.switchId == switchId)&&(identical(other.doorId, doorId) || other.doorId == doorId)&&(identical(other.isDoorOpen, isDoorOpen) || other.isDoorOpen == isDoorOpen)&&(identical(other.allowsMerge, allowsMerge) || other.allowsMerge == allowsMerge)&&(identical(other.allowsSplit, allowsSplit) || other.allowsSplit == allowsSplit)&&(identical(other.modifierFactor, modifierFactor) || other.modifierFactor == modifierFactor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,value,row,col,isLocked,portalPairId,switchId,doorId,isDoorOpen,allowsMerge,allowsSplit,modifierFactor);

@override
String toString() {
  return 'TileModel(id: $id, type: $type, value: $value, row: $row, col: $col, isLocked: $isLocked, portalPairId: $portalPairId, switchId: $switchId, doorId: $doorId, isDoorOpen: $isDoorOpen, allowsMerge: $allowsMerge, allowsSplit: $allowsSplit, modifierFactor: $modifierFactor)';
}


}

/// @nodoc
abstract mixin class $TileModelCopyWith<$Res>  {
  factory $TileModelCopyWith(TileModel value, $Res Function(TileModel) _then) = _$TileModelCopyWithImpl;
@useResult
$Res call({
 String id, TileType type, int value, int row, int col, bool isLocked, String? portalPairId, String? switchId, String? doorId, bool isDoorOpen, bool allowsMerge, bool allowsSplit, int modifierFactor
});




}
/// @nodoc
class _$TileModelCopyWithImpl<$Res>
    implements $TileModelCopyWith<$Res> {
  _$TileModelCopyWithImpl(this._self, this._then);

  final TileModel _self;
  final $Res Function(TileModel) _then;

/// Create a copy of TileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? value = null,Object? row = null,Object? col = null,Object? isLocked = null,Object? portalPairId = freezed,Object? switchId = freezed,Object? doorId = freezed,Object? isDoorOpen = null,Object? allowsMerge = null,Object? allowsSplit = null,Object? modifierFactor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TileType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,portalPairId: freezed == portalPairId ? _self.portalPairId : portalPairId // ignore: cast_nullable_to_non_nullable
as String?,switchId: freezed == switchId ? _self.switchId : switchId // ignore: cast_nullable_to_non_nullable
as String?,doorId: freezed == doorId ? _self.doorId : doorId // ignore: cast_nullable_to_non_nullable
as String?,isDoorOpen: null == isDoorOpen ? _self.isDoorOpen : isDoorOpen // ignore: cast_nullable_to_non_nullable
as bool,allowsMerge: null == allowsMerge ? _self.allowsMerge : allowsMerge // ignore: cast_nullable_to_non_nullable
as bool,allowsSplit: null == allowsSplit ? _self.allowsSplit : allowsSplit // ignore: cast_nullable_to_non_nullable
as bool,modifierFactor: null == modifierFactor ? _self.modifierFactor : modifierFactor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TileModel].
extension TileModelPatterns on TileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TileModel value)  $default,){
final _that = this;
switch (_that) {
case _TileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TileModel value)?  $default,){
final _that = this;
switch (_that) {
case _TileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TileType type,  int value,  int row,  int col,  bool isLocked,  String? portalPairId,  String? switchId,  String? doorId,  bool isDoorOpen,  bool allowsMerge,  bool allowsSplit,  int modifierFactor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TileModel() when $default != null:
return $default(_that.id,_that.type,_that.value,_that.row,_that.col,_that.isLocked,_that.portalPairId,_that.switchId,_that.doorId,_that.isDoorOpen,_that.allowsMerge,_that.allowsSplit,_that.modifierFactor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TileType type,  int value,  int row,  int col,  bool isLocked,  String? portalPairId,  String? switchId,  String? doorId,  bool isDoorOpen,  bool allowsMerge,  bool allowsSplit,  int modifierFactor)  $default,) {final _that = this;
switch (_that) {
case _TileModel():
return $default(_that.id,_that.type,_that.value,_that.row,_that.col,_that.isLocked,_that.portalPairId,_that.switchId,_that.doorId,_that.isDoorOpen,_that.allowsMerge,_that.allowsSplit,_that.modifierFactor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TileType type,  int value,  int row,  int col,  bool isLocked,  String? portalPairId,  String? switchId,  String? doorId,  bool isDoorOpen,  bool allowsMerge,  bool allowsSplit,  int modifierFactor)?  $default,) {final _that = this;
switch (_that) {
case _TileModel() when $default != null:
return $default(_that.id,_that.type,_that.value,_that.row,_that.col,_that.isLocked,_that.portalPairId,_that.switchId,_that.doorId,_that.isDoorOpen,_that.allowsMerge,_that.allowsSplit,_that.modifierFactor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TileModel extends TileModel {
  const _TileModel({required this.id, required this.type, this.value = 0, required this.row, required this.col, this.isLocked = false, this.portalPairId, this.switchId, this.doorId, this.isDoorOpen = false, this.allowsMerge = false, this.allowsSplit = false, this.modifierFactor = 1}): super._();
  factory _TileModel.fromJson(Map<String, dynamic> json) => _$TileModelFromJson(json);

@override final  String id;
@override final  TileType type;
@override@JsonKey() final  int value;
@override final  int row;
@override final  int col;
@override@JsonKey() final  bool isLocked;
@override final  String? portalPairId;
@override final  String? switchId;
@override final  String? doorId;
@override@JsonKey() final  bool isDoorOpen;
@override@JsonKey() final  bool allowsMerge;
@override@JsonKey() final  bool allowsSplit;
@override@JsonKey() final  int modifierFactor;

/// Create a copy of TileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TileModelCopyWith<_TileModel> get copyWith => __$TileModelCopyWithImpl<_TileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.portalPairId, portalPairId) || other.portalPairId == portalPairId)&&(identical(other.switchId, switchId) || other.switchId == switchId)&&(identical(other.doorId, doorId) || other.doorId == doorId)&&(identical(other.isDoorOpen, isDoorOpen) || other.isDoorOpen == isDoorOpen)&&(identical(other.allowsMerge, allowsMerge) || other.allowsMerge == allowsMerge)&&(identical(other.allowsSplit, allowsSplit) || other.allowsSplit == allowsSplit)&&(identical(other.modifierFactor, modifierFactor) || other.modifierFactor == modifierFactor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,value,row,col,isLocked,portalPairId,switchId,doorId,isDoorOpen,allowsMerge,allowsSplit,modifierFactor);

@override
String toString() {
  return 'TileModel(id: $id, type: $type, value: $value, row: $row, col: $col, isLocked: $isLocked, portalPairId: $portalPairId, switchId: $switchId, doorId: $doorId, isDoorOpen: $isDoorOpen, allowsMerge: $allowsMerge, allowsSplit: $allowsSplit, modifierFactor: $modifierFactor)';
}


}

/// @nodoc
abstract mixin class _$TileModelCopyWith<$Res> implements $TileModelCopyWith<$Res> {
  factory _$TileModelCopyWith(_TileModel value, $Res Function(_TileModel) _then) = __$TileModelCopyWithImpl;
@override @useResult
$Res call({
 String id, TileType type, int value, int row, int col, bool isLocked, String? portalPairId, String? switchId, String? doorId, bool isDoorOpen, bool allowsMerge, bool allowsSplit, int modifierFactor
});




}
/// @nodoc
class __$TileModelCopyWithImpl<$Res>
    implements _$TileModelCopyWith<$Res> {
  __$TileModelCopyWithImpl(this._self, this._then);

  final _TileModel _self;
  final $Res Function(_TileModel) _then;

/// Create a copy of TileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? value = null,Object? row = null,Object? col = null,Object? isLocked = null,Object? portalPairId = freezed,Object? switchId = freezed,Object? doorId = freezed,Object? isDoorOpen = null,Object? allowsMerge = null,Object? allowsSplit = null,Object? modifierFactor = null,}) {
  return _then(_TileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TileType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,portalPairId: freezed == portalPairId ? _self.portalPairId : portalPairId // ignore: cast_nullable_to_non_nullable
as String?,switchId: freezed == switchId ? _self.switchId : switchId // ignore: cast_nullable_to_non_nullable
as String?,doorId: freezed == doorId ? _self.doorId : doorId // ignore: cast_nullable_to_non_nullable
as String?,isDoorOpen: null == isDoorOpen ? _self.isDoorOpen : isDoorOpen // ignore: cast_nullable_to_non_nullable
as bool,allowsMerge: null == allowsMerge ? _self.allowsMerge : allowsMerge // ignore: cast_nullable_to_non_nullable
as bool,allowsSplit: null == allowsSplit ? _self.allowsSplit : allowsSplit // ignore: cast_nullable_to_non_nullable
as bool,modifierFactor: null == modifierFactor ? _self.modifierFactor : modifierFactor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
