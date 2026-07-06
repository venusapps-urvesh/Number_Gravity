import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/force_vector.dart';
import '../models/simulation/simulation_result.dart';

abstract class GravityEngine {
  SimulationResult simulate(BoardModel board, {Move? playerMove});

  List<ForceVector> computeForces(BoardModel board, String tileId);

  bool isStable(BoardModel board);

  List<Move> legalMoves(BoardModel board, String tileId);
}
