import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/objective/objective_model.dart';
import '../../models/tile_type.dart';
import '../../simulation/board_applier.dart';
import '../../simulation/default_gravity_engine.dart';
import '../../simulation/gravity_engine.dart';
import '../../simulation/objective_checker.dart';
import '../solver/level_solver.dart';
import '../solver/move_encoder.dart';

enum LevelValidationIssue {
  duplicateTilePosition,
  missingObjectiveTile,
  goalOutOfBounds,
  unsolvable,
  minimumMovesMismatch,
  solutionDoesNotSolve,
  solutionHitsCycleCap,
  hitCycleCapOnSolve,
  noDecisionPoint,
}

class LevelValidationResult {
  const LevelValidationResult({
    required this.valid,
    this.issues = const [],
    this.solverMoves = const [],
    this.solverMinimumMoves = 0,
  });

  final bool valid;
  final List<LevelValidationIssue> issues;
  final List<Move> solverMoves;
  final int solverMinimumMoves;
}

/// Simulation-backed level checks per production doc §8.
class LevelValidator {
  LevelValidator({
    LevelSolver? solver,
    GravityEngine? engine,
    BoardApplier? applier,
    ObjectiveChecker? objectiveChecker,
  })  : _solver = solver ?? LevelSolver(engine: engine, applier: applier),
        _engine = engine ?? DefaultGravityEngine(),
        _applier = applier ?? BoardApplier(),
        _objectiveChecker = objectiveChecker ?? const ObjectiveChecker();

  final LevelSolver _solver;
  final GravityEngine _engine;
  final BoardApplier _applier;
  final ObjectiveChecker _objectiveChecker;

  LevelValidationResult validate(LevelModel level) {
    final issues = <LevelValidationIssue>[];

    if (_hasDuplicatePositions(level)) {
      issues.add(LevelValidationIssue.duplicateTilePosition);
    }

    if (!_objectiveTileExists(level)) {
      issues.add(LevelValidationIssue.missingObjectiveTile);
    }

    if (!_goalInBounds(level)) {
      issues.add(LevelValidationIssue.goalOutOfBounds);
    }

    if (issues.isNotEmpty) {
      return LevelValidationResult(valid: false, issues: issues);
    }

    final solverResult = _solver.solve(level);
    if (!solverResult.solved) {
      issues.add(LevelValidationIssue.unsolvable);
      return LevelValidationResult(
        valid: false,
        issues: issues,
        solverMoves: solverResult.moves,
      );
    }

    if (solverResult.hitCycleCap) {
      issues.add(LevelValidationIssue.hitCycleCapOnSolve);
    }

    if (level.minimumMoves != solverResult.minimumMoves) {
      issues.add(LevelValidationIssue.minimumMovesMismatch);
    }

    if (level.solutionMoves.isNotEmpty) {
      final replay = _replaySolution(level);
      if (replay.hitCycleCap) {
        issues.add(LevelValidationIssue.solutionHitsCycleCap);
      }
      if (!replay.solved) {
        issues.add(LevelValidationIssue.solutionDoesNotSolve);
      }
    }

    if (solverResult.minimumMoves < 2 && level.board.tiles.length > 2) {
      issues.add(LevelValidationIssue.noDecisionPoint);
    }

    return LevelValidationResult(
      valid: issues.isEmpty,
      issues: issues,
      solverMoves: solverResult.moves,
      solverMinimumMoves: solverResult.minimumMoves,
    );
  }

  bool _hasDuplicatePositions(LevelModel level) {
    final movableSeen = <String>{};
    final staticSeen = <String>{};
    for (final tile in level.board.tiles) {
      final key = '${tile.row},${tile.col}';
      if (tile.isMovable) {
        if (movableSeen.contains(key)) {
          return true;
        }
        movableSeen.add(key);
      } else if (tile.type != TileType.goal) {
        if (staticSeen.contains(key)) {
          return true;
        }
        staticSeen.add(key);
      }
    }
    return false;
  }

  bool _objectiveTileExists(LevelModel level) {
    return switch (level.objective) {
      PositionObjective(:final tileId) => level.board.tileById(tileId) != null,
      SequenceObjective(:final tileIds) =>
        tileIds.every((id) => level.board.tileById(id) != null),
      SumObjective(:final tileIds) =>
        tileIds.every((id) => level.board.tileById(id) != null),
      BalanceObjective(:final regionTileIds) =>
        regionTileIds.every((id) => level.board.tileById(id) != null),
      CollectionObjective(:final tileGoals) =>
        tileGoals.keys.every((id) => level.board.tileById(id) != null),
      ChainObjective(:final subObjectiveIds) =>
        subObjectiveIds.every((id) => level.board.tileById(id) != null),
    };
  }

  bool _goalInBounds(LevelModel level) {
    return switch (level.objective) {
      PositionObjective(:final goalRow, :final goalCol) =>
        level.board.isInBounds(goalRow, goalCol),
      _ => true,
    };
  }

  ({bool solved, bool hitCycleCap}) _replaySolution(LevelModel level) {
    var board = level.board;
    var hitCycleCap = false;
    final defaultTile = switch (level.objective) {
      PositionObjective(:final tileId) => tileId,
      _ => 't1',
    };

    final moves = level.solutionMoves.isNotEmpty
        ? MoveEncoder.decode(
            level.solutionMoves,
            defaultTileId: defaultTile,
          )
        : <Move>[];

    for (final move in moves) {
      final result = _engine.simulate(_applier.applyPlayerMove(board, move));
      if (result.hitCycleCap) {
        hitCycleCap = true;
      }
      board = result.finalBoard;
    }

    return (
      solved: _objectiveChecker.isSolved(level, board),
      hitCycleCap: hitCycleCap,
    );
  }
}

extension LevelValidationIssueX on LevelValidationIssue {
  String get label => switch (this) {
        LevelValidationIssue.duplicateTilePosition => 'duplicate tile position',
        LevelValidationIssue.missingObjectiveTile => 'missing objective tile',
        LevelValidationIssue.goalOutOfBounds => 'goal out of bounds',
        LevelValidationIssue.unsolvable => 'unsolvable',
        LevelValidationIssue.minimumMovesMismatch => 'minimumMoves mismatch',
        LevelValidationIssue.solutionDoesNotSolve =>
          'solution does not solve level',
        LevelValidationIssue.solutionHitsCycleCap =>
          'solution hits gravity cycle cap',
        LevelValidationIssue.hitCycleCapOnSolve => 'solve hits cycle cap',
        LevelValidationIssue.noDecisionPoint => 'no decision point',
      };
}
