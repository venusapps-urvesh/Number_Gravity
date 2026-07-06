// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BoardModel _$BoardModelFromJson(Map<String, dynamic> json) {
  return _BoardModel.fromJson(json);
}

/// @nodoc
mixin _$BoardModel {
  int get rows => throw _privateConstructorUsedError;
  int get cols => throw _privateConstructorUsedError;
  List<TileModel> get tiles => throw _privateConstructorUsedError;

  /// Serializes this BoardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoardModelCopyWith<BoardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardModelCopyWith<$Res> {
  factory $BoardModelCopyWith(
    BoardModel value,
    $Res Function(BoardModel) then,
  ) = _$BoardModelCopyWithImpl<$Res, BoardModel>;
  @useResult
  $Res call({int rows, int cols, List<TileModel> tiles});
}

/// @nodoc
class _$BoardModelCopyWithImpl<$Res, $Val extends BoardModel>
    implements $BoardModelCopyWith<$Res> {
  _$BoardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rows = null, Object? cols = null, Object? tiles = null}) {
    return _then(
      _value.copyWith(
            rows: null == rows
                ? _value.rows
                : rows // ignore: cast_nullable_to_non_nullable
                      as int,
            cols: null == cols
                ? _value.cols
                : cols // ignore: cast_nullable_to_non_nullable
                      as int,
            tiles: null == tiles
                ? _value.tiles
                : tiles // ignore: cast_nullable_to_non_nullable
                      as List<TileModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BoardModelImplCopyWith<$Res>
    implements $BoardModelCopyWith<$Res> {
  factory _$$BoardModelImplCopyWith(
    _$BoardModelImpl value,
    $Res Function(_$BoardModelImpl) then,
  ) = __$$BoardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rows, int cols, List<TileModel> tiles});
}

/// @nodoc
class __$$BoardModelImplCopyWithImpl<$Res>
    extends _$BoardModelCopyWithImpl<$Res, _$BoardModelImpl>
    implements _$$BoardModelImplCopyWith<$Res> {
  __$$BoardModelImplCopyWithImpl(
    _$BoardModelImpl _value,
    $Res Function(_$BoardModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rows = null, Object? cols = null, Object? tiles = null}) {
    return _then(
      _$BoardModelImpl(
        rows: null == rows
            ? _value.rows
            : rows // ignore: cast_nullable_to_non_nullable
                  as int,
        cols: null == cols
            ? _value.cols
            : cols // ignore: cast_nullable_to_non_nullable
                  as int,
        tiles: null == tiles
            ? _value._tiles
            : tiles // ignore: cast_nullable_to_non_nullable
                  as List<TileModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardModelImpl extends _BoardModel {
  const _$BoardModelImpl({
    required this.rows,
    required this.cols,
    final List<TileModel> tiles = const [],
  }) : _tiles = tiles,
       super._();

  factory _$BoardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardModelImplFromJson(json);

  @override
  final int rows;
  @override
  final int cols;
  final List<TileModel> _tiles;
  @override
  @JsonKey()
  List<TileModel> get tiles {
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiles);
  }

  @override
  String toString() {
    return 'BoardModel(rows: $rows, cols: $cols, tiles: $tiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardModelImpl &&
            (identical(other.rows, rows) || other.rows == rows) &&
            (identical(other.cols, cols) || other.cols == cols) &&
            const DeepCollectionEquality().equals(other._tiles, _tiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rows,
    cols,
    const DeepCollectionEquality().hash(_tiles),
  );

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardModelImplCopyWith<_$BoardModelImpl> get copyWith =>
      __$$BoardModelImplCopyWithImpl<_$BoardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardModelImplToJson(this);
  }
}

abstract class _BoardModel extends BoardModel {
  const factory _BoardModel({
    required final int rows,
    required final int cols,
    final List<TileModel> tiles,
  }) = _$BoardModelImpl;
  const _BoardModel._() : super._();

  factory _BoardModel.fromJson(Map<String, dynamic> json) =
      _$BoardModelImpl.fromJson;

  @override
  int get rows;
  @override
  int get cols;
  @override
  List<TileModel> get tiles;

  /// Create a copy of BoardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardModelImplCopyWith<_$BoardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
