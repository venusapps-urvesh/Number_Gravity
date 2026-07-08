import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/tooling/solver/level_solver.dart';
import 'package:number_gravity/tooling/solver/move_encoder.dart';
import 'package:number_gravity/tooling/validator/level_validator.dart';

void main() {
  group('LevelValidator', () {
    final solver = LevelSolver();
    final validator = LevelValidator(solver: solver);

    test('rejects minimumMoves mismatch', () {
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
        minimumMoves: 99,
      );

      final result = validator.validate(level);
      expect(result.valid, isFalse);
      expect(
        result.issues,
        contains(LevelValidationIssue.minimumMovesMismatch),
      );
      expect(result.solverMinimumMoves, greaterThan(0));
    });

    test('accepts level with correct minimumMoves and solution', () {
      final base = LevelModel(
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

      final solved = solver.solve(base);
      expect(solved.solved, isTrue);

      final encoded = MoveEncoder.encode(solved.moves);
      final level = base.copyWith(
        minimumMoves: solved.minimumMoves,
        solutionMoves: encoded,
      );

      final result = validator.validate(level);
      expect(result.valid, isTrue, reason: result.issues.toString());
    });
  });
}
