import '../../models/board_model.dart';
import '../../models/simulation/tile_action.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';

/// Toggles linked doors when a tile crosses a switch.
class SwitchDoorProcessor {
  const SwitchDoorProcessor();

  SwitchDoorResult processEntry({
    required BoardModel board,
    required TileModel tile,
    required int row,
    required int col,
  }) {
    final cell = board.tileAt(row, col);
    if (cell == null || cell.type != TileType.switchTile) {
      return SwitchDoorResult(board: board);
    }

    final switchId = cell.switchId ?? cell.id;
    final updatedTiles = board.tiles.map((existing) {
      if (existing.type == TileType.door && existing.doorId == switchId) {
        return existing.copyWith(isDoorOpen: !existing.isDoorOpen);
      }
      return existing;
    }).toList(growable: false);

    return SwitchDoorResult(
      board: board.copyWith(tiles: updatedTiles),
      action: TileAction(
        tileId: tile.id,
        actionType: TileActionType.toggle,
        fromRow: tile.row,
        fromCol: tile.col,
        toRow: row,
        toCol: col,
        relatedTileId: cell.id,
      ),
    );
  }
}

class SwitchDoorResult {
  const SwitchDoorResult({
    required this.board,
    this.action,
  });

  final BoardModel board;
  final TileAction? action;
}
