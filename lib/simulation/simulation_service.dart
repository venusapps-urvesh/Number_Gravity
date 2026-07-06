import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/simulation_result.dart';
import 'board_applier.dart';
import 'gravity_engine.dart';

class SimulationService {
  SimulationService({
    required this.engine,
    BoardApplier? applier,
  }) : _applier = applier ?? BoardApplier();

  final GravityEngine engine;
  final BoardApplier _applier;

  (SimulationResult result, BoardModel newBoard) executeMove(
    BoardModel current,
    Move move,
  ) {
    final afterPlayerMove = _applier.applyPlayerMove(current, move);
    final result = engine.simulate(afterPlayerMove);
    final newBoard = _applier.apply(result);
    return (result, newBoard);
  }

  BoardModel previewPlayerMove(BoardModel current, Move move) {
    return _applier.applyPlayerMove(current, move);
  }
}
