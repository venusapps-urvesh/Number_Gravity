import '../../models/board_model.dart';
import '../../models/simulation/tile_action.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';

/// Handles portal teleportation per Section 3.
class PortalProcessor {
  const PortalProcessor();

  PortalResult process({
    required BoardModel board,
    required TileModel tile,
    required int row,
    required int col,
  }) {
    final cell = board.backgroundTileAt(row, col);
    if (cell == null || cell.type != TileType.portal) {
      return PortalResult.unchanged(tile, row, col);
    }

    final pairId = cell.portalPairId;
    if (pairId == null) {
      return PortalResult.unchanged(tile, row, col);
    }

    final exit = board.tileById(pairId);
    if (exit == null || exit.type != TileType.portal) {
      return PortalResult.unchanged(tile, row, col);
    }

    final hasMovableBlocker = board.tilesAt(exit.row, exit.col).any(
      (existing) => existing.isMovable && existing.id != tile.id,
    );
    if (hasMovableBlocker) {
      return PortalResult.unchanged(tile, row, col);
    }

    final teleported = tile.movedTo(row: exit.row, col: exit.col);
    return PortalResult.teleported(
      tile: teleported,
      action: TileAction(
        tileId: tile.id,
        actionType: TileActionType.portal,
        fromRow: row,
        fromCol: col,
        toRow: exit.row,
        toCol: exit.col,
        relatedTileId: exit.id,
      ),
    );
  }
}

class PortalResult {
  const PortalResult._({
    required this.tile,
    required this.row,
    required this.col,
    this.action,
  });

  factory PortalResult.unchanged(TileModel tile, int row, int col) {
    return PortalResult._(tile: tile, row: row, col: col);
  }

  factory PortalResult.teleported({
    required TileModel tile,
    required TileAction action,
  }) {
    return PortalResult._(
      tile: tile,
      row: tile.row,
      col: tile.col,
      action: action,
    );
  }

  final TileModel tile;
  final int row;
  final int col;
  final TileAction? action;
}
