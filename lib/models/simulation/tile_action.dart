import 'package:freezed_annotation/freezed_annotation.dart';

import '../move.dart';

part 'tile_action.freezed.dart';
part 'tile_action.g.dart';

enum TileActionType {
  move,
  collide,
  merge,
  split,
  annihilate,
  portal,
  modify,
  invert,
  toggle,
}

@freezed
abstract class TileAction with _$TileAction {
  const factory TileAction({
    required String tileId,
    required TileActionType actionType,
    required int fromRow,
    required int fromCol,
    required int toRow,
    required int toCol,
    int? resultingValue,
    String? relatedTileId,
    Direction? direction,
  }) = _TileAction;

  factory TileAction.fromJson(Map<String, dynamic> json) =>
      _$TileActionFromJson(json);
}
