// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tile_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TileAction _$TileActionFromJson(Map<String, dynamic> json) {
  return _TileAction.fromJson(json);
}

/// @nodoc
mixin _$TileAction {
  String get tileId => throw _privateConstructorUsedError;
  TileActionType get actionType => throw _privateConstructorUsedError;
  int get fromRow => throw _privateConstructorUsedError;
  int get fromCol => throw _privateConstructorUsedError;
  int get toRow => throw _privateConstructorUsedError;
  int get toCol => throw _privateConstructorUsedError;
  int? get resultingValue => throw _privateConstructorUsedError;
  String? get relatedTileId => throw _privateConstructorUsedError;
  Direction? get direction => throw _privateConstructorUsedError;

  /// Serializes this TileAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TileAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TileActionCopyWith<TileAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileActionCopyWith<$Res> {
  factory $TileActionCopyWith(
    TileAction value,
    $Res Function(TileAction) then,
  ) = _$TileActionCopyWithImpl<$Res, TileAction>;
  @useResult
  $Res call({
    String tileId,
    TileActionType actionType,
    int fromRow,
    int fromCol,
    int toRow,
    int toCol,
    int? resultingValue,
    String? relatedTileId,
    Direction? direction,
  });
}

/// @nodoc
class _$TileActionCopyWithImpl<$Res, $Val extends TileAction>
    implements $TileActionCopyWith<$Res> {
  _$TileActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TileAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? actionType = null,
    Object? fromRow = null,
    Object? fromCol = null,
    Object? toRow = null,
    Object? toCol = null,
    Object? resultingValue = freezed,
    Object? relatedTileId = freezed,
    Object? direction = freezed,
  }) {
    return _then(
      _value.copyWith(
            tileId: null == tileId
                ? _value.tileId
                : tileId // ignore: cast_nullable_to_non_nullable
                      as String,
            actionType: null == actionType
                ? _value.actionType
                : actionType // ignore: cast_nullable_to_non_nullable
                      as TileActionType,
            fromRow: null == fromRow
                ? _value.fromRow
                : fromRow // ignore: cast_nullable_to_non_nullable
                      as int,
            fromCol: null == fromCol
                ? _value.fromCol
                : fromCol // ignore: cast_nullable_to_non_nullable
                      as int,
            toRow: null == toRow
                ? _value.toRow
                : toRow // ignore: cast_nullable_to_non_nullable
                      as int,
            toCol: null == toCol
                ? _value.toCol
                : toCol // ignore: cast_nullable_to_non_nullable
                      as int,
            resultingValue: freezed == resultingValue
                ? _value.resultingValue
                : resultingValue // ignore: cast_nullable_to_non_nullable
                      as int?,
            relatedTileId: freezed == relatedTileId
                ? _value.relatedTileId
                : relatedTileId // ignore: cast_nullable_to_non_nullable
                      as String?,
            direction: freezed == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as Direction?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TileActionImplCopyWith<$Res>
    implements $TileActionCopyWith<$Res> {
  factory _$$TileActionImplCopyWith(
    _$TileActionImpl value,
    $Res Function(_$TileActionImpl) then,
  ) = __$$TileActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tileId,
    TileActionType actionType,
    int fromRow,
    int fromCol,
    int toRow,
    int toCol,
    int? resultingValue,
    String? relatedTileId,
    Direction? direction,
  });
}

/// @nodoc
class __$$TileActionImplCopyWithImpl<$Res>
    extends _$TileActionCopyWithImpl<$Res, _$TileActionImpl>
    implements _$$TileActionImplCopyWith<$Res> {
  __$$TileActionImplCopyWithImpl(
    _$TileActionImpl _value,
    $Res Function(_$TileActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TileAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tileId = null,
    Object? actionType = null,
    Object? fromRow = null,
    Object? fromCol = null,
    Object? toRow = null,
    Object? toCol = null,
    Object? resultingValue = freezed,
    Object? relatedTileId = freezed,
    Object? direction = freezed,
  }) {
    return _then(
      _$TileActionImpl(
        tileId: null == tileId
            ? _value.tileId
            : tileId // ignore: cast_nullable_to_non_nullable
                  as String,
        actionType: null == actionType
            ? _value.actionType
            : actionType // ignore: cast_nullable_to_non_nullable
                  as TileActionType,
        fromRow: null == fromRow
            ? _value.fromRow
            : fromRow // ignore: cast_nullable_to_non_nullable
                  as int,
        fromCol: null == fromCol
            ? _value.fromCol
            : fromCol // ignore: cast_nullable_to_non_nullable
                  as int,
        toRow: null == toRow
            ? _value.toRow
            : toRow // ignore: cast_nullable_to_non_nullable
                  as int,
        toCol: null == toCol
            ? _value.toCol
            : toCol // ignore: cast_nullable_to_non_nullable
                  as int,
        resultingValue: freezed == resultingValue
            ? _value.resultingValue
            : resultingValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        relatedTileId: freezed == relatedTileId
            ? _value.relatedTileId
            : relatedTileId // ignore: cast_nullable_to_non_nullable
                  as String?,
        direction: freezed == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as Direction?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TileActionImpl implements _TileAction {
  const _$TileActionImpl({
    required this.tileId,
    required this.actionType,
    required this.fromRow,
    required this.fromCol,
    required this.toRow,
    required this.toCol,
    this.resultingValue,
    this.relatedTileId,
    this.direction,
  });

  factory _$TileActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileActionImplFromJson(json);

  @override
  final String tileId;
  @override
  final TileActionType actionType;
  @override
  final int fromRow;
  @override
  final int fromCol;
  @override
  final int toRow;
  @override
  final int toCol;
  @override
  final int? resultingValue;
  @override
  final String? relatedTileId;
  @override
  final Direction? direction;

  @override
  String toString() {
    return 'TileAction(tileId: $tileId, actionType: $actionType, fromRow: $fromRow, fromCol: $fromCol, toRow: $toRow, toCol: $toCol, resultingValue: $resultingValue, relatedTileId: $relatedTileId, direction: $direction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileActionImpl &&
            (identical(other.tileId, tileId) || other.tileId == tileId) &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.fromRow, fromRow) || other.fromRow == fromRow) &&
            (identical(other.fromCol, fromCol) || other.fromCol == fromCol) &&
            (identical(other.toRow, toRow) || other.toRow == toRow) &&
            (identical(other.toCol, toCol) || other.toCol == toCol) &&
            (identical(other.resultingValue, resultingValue) ||
                other.resultingValue == resultingValue) &&
            (identical(other.relatedTileId, relatedTileId) ||
                other.relatedTileId == relatedTileId) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tileId,
    actionType,
    fromRow,
    fromCol,
    toRow,
    toCol,
    resultingValue,
    relatedTileId,
    direction,
  );

  /// Create a copy of TileAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TileActionImplCopyWith<_$TileActionImpl> get copyWith =>
      __$$TileActionImplCopyWithImpl<_$TileActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileActionImplToJson(this);
  }
}

abstract class _TileAction implements TileAction {
  const factory _TileAction({
    required final String tileId,
    required final TileActionType actionType,
    required final int fromRow,
    required final int fromCol,
    required final int toRow,
    required final int toCol,
    final int? resultingValue,
    final String? relatedTileId,
    final Direction? direction,
  }) = _$TileActionImpl;

  factory _TileAction.fromJson(Map<String, dynamic> json) =
      _$TileActionImpl.fromJson;

  @override
  String get tileId;
  @override
  TileActionType get actionType;
  @override
  int get fromRow;
  @override
  int get fromCol;
  @override
  int get toRow;
  @override
  int get toCol;
  @override
  int? get resultingValue;
  @override
  String? get relatedTileId;
  @override
  Direction? get direction;

  /// Create a copy of TileAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TileActionImplCopyWith<_$TileActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
