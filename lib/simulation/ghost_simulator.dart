import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/simulation_result.dart';
import '../simulation/gravity_engine.dart';
import 'board_applier.dart';

class GhostSimulator {
  GhostSimulator({
    required this._engine,
    BoardApplier? applier,
  }) : _applier = applier ?? BoardApplier();

  final GravityEngine _engine;
  final BoardApplier _applier;

  SimulationResult preview(BoardModel board, Move move) {
    final afterPlayer = _applier.applyPlayerMove(board, move);
    return _engine.simulate(afterPlayer);
  }
}
