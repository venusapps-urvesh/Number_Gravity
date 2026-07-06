import '../core/errors/app_exception.dart';
import '../core/extensions/board_extensions.dart';
import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/simulation_result.dart';

class BoardApplier {
  BoardModel apply(SimulationResult result) => result.finalBoard;

  BoardModel applyPlayerMove(BoardModel board, Move move) {
    final tile = board.tileById(move.tileId);
    if (tile == null) {
      throw SimulationException('Tile not found: ${move.tileId}');
    }

    if (!tile.isMovable) {
      throw SimulationException('Tile is not movable: ${move.tileId}');
    }

    if (!board.canAcceptPlayerMove(move)) {
      throw SimulationException('Illegal player move: ${move.tileId}');
    }

    final targetRow = tile.row + move.direction.rowDelta;
    final targetCol = tile.col + move.direction.colDelta;

    return board.copyWithTileAt(
      tileId: move.tileId,
      row: targetRow,
      col: targetCol,
    );
  }
}
