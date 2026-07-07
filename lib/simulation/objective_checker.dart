import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/objective/objective_model.dart';
import '../models/tile_type.dart';

class ObjectiveChecker {
  const ObjectiveChecker();

  bool isSolved(LevelModel level, BoardModel board) {
    return switch (level.objective) {
      PositionObjective(:final tileId, :final goalRow, :final goalCol) => () {
        final tile = board.tileById(tileId);
        return tile != null && tile.row == goalRow && tile.col == goalCol;
      }(),
      SequenceObjective(:final tileIds, :final targetValues) => () {
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
      }(),
      SumObjective(:final tileIds, :final targetSum) => () {
        var total = 0;
        for (final id in tileIds) {
          final tile = board.tileById(id);
          if (tile == null) {
            return false;
          }
          total += tile.value;
        }
        return total == targetSum;
      }(),
      BalanceObjective(:final regionTileIds, :final targetValue) => () {
        for (final id in regionTileIds) {
          final tile = board.tileById(id);
          if (tile == null || tile.value != targetValue) {
            return false;
          }
        }
        return true;
      }(),
      CollectionObjective(:final tileGoals) => () {
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
      }(),
      ChainObjective(:final subObjectiveIds) => () {
        if (subObjectiveIds.isEmpty) {
          return false;
        }
        final goalCells = <String>{};
        for (final tile in board.tiles) {
          if (tile.type == TileType.goal) {
            goalCells.add('${tile.row},${tile.col}');
          }
        }
        if (goalCells.isEmpty) {
          return false;
        }
        for (final tileId in subObjectiveIds) {
          final tile = board.tileById(tileId);
          if (tile == null) {
            return false;
          }
          if (!goalCells.contains('${tile.row},${tile.col}')) {
            return false;
          }
        }
        return true;
      }(),
    };
  }
}
