import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/models/level/level_model.dart';
import 'package:number_gravity/models/level/level_tier.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/models/tile_model.dart';
import 'package:number_gravity/models/tile_type.dart';
import 'package:number_gravity/tooling/solver/move_encoder.dart';

void main() {
  group('MoveEncoder', () {
    test('encodes tile and direction', () {
      final encoded = MoveEncoder.encode([
        const Move(tileId: 't1', direction: Direction.right),
        const Move(tileId: 't2', direction: Direction.down),
      ]);
      expect(encoded, ['t1:R', 't2:D']);
    });

    test('decodes tile:direction format', () {
      final moves = MoveEncoder.decode(['t1:R', 't2:D']);
      expect(moves[0].tileId, 't1');
      expect(moves[0].direction, Direction.right);
      expect(moves[1].tileId, 't2');
    });

    test('decodes legacy direction-only format', () {
      final moves = MoveEncoder.decode(['R', 'D'], defaultTileId: 't1');
      expect(moves.every((m) => m.tileId == 't1'), isTrue);
    });
  });
}
