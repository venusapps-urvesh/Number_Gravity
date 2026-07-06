import '../../models/board_model.dart';
import '../../models/move.dart';
import '../../models/tile_model.dart';
import '../../models/tile_type.dart';

/// Internal board helpers for the simulation engine.
class BoardUtils {
  BoardUtils._();

  static List<TileModel> sortedMovableTiles(BoardModel board) {
    return board.tiles.where((t) => t.isMovable).toList()
      ..sort((a, b) {
        final rowCmp = a.row.compareTo(b.row);
        if (rowCmp != 0) {
          return rowCmp;
        }
        final colCmp = a.col.compareTo(b.col);
        if (colCmp != 0) {
          return colCmp;
        }
        return a.id.compareTo(b.id);
      });
  }

  static List<TileModel> gravitySources(BoardModel board) {
    return board.tiles.where((t) => t.type.emitsGravity && t.value != 0).toList()
      ..sort((a, b) {
        final rowCmp = a.row.compareTo(b.row);
        if (rowCmp != 0) {
          return rowCmp;
        }
        final colCmp = a.col.compareTo(b.col);
        if (colCmp != 0) {
          return colCmp;
        }
        return a.id.compareTo(b.id);
      });
  }

  static bool blocksCell(BoardModel board, int row, int col) {
    if (!board.isInBounds(row, col)) {
      return true;
    }
    final tile = board.tileAt(row, col);
    if (tile == null) {
      return false;
    }
    if (tile.type == TileType.door && !tile.isDoorOpen) {
      return true;
    }
    if (tile.type == TileType.wall) {
      return true;
    }
    return false;
  }

  static bool isOccupiedByMovable(BoardModel board, int row, int col) {
    final tile = board.tileAt(row, col);
    return tile != null && tile.isMovable;
  }

  static (int row, int col) stepFrom(
    int row,
    int col,
    Direction direction,
  ) {
    return (
      row + direction.rowDelta,
      col + direction.colDelta,
    );
  }
}
