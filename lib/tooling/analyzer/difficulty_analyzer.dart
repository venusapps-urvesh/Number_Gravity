import '../../models/level/level_model.dart';
import '../../models/tile_type.dart';
import '../solver/level_solver.dart';

/// Weighted difficulty score per production doc §6.
class DifficultyScore {
  const DifficultyScore({
    required this.boardComplexity,
    required this.mechanicComplexity,
    required this.solutionLength,
    required this.decisionComplexity,
    required this.predictionDifficulty,
    required this.weightedTotal,
    required this.tier,
  });

  final double boardComplexity;
  final double mechanicComplexity;
  final double solutionLength;
  final double decisionComplexity;
  final double predictionDifficulty;
  final double weightedTotal;
  final String tier;
}

class DifficultyAnalyzer {
  DifficultyAnalyzer({LevelSolver? solver}) : _solver = solver ?? LevelSolver();

  final LevelSolver _solver;

  DifficultyScore analyze(LevelModel level) {
    final boardComplexity = _boardComplexity(level);
    final mechanicComplexity = _mechanicComplexity(level);
    final solverResult = _solver.solve(level);
    final solutionLength = _solutionLengthScore(solverResult.minimumMoves);
    final decisionComplexity = _decisionComplexity(level);
    final predictionDifficulty = _predictionDifficulty(level, solverResult);

    final weightedTotal = boardComplexity * 1.0 +
        mechanicComplexity * 1.5 +
        solutionLength * 1.0 +
        decisionComplexity * 1.5 +
        predictionDifficulty * 1.0;

    return DifficultyScore(
      boardComplexity: boardComplexity,
      mechanicComplexity: mechanicComplexity,
      solutionLength: solutionLength,
      decisionComplexity: decisionComplexity,
      predictionDifficulty: predictionDifficulty,
      weightedTotal: weightedTotal,
      tier: _tierForScore(weightedTotal),
    );
  }

  double _boardComplexity(LevelModel level) {
    final cells = level.board.rows * level.board.cols;
    final occupied = level.board.occupiedCells;
    final specialTypes = level.board.tiles
        .where((t) => t.type != TileType.number && t.type != TileType.goal)
        .map((t) => t.type)
        .toSet()
        .length;
    final fillRatio = occupied / cells;
    return ((fillRatio * 12) + (specialTypes * 2)).clamp(0, 20).toDouble();
  }

  double _mechanicComplexity(LevelModel level) {
    final types = level.board.tiles.map((t) => t.type).toSet();
    var score = 0.0;
    if (types.contains(TileType.number)) {
      score += 2;
    }
    if (level.board.tiles.any((t) => t.value < 0)) {
      score += 3;
    }
    if (types.contains(TileType.wall)) {
      score += 2;
    }
    if (types.contains(TileType.portal)) {
      score += 4;
    }
    if (types.contains(TileType.multiplier) ||
        types.contains(TileType.divider) ||
        types.contains(TileType.inverter)) {
      score += 4;
    }
    if (types.contains(TileType.switchTile) ||
        types.contains(TileType.door) ||
        types.contains(TileType.freeze)) {
      score += 4;
    }
    final movableCount =
        level.board.tiles.where((t) => t.isMovable && t.isNumberTile).length;
    if (movableCount > 1) {
      score += (movableCount - 1) * 2;
    }
    return score.clamp(0, 20).toDouble();
  }

  double _solutionLengthScore(int minimumMoves) {
    return (minimumMoves * 1.5).clamp(0, 20).toDouble();
  }

  double _decisionComplexity(LevelModel level) {
    final movable =
        level.board.tiles.where((t) => t.isMovable).length;
  final directions = 4;
    return (movable * directions * 0.8).clamp(0, 20).toDouble();
  }

  double _predictionDifficulty(LevelModel level, SolverResult solverResult) {
    final gravitySources = level.board.tiles
        .where((t) => t.type.emitsGravity && t.value != 0)
        .length;
    final moveFactor = solverResult.minimumMoves * 0.5;
    return (gravitySources * 2 + moveFactor).clamp(0, 20).toDouble();
  }

  String _tierForScore(double score) {
    if (score <= 25) {
      return 'beginner';
    }
    if (score <= 55) {
      return 'intermediate';
    }
    if (score <= 85) {
      return 'advanced';
    }
    return 'expert';
  }
}
