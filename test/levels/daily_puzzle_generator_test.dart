import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/levels/daily_puzzle_generator.dart';
import 'package:number_gravity/models/move.dart';
import 'package:number_gravity/models/objective/objective_model.dart';
import 'package:number_gravity/simulation/board_applier.dart';
import 'package:number_gravity/simulation/default_gravity_engine.dart';
import 'package:number_gravity/simulation/objective_checker.dart';

void main() {
  group('DailyPuzzleGenerator', () {
    final generator = DailyPuzzleGenerator();
    final applier = BoardApplier();
    final engine = DefaultGravityEngine();
    const checker = ObjectiveChecker();

    test('minimum moves match the Manhattan distance to the goal', () {
      final level = generator.generateForDate(DateTime(2026, 7, 7));
      final tile = level.board.tileById('daily_t1')!;
      final objective = level.objective;
      expect(objective, isA<PositionObjective>());

      final goal = objective as PositionObjective;
      final expectedMoves =
          (goal.goalRow - tile.row).abs() + (goal.goalCol - tile.col).abs();

      expect(level.minimumMoves, expectedMoves);
      expect(level.solutionMoves.length, expectedMoves);
    });

    test('generated solution solves the daily puzzle', () {
      final level = generator.generateForDate(DateTime(2026, 7, 7));
      var board = level.board;

      for (final code in level.solutionMoves) {
        final direction = DirectionX.fromShortCode(code);
        expect(direction, isNotNull, reason: 'invalid solution move: $code');

        final move = Move(tileId: 'daily_t1', direction: direction!);
        board = engine
            .simulate(applier.applyPlayerMove(board, move))
            .finalBoard;
      }

      expect(checker.isSolved(level, board), isTrue);
    });
  });
}
