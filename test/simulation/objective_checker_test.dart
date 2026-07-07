import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/simulation/objective_checker.dart';

void main() {
  group('ObjectiveChecker chain', () {
    test('solved when all chain tiles are on goal cells', () {
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 2,
            row: 2,
            col: 2,
          ),
          const TileModel(
            id: 'g1',
            type: TileType.goal,
            value: 0,
            row: 2,
            col: 2,
            isLocked: true,
          ),
        ],
      );

      final level = LevelModel(
        id: 1,
        world: 8,
        tier: LevelTier.advanced,
        board: board,
        objective: const ObjectiveModel.chain(subObjectiveIds: ['t1']),
        minimumMoves: 3,
      );

      expect(const ObjectiveChecker().isSolved(level, board), isTrue);
    });

    test('not solved when chain tile is off goal', () {
      final board = BoardModel(
        rows: 3,
        cols: 3,
        tiles: [
          const TileModel(
            id: 't1',
            type: TileType.number,
            value: 2,
            row: 0,
            col: 0,
          ),
          const TileModel(
            id: 'g1',
            type: TileType.goal,
            value: 0,
            row: 2,
            col: 2,
            isLocked: true,
          ),
        ],
      );

      final level = LevelModel(
        id: 1,
        world: 8,
        tier: LevelTier.advanced,
        board: board,
        objective: const ObjectiveModel.chain(subObjectiveIds: ['t1']),
        minimumMoves: 3,
      );

      expect(const ObjectiveChecker().isSolved(level, board), isFalse);
    });
  });
}
