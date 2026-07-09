import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/tooling/solver/level_solver.dart';

void main() {
  group('Simulation determinism', () {
    final engine = DefaultGravityEngine();
    final applier = BoardApplier();
    final solver = LevelSolver();

    test('identical moves yield identical board hashes', () {
      final level = LevelModel(
        id: 1,
        world: 1,
        tier: LevelTier.beginner,
        board: BoardModel(
          rows: 4,
          cols: 4,
          tiles: [
            const TileModel(
              id: 't1',
              type: TileType.number,
              value: 2,
              row: 1,
              col: 3,
            ),
            const TileModel(
              id: 't2',
              type: TileType.number,
              value: 5,
              row: 0,
              col: 0,
            ),
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

      final solved = solver.solve(level);
      expect(solved.solved, isTrue);

      BoardModel runOnce() {
        var board = level.board;
        for (final move in solved.moves) {
          board = engine.simulate(applier.applyPlayerMove(board, move)).finalBoard;
        }
        return board;
      }

      expect(runOnce().toFlatHash(), runOnce().toFlatHash());
    });

    test('engine simulation is stable across repeated runs', () {
      final board = BoardModel(
        rows: 4,
        cols: 4,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 4,
            row: 0,
            col: 1,
          ),
          const TileModel(
            id: 't2',
            type: TileType.number,
            value: -2,
            row: 2,
            col: 1,
          ),
          const TileModel(
            id: 't3',
            type: TileType.number,
            value: 3,
            row: 3,
            col: 3,
          ),
        ],
      );

      final first = engine.simulate(board);
      final second = engine.simulate(board);
      final third = engine.simulate(board);

      expect(first.finalBoard.toFlatHash(), second.finalBoard.toFlatHash());
      expect(second.finalBoard.toFlatHash(), third.finalBoard.toFlatHash());
      expect(first.steps.length, second.steps.length);
      expect(second.steps.length, third.steps.length);
    });
  });
}
