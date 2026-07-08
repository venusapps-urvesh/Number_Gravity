import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/tooling/generator/level_generator.dart';

void main() {
  group('LevelGenerator', () {
    final generator = LevelGenerator();

    for (var world = 1; world <= 8; world++) {
      test('world $world produces a valid level', () {
        final levelId = (world - 1) * 25 + 1;
        final generated = generator.generate(
          levelId: levelId,
          worldId: world,
          indexInWorld: 0,
          maxAttempts: 5000,
        );
        expect(generated, isNotNull, reason: 'failed world $world level $levelId');
        expect(generated!.levelJson['solutionMoves'], isNotEmpty);
      });
    }
  });
}
