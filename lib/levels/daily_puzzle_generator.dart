import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/level/level_tier.dart';
import '../models/objective/objective_model.dart';
import '../models/tile_model.dart';
import '../tooling/generator/level_generator.dart';

class DailyPuzzleGenerator {
  DailyPuzzleGenerator({LevelGenerator? generator})
      : _generator = generator ?? LevelGenerator();

  final LevelGenerator _generator;

  LevelModel generateForDate(DateTime date) {
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final generated = _generator.generate(
      levelId: seed,
      worldId: 2,
      indexInWorld: seed % 25,
      maxAttempts: 500,
    ) ?? _generator.generate(
          levelId: seed + 1,
          worldId: 1,
          indexInWorld: 0,
          maxAttempts: 500,
        );

    if (generated == null) {
      throw StateError('Failed to generate daily puzzle for $date');
    }

    return _fromGenerated(seed, generated.levelJson, LevelTier.intermediate);
  }

  LevelModel _fromGenerated(
    int seed,
    Map<String, dynamic> json,
    LevelTier tier,
  ) {
    return LevelModel(
      id: seed,
      world: 0,
      tier: tier,
      board: BoardModel(
        rows: json['rows'] as int,
        cols: json['cols'] as int,
        tiles: (json['tiles'] as List<dynamic>)
            .map((t) => TileModel.fromJson(t as Map<String, dynamic>))
            .toList(),
      ),
      objective: ObjectiveModel.fromJson(
        json['objective'] as Map<String, dynamic>,
      ),
      minimumMoves: json['minimumMoves'] as int,
      solutionMoves: (json['solutionMoves'] as List<dynamic>)
          .map((m) => m as String)
          .toList(),
    );
  }
}
