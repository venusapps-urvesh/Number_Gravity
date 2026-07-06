import '../core/errors/app_exception.dart';
import '../core/extensions/board_extensions.dart';
import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/force_vector.dart';
import '../models/simulation/simulation_result.dart';
import 'gravity_engine.dart';

/// Phase 1 stub — gravity settling is implemented in Phase 2.
class UnimplementedGravityEngine implements GravityEngine {
  static const String _message =
      'Gravity engine is not implemented until Phase 2.';

  Never _throw() => throw const SimulationException(_message);

  @override
  List<ForceVector> computeForces(BoardModel board, String tileId) => _throw();

  @override
  bool isStable(BoardModel board) => _throw();

  @override
  List<Move> legalMoves(BoardModel board, String tileId) {
    return board.legalMovesForTile(tileId);
  }

  @override
  SimulationResult simulate(BoardModel board, {Move? playerMove}) => _throw();
}
