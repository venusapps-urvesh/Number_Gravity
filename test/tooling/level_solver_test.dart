import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/tooling/solver/level_solver.dart';
import 'package:number_gravity/tooling/solver/move_encoder.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/objective_checker.dart';

LevelModel _twoTilePullLevel() {
  return LevelModel(
    id: 9001,
    world: 1,
    tier: LevelTier.beginner,
    board: BoardModel(
      rows: 4,
      cols: 4,
      tiles: [
        const TileModel(id: 't1', type: TileType.number, value: 2, row: 1, col: 3),
        const TileModel(id: 't2', type: TileType.number, value: 5, row: 0, col: 0),
        const TileModel(
          id: 'g1',
          type: TileType.goal,
          row: 3,
          col: 3,
          isLocked: true,
        ),
      ],
    ),
    objective: const ObjectiveModel.position(
      tileId: 't1',
      goalRow: 3,
      goalCol: 3,
    ),
    minimumMoves: 1,
  );
}

void main() {
  group('LevelSolver', () {
  final solver = LevelSolver();
    const checker = ObjectiveChecker();
    final engine = DefaultGravityEngine();
    final applier = BoardApplier();

    test('solves a two-tile attraction puzzle', () {
      final level = _twoTilePullLevel();
      final result = solver.solve(level);

      expect(result.solved, isTrue, reason: 'expected solvable layout');
      expect(result.minimumMoves, greaterThan(0));

      var board = level.board;
      for (final move in result.moves) {
        board = engine.simulate(applier.applyPlayerMove(board, move)).finalBoard;
      }
      expect(checker.isSolved(level, board), isTrue);
    });

    test('encoded solution replays to solved board', () {
      final level = _twoTilePullLevel();
      final result = solver.solve(level);
      final encoded = MoveEncoder.encode(result.moves);

      var board = level.board;
      for (final code in encoded) {
        final move = MoveEncoder.decodeStep(code);
        board = engine.simulate(applier.applyPlayerMove(board, move)).finalBoard;
      }
      expect(checker.isSolved(level, board), isTrue);
    });
  });
}
