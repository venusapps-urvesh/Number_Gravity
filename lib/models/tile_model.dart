import 'package:freezed_annotation/freezed_annotation.dart';

import 'tile_type.dart';

part 'tile_model.freezed.dart';
part 'tile_model.g.dart';

@freezed
class TileModel with _$TileModel {
  const TileModel._();

  const factory TileModel({
    required String id,
    required TileType type,
    @Default(0) int value,
    required int row,
    required int col,
    @Default(false) bool isLocked,
    String? portalPairId,
    String? switchId,
    String? doorId,
    @Default(false) bool isDoorOpen,
    @Default(false) bool allowsMerge,
    @Default(false) bool allowsSplit,
    @Default(1) int modifierFactor,
  }) = _TileModel;

  factory TileModel.fromJson(Map<String, dynamic> json) =>
      _$TileModelFromJson(json);

  bool get isMovable => !isLocked && type.isMovableByDefault;

  bool get isNumberTile => type == TileType.number;

  TileModel movedTo({required int row, required int col}) {
    return copyWith(row: row, col: col);
  }
}
