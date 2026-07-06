import '../models/board_model.dart';
import '../models/move.dart';
import '../models/tile_model.dart';
import 'force_calculator.dart';
import 'tie_breaker.dart';
import 'utils/board_utils.dart';

/// Checks whether the board has reached a stable gravity state.
class StabilityChecker {
  const StabilityChecker({
    ForceCalculator? forceCalculator,
    TieBreaker? tieBreaker,
  })  : _forceCalculator = forceCalculator ?? const ForceCalculator(),
        _tieBreaker = tieBreaker ?? const TieBreaker();

  final ForceCalculator _forceCalculator;
  final TieBreaker _tieBreaker;

  bool isStable(BoardModel board) {
    for (final tile in BoardUtils.sortedMovableTiles(board)) {
      if (intendedDirection(board, tile) != null) {
        return false;
      }
    }
    return true;
  }

  Direction? intendedDirection(BoardModel board, TileModel tile) {
    final forces = _forceCalculator.computeDirectionalForces(board, tile);
    if (!forces.hasAnyForce) {
      return null;
    }
    final direction = _tieBreaker.resolveMovement(forces);
    if (direction == null) {
      return null;
    }

    final (targetRow, targetCol) =
        BoardUtils.stepFrom(tile.row, tile.col, direction);

    if (BoardUtils.blocksCell(board, targetRow, targetCol)) {
      return null;
    }

    final occupant = board.tileAt(targetRow, targetCol);
    if (occupant != null && !occupant.isMovable) {
      return null;
    }

    return direction;
  }
}
