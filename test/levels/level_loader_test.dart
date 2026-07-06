import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/levels/level_loader.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_type.dart';
import 'package:number_gravity/models/tile_type.dart';

void main() {
  group('LevelLoader', () {
    final loader = LevelLoader();

    test('parses canonical level schema', () {
      final level = loader.parseLevel({
        'id': 1,
        'world': 1,
        'tier': 'beginner',
        'rows': 4,
        'cols': 4,
        'objective': {
          'type': 'position',
          'tileId': 't1',
          'goalRow': 3,
          'goalCol': 3,
        },
        'tiles': [
          {
            'id': 't1',
            'type': 'number',
            'value': 3,
            'row': 0,
            'col': 0,
            'isLocked': false,
          },
        ],
        'minimumMoves': 3,
        'solutionMoves': ['R', 'R', 'D'],
      });

      expect(level.id, 1);
      expect(level.world, 1);
      expect(level.tier, LevelTier.beginner);
      expect(level.board.rows, 4);
      expect(level.objective.type, ObjectiveType.position);
      expect(level.minimumMoves, 3);
      expect(level.board.tiles.first.type, TileType.number);
    });
  });
}
