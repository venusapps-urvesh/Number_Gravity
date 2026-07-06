import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/replay/move_record.dart';
import '../../simulation/board_applier.dart';
import '../../simulation/gravity_engine.dart';

class ReplayService {
  ReplayService({
    required this.engine,
    BoardApplier? applier,
  }) : _applier = applier ?? BoardApplier();

  final GravityEngine engine;
  final BoardApplier _applier;

  BoardModel replay(LevelModel level, List<MoveRecord> moves) {
    var board = level.board;
    for (final record in moves) {
      final move = Move(tileId: record.tileId, direction: record.direction);
      board = _applier.applyPlayerMove(board, move);
      board = engine.simulate(board).finalBoard;
    }
    return board;
  }

  String encodeMoves(List<MoveRecord> moves) {
    final buffer = StringBuffer();
    Direction? lastDirection;
    var run = 0;

    void flush() {
      if (lastDirection == null) {
        return;
      }
      buffer.write(lastDirection!.shortCode);
      if (run > 1) {
        buffer.write(run);
      }
      buffer.write('-');
    }

    for (final move in moves) {
      if (lastDirection == move.direction) {
        run++;
      } else {
        flush();
        lastDirection = move.direction;
        run = 1;
      }
    }
    flush();
    final encoded = buffer.toString();
    if (encoded.isEmpty) {
      return '';
    }
    return encoded.substring(0, encoded.length - 1);
  }
}
