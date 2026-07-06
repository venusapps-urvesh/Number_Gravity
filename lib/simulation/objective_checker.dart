import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/objective/objective_model.dart';

class ObjectiveChecker {
  const ObjectiveChecker();

  bool isSolved(LevelModel level, BoardModel board) {
    return level.objective.when(
      position: (tileId, goalRow, goalCol) {
        final tile = board.tileById(tileId);
        return tile != null && tile.row == goalRow && tile.col == goalCol;
      },
      sequence: (tileIds, targetValues) {
        if (tileIds.length != targetValues.length) {
          return false;
        }
        for (var i = 0; i < tileIds.length; i++) {
          final tile = board.tileById(tileIds[i]);
          if (tile == null || tile.value != targetValues[i]) {
            return false;
          }
        }
        return true;
      },
      sum: (tileIds, targetSum) {
        var total = 0;
        for (final id in tileIds) {
          final tile = board.tileById(id);
          if (tile == null) {
            return false;
          }
          total += tile.value;
        }
        return total == targetSum;
      },
      balance: (regionTileIds, targetValue) {
        for (final id in regionTileIds) {
          final tile = board.tileById(id);
          if (tile == null || tile.value != targetValue) {
            return false;
          }
        }
        return true;
      },
      collection: (tileGoals) {
        for (final entry in tileGoals.entries) {
          final tile = board.tileById(entry.key);
          if (tile == null) {
            return false;
          }
          final matchesGoal = entry.value.length == 2 &&
              tile.row == entry.value[0] &&
              tile.col == entry.value[1];
          if (!matchesGoal) {
            return false;
          }
        }
        return true;
      },
      chain: (_) => false,
    );
  }
}
