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
    final board = BoardModel(
      rows: rows,
      cols: cols,
      tiles: [
        TileModel(
          id: 'daily_t1',
          type: TileType.number,
          value: 2 + random.nextInt(4),
          row: 0,
          col: 0,
        ),
        TileModel(
          id: 'daily_g1',
          type: TileType.goal,
          row: rows - 1,
          col: cols - 1,
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
        goalRow: rows - 1,
        goalCol: cols - 1,
      ),
      minimumMoves: 4,
      solutionMoves: const ['R', 'D', 'R', 'D'],
    );
  }
}
