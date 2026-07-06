import '../../core/constants/game_constants.dart';
import '../../models/board_model.dart';
import '../../models/simulation/tile_action.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';

/// Applies modifier tiles when a number lands on them.
class ModifierProcessor {
  const ModifierProcessor();

  ModifierResult apply({
    required BoardModel board,
    required TileModel tile,
    required int row,
    required int col,
  }) {
    final modifier = board.tileAt(row, col);
    if (modifier == null || tile.type != TileType.number) {
      return ModifierResult.unchanged(tile);
    }

    return switch (modifier.type) {
      TileType.multiplier => _multiply(tile, modifier),
      TileType.divider => _divide(tile, modifier),
      TileType.inverter => _invert(tile, modifier),
      _ => ModifierResult.unchanged(tile),
    };
  }

  ModifierResult _multiply(TileModel tile, TileModel modifier) {
    final factor = modifier.modifierFactor <= 0 ? 1 : modifier.modifierFactor;
    final value = _clamp(tile.value * factor);
    return ModifierResult.modified(
      tile: tile.copyWith(value: value),
      action: TileAction(
        tileId: tile.id,
        actionType: TileActionType.modify,
        fromRow: tile.row,
        fromCol: tile.col,
        toRow: tile.row,
        toCol: tile.col,
        resultingValue: value,
        relatedTileId: modifier.id,
      ),
    );
  }

  ModifierResult _divide(TileModel tile, TileModel modifier) {
    final factor = modifier.modifierFactor <= 0 ? 1 : modifier.modifierFactor;
    var value = tile.value ~/ factor;
    if (value == 0 && tile.value != 0) {
      value = tile.value.sign * minTileMagnitude;
    }
    value = _clamp(value);
    return ModifierResult.modified(
      tile: tile.copyWith(value: value),
      action: TileAction(
        tileId: tile.id,
        actionType: TileActionType.modify,
        fromRow: tile.row,
        fromCol: tile.col,
        toRow: tile.row,
        toCol: tile.col,
        resultingValue: value,
        relatedTileId: modifier.id,
      ),
    );
  }

  ModifierResult _invert(TileModel tile, TileModel modifier) {
    final value = _clamp(-tile.value);
    return ModifierResult.modified(
      tile: tile.copyWith(value: value),
      action: TileAction(
        tileId: tile.id,
        actionType: TileActionType.invert,
        fromRow: tile.row,
        fromCol: tile.col,
        toRow: tile.row,
        toCol: tile.col,
        resultingValue: value,
        relatedTileId: modifier.id,
      ),
    );
  }

  int _clamp(int value) {
    if (value > maxTileValue) {
      return maxTileValue;
    }
    if (value < -maxTileValue) {
      return -maxTileValue;
    }
    return value;
  }
}

class ModifierResult {
  const ModifierResult._({
    required this.tile,
    this.action,
  });

  factory ModifierResult.unchanged(TileModel tile) {
    return ModifierResult._(tile: tile);
  }

  factory ModifierResult.modified({
    required TileModel tile,
    required TileAction action,
  }) {
    return ModifierResult._(tile: tile, action: action);
  }

  final TileModel tile;
  final TileAction? action;
}
