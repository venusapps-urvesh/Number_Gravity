import 'dart:math';

import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/level/level_tier.dart';
import '../models/objective/objective_model.dart';
import '../models/tile_model.dart';
import '../models/tile_type.dart';

class DailyPuzzleGenerator {
  LevelModel generateForDate(DateTime date) {
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final random = Random(seed);

    final rows = 6 + random.nextInt(3);
    final cols = rows;
    const startRow = 0;
    const startCol = 0;
    final goalRow = rows - 1;
    final goalCol = cols - 1;
    final solutionMoves = _solutionMovesForCornerPath(
      startRow: startRow,
      startCol: startCol,
      goalRow: goalRow,
      goalCol: goalCol,
    );
    final board = BoardModel(
      rows: rows,
      cols: cols,
      tiles: [
        TileModel(
          id: 'daily_t1',
          type: TileType.number,
          value: 2 + random.nextInt(4),
          row: startRow,
          col: startCol,
        ),
        TileModel(
          id: 'daily_g1',
          type: TileType.goal,
          row: goalRow,
          col: goalCol,
          isLocked: true,
        ),
      ],
    );

    return LevelModel(
      id: seed,
      world: 0,
      tier: LevelTier.intermediate,
      board: board,
      objective: ObjectiveModel.position(
        tileId: 'daily_t1',
        goalRow: goalRow,
        goalCol: goalCol,
      ),
      minimumMoves: solutionMoves.length,
      solutionMoves: solutionMoves,
    );
  }

  List<String> _solutionMovesForCornerPath({
    required int startRow,
    required int startCol,
    required int goalRow,
    required int goalCol,
  }) {
    final horizontalMoves = (goalCol - startCol).abs();
    final verticalMoves = (goalRow - startRow).abs();
    final horizontalDirection = goalCol >= startCol ? 'R' : 'L';
    final verticalDirection = goalRow >= startRow ? 'D' : 'U';

    return [
      ...List.filled(horizontalMoves, horizontalDirection),
      ...List.filled(verticalMoves, verticalDirection),
    ];
  }
}
