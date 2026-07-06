// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TileModel _$TileModelFromJson(Map<String, dynamic> json) {
  return _TileModel.fromJson(json);
}

/// @nodoc
mixin _$TileModel {
  String get id => throw _privateConstructorUsedError;
  TileType get type => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  int get row => throw _privateConstructorUsedError;
  int get col => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError;
  String? get portalPairId => throw _privateConstructorUsedError;
  String? get switchId => throw _privateConstructorUsedError;
  String? get doorId => throw _privateConstructorUsedError;
  bool get isDoorOpen => throw _privateConstructorUsedError;
  bool get allowsMerge => throw _privateConstructorUsedError;
  bool get allowsSplit => throw _privateConstructorUsedError;
  int get modifierFactor => throw _privateConstructorUsedError;

  /// Serializes this TileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TileModelCopyWith<TileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileModelCopyWith<$Res> {
  factory $TileModelCopyWith(TileModel value, $Res Function(TileModel) then) =
      _$TileModelCopyWithImpl<$Res, TileModel>;
  @useResult
  $Res call({
    String id,
    TileType type,
    int value,
    int row,
    int col,
    bool isLocked,
    String? portalPairId,
    String? switchId,
    String? doorId,
    bool isDoorOpen,
    bool allowsMerge,
    bool allowsSplit,
    int modifierFactor,
  });
}

/// @nodoc
class _$TileModelCopyWithImpl<$Res, $Val extends TileModel>
    implements $TileModelCopyWith<$Res> {
  _$TileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = null,
    Object? row = null,
    Object? col = null,
    Object? isLocked = null,
    Object? portalPairId = freezed,
    Object? switchId = freezed,
    Object? doorId = freezed,
    Object? isDoorOpen = null,
    Object? allowsMerge = null,
    Object? allowsSplit = null,
    Object? modifierFactor = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TileType,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            row: null == row
                ? _value.row
                : row // ignore: cast_nullable_to_non_nullable
                      as int,
            col: null == col
                ? _value.col
                : col // ignore: cast_nullable_to_non_nullable
                      as int,
            isLocked: null == isLocked
                ? _value.isLocked
                : isLocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            portalPairId: freezed == portalPairId
                ? _value.portalPairId
                : portalPairId // ignore: cast_nullable_to_non_nullable
                      as String?,
            switchId: freezed == switchId
                ? _value.switchId
                : switchId // ignore: cast_nullable_to_non_nullable
                      as String?,
            doorId: freezed == doorId
                ? _value.doorId
                : doorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDoorOpen: null == isDoorOpen
                ? _value.isDoorOpen
                : isDoorOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowsMerge: null == allowsMerge
                ? _value.allowsMerge
                : allowsMerge // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowsSplit: null == allowsSplit
                ? _value.allowsSplit
                : allowsSplit // ignore: cast_nullable_to_non_nullable
                      as bool,
            modifierFactor: null == modifierFactor
                ? _value.modifierFactor
                : modifierFactor // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TileModelImplCopyWith<$Res>
    implements $TileModelCopyWith<$Res> {
  factory _$$TileModelImplCopyWith(
    _$TileModelImpl value,
    $Res Function(_$TileModelImpl) then,
  ) = __$$TileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    TileType type,
    int value,
    int row,
    int col,
    bool isLocked,
    String? portalPairId,
    String? switchId,
    String? doorId,
    bool isDoorOpen,
    bool allowsMerge,
    bool allowsSplit,
    int modifierFactor,
  });
}

/// @nodoc
class __$$TileModelImplCopyWithImpl<$Res>
    extends _$TileModelCopyWithImpl<$Res, _$TileModelImpl>
    implements _$$TileModelImplCopyWith<$Res> {
  __$$TileModelImplCopyWithImpl(
    _$TileModelImpl _value,
    $Res Function(_$TileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? value = null,
    Object? row = null,
    Object? col = null,
    Object? isLocked = null,
    Object? portalPairId = freezed,
    Object? switchId = freezed,
    Object? doorId = freezed,
    Object? isDoorOpen = null,
    Object? allowsMerge = null,
    Object? allowsSplit = null,
    Object? modifierFactor = null,
  }) {
    return _then(
      _$TileModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TileType,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        row: null == row
            ? _value.row
            : row // ignore: cast_nullable_to_non_nullable
                  as int,
        col: null == col
            ? _value.col
            : col // ignore: cast_nullable_to_non_nullable
                  as int,
        isLocked: null == isLocked
            ? _value.isLocked
            : isLocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        portalPairId: freezed == portalPairId
            ? _value.portalPairId
            : portalPairId // ignore: cast_nullable_to_non_nullable
                  as String?,
        switchId: freezed == switchId
            ? _value.switchId
            : switchId // ignore: cast_nullable_to_non_nullable
                  as String?,
        doorId: freezed == doorId
            ? _value.doorId
            : doorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDoorOpen: null == isDoorOpen
            ? _value.isDoorOpen
            : isDoorOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowsMerge: null == allowsMerge
            ? _value.allowsMerge
            : allowsMerge // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowsSplit: null == allowsSplit
            ? _value.allowsSplit
            : allowsSplit // ignore: cast_nullable_to_non_nullable
                  as bool,
        modifierFactor: null == modifierFactor
            ? _value.modifierFactor
            : modifierFactor // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TileModelImpl extends _TileModel {
  const _$TileModelImpl({
    required this.id,
    required this.type,
    this.value = 0,
    required this.row,
    required this.col,
    this.isLocked = false,
    this.portalPairId,
    this.switchId,
    this.doorId,
    this.isDoorOpen = false,
    this.allowsMerge = false,
    this.allowsSplit = false,
    this.modifierFactor = 1,
  }) : super._();

  factory _$TileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileModelImplFromJson(json);

  @override
  final String id;
  @override
  final TileType type;
  @override
  @JsonKey()
  final int value;
  @override
  final int row;
  @override
  final int col;
  @override
  @JsonKey()
  final bool isLocked;
  @override
  final String? portalPairId;
  @override
  final String? switchId;
  @override
  final String? doorId;
  @override
  @JsonKey()
  final bool isDoorOpen;
  @override
  @JsonKey()
  final bool allowsMerge;
  @override
  @JsonKey()
  final bool allowsSplit;
  @override
  @JsonKey()
  final int modifierFactor;

  @override
  String toString() {
    return 'TileModel(id: $id, type: $type, value: $value, row: $row, col: $col, isLocked: $isLocked, portalPairId: $portalPairId, switchId: $switchId, doorId: $doorId, isDoorOpen: $isDoorOpen, allowsMerge: $allowsMerge, allowsSplit: $allowsSplit, modifierFactor: $modifierFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.col, col) || other.col == col) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.portalPairId, portalPairId) ||
                other.portalPairId == portalPairId) &&
            (identical(other.switchId, switchId) ||
                other.switchId == switchId) &&
            (identical(other.doorId, doorId) || other.doorId == doorId) &&
            (identical(other.isDoorOpen, isDoorOpen) ||
                other.isDoorOpen == isDoorOpen) &&
            (identical(other.allowsMerge, allowsMerge) ||
                other.allowsMerge == allowsMerge) &&
            (identical(other.allowsSplit, allowsSplit) ||
                other.allowsSplit == allowsSplit) &&
            (identical(other.modifierFactor, modifierFactor) ||
                other.modifierFactor == modifierFactor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    value,
    row,
    col,
    isLocked,
    portalPairId,
    switchId,
    doorId,
    isDoorOpen,
    allowsMerge,
    allowsSplit,
    modifierFactor,
  );

  /// Create a copy of TileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TileModelImplCopyWith<_$TileModelImpl> get copyWith =>
      __$$TileModelImplCopyWithImpl<_$TileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileModelImplToJson(this);
  }
}

abstract class _TileModel extends TileModel {
  const factory _TileModel({
    required final String id,
    required final TileType type,
    final int value,
    required final int row,
    required final int col,
    final bool isLocked,
    final String? portalPairId,
    final String? switchId,
    final String? doorId,
    final bool isDoorOpen,
    final bool allowsMerge,
    final bool allowsSplit,
    final int modifierFactor,
  }) = _$TileModelImpl;
  const _TileModel._() : super._();

  factory _TileModel.fromJson(Map<String, dynamic> json) =
      _$TileModelImpl.fromJson;

  @override
  String get id;
  @override
  TileType get type;
  @override
  int get value;
  @override
  int get row;
  @override
  int get col;
  @override
  bool get isLocked;
  @override
  String? get portalPairId;
  @override
  String? get switchId;
  @override
  String? get doorId;
  @override
  bool get isDoorOpen;
  @override
  bool get allowsMerge;
  @override
  bool get allowsSplit;
  @override
  int get modifierFactor;

  /// Create a copy of TileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TileModelImplCopyWith<_$TileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
