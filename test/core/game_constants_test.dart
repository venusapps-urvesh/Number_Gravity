import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/core/constants/game_constants.dart';

void main() {
  group('game constants', () {
    test('matches production document board limits', () {
      expect(maxBoardRows, 10);
      expect(maxBoardCols, 10);
      expect(maxTiles, 100);
    });

    test('matches gravity cycle cap', () {
      expect(maxGravityCycles, 10);
    });

    test('matches force range cap', () {
      expect(forceRangeCap, 4);
    });

    test('priority order matches Section 2.5', () {
      expect(
        simulationPriorityOrder.map((priority) => priority.name).toList(),
        [
          'boundary',
          'wall',
          'portal',
          'collision',
          'modifier',
          'gravity',
        ],
      );
    });

    test('star ratings follow solver minimum moves', () {
      expect(starsForMoves(movesUsed: 5, minimumMoves: 5), 3);
      expect(starsForMoves(movesUsed: 7, minimumMoves: 5), 2);
      expect(starsForMoves(movesUsed: 10, minimumMoves: 5), 1);
    });
  });
}
