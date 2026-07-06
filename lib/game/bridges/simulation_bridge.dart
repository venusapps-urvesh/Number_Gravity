import '../../models/board_model.dart';
import '../../models/level/level_model.dart';
import '../../models/move.dart';
import '../../models/simulation/cycle_step.dart';
import '../../models/simulation/force_vector.dart';
import '../../models/simulation/simulation_result.dart';
import '../../simulation/board_applier.dart';
import '../../simulation/gravity_engine.dart';

class SimulationBridge {
  SimulationBridge({
    required GravityEngine engine,
    BoardApplier? applier,
  }) : _engine = engine,
       _applier = applier ?? BoardApplier();

  final GravityEngine _engine;
  final BoardApplier _applier;

  List<Move> legalMoves(BoardModel board, String tileId) {
    return _engine.legalMoves(board, tileId);
  }

  List<ForceVector> computeForces(BoardModel board, String tileId) {
    return _engine.computeForces(board, tileId);
  }

  SimulationResult previewMove(BoardModel board, Move move) {
    final afterPlayer = _applier.applyPlayerMove(board, move);
    return _engine.simulate(afterPlayer);
  }

  (SimulationResult result, BoardModel board) commitMove(
    BoardModel board,
    Move move,
  ) {
    final afterPlayer = _applier.applyPlayerMove(board, move);
    final result = _engine.simulate(afterPlayer);
    return (result, result.finalBoard);
  }

  BoardModel initialBoard(LevelModel level) => level.board;

  List<BoardModel> framesFromResult(SimulationResult result) {
    return result.steps.map((step) => step.boardSnapshot).toList(growable: false);
  }

  List<CycleStep> stepsFromResult(SimulationResult result) => result.steps;
}
