import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/move.dart';
import 'objective_checker.dart';

class StuckDetector {
  const StuckDetector({ObjectiveChecker? objectiveChecker})
      : _objectiveChecker = objectiveChecker ?? const ObjectiveChecker();

  final ObjectiveChecker _objectiveChecker;

  bool isStuck(LevelModel level, BoardModel board) {
    if (_objectiveChecker.isSolved(level, board)) {
      return false;
    }

    for (final tile in board.tiles.where((t) => t.isMovable)) {
      for (final direction in Direction.values) {
        final targetRow = tile.row + direction.rowDelta;
        final targetCol = tile.col + direction.colDelta;
        if (!board.isInBounds(targetRow, targetCol)) {
          continue;
        }
        final occupant = board.tileAt(targetRow, targetCol);
        if (occupant == null || occupant.isMovable) {
          return false;
        }
      }
    }
    return true;
  }
}
