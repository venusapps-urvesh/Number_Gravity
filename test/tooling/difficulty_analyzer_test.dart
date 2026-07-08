import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/board_model.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/tooling/analyzer/difficulty_analyzer.dart';
import 'package:number_gravity/tooling/analyzer/tier_tolerance.dart';

void main() {
  group('tierWithinTolerance', () {
    test('allows same tier', () {
      expect(tierWithinTolerance('beginner', 'beginner'), isTrue);
    });

    test('allows one band difference', () {
      expect(tierWithinTolerance('beginner', 'intermediate'), isTrue);
      expect(tierWithinTolerance('intermediate', 'advanced'), isTrue);
    });

    test('rejects two band difference', () {
      expect(tierWithinTolerance('beginner', 'advanced'), isFalse);
    });
  });

  group('DifficultyAnalyzer', () {
    test('scores a multi-tile beginner board', () {
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
              col: 1,
            ),
            const TileModel(
              id: 't2',
              type: TileType.number,
              value: 5,
              row: 0,
              col: 2,
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
        minimumMoves: 2,
      );

      final score = DifficultyAnalyzer().analyze(level);
      expect(score.weightedTotal, greaterThan(0));
      expect(difficultyTierOrder, contains(score.tier));
    });
  });
}
