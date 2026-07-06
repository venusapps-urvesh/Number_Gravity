import '../core/extensions/board_extensions.dart';
import '../models/board_model.dart';
import '../models/move.dart';
import '../models/simulation/force_vector.dart';
import '../models/simulation/simulation_result.dart';
import 'cycle_simulator.dart';
import 'force_calculator.dart';
import 'gravity_engine.dart';
import 'stability_checker.dart';

/// Production gravity engine implementing Sections 2–3 of the spec.
class DefaultGravityEngine implements GravityEngine {
  DefaultGravityEngine({
    ForceCalculator? forceCalculator,
    StabilityChecker? stabilityChecker,
    GravityCycleRunner? cycleRunner,
  })  : _forceCalculator = forceCalculator ?? const ForceCalculator(),
        _stabilityChecker = stabilityChecker ?? const StabilityChecker(),
        _cycleRunner = cycleRunner ?? GravityCycleRunner();

  final ForceCalculator _forceCalculator;
  final StabilityChecker _stabilityChecker;
  final GravityCycleRunner _cycleRunner;

  @override
  List<ForceVector> computeForces(BoardModel board, String tileId) {
    return _forceCalculator.computeForces(board, tileId);
  }

  @override
  bool isStable(BoardModel board) {
    return _stabilityChecker.isStable(board);
  }

  @override
  List<Move> legalMoves(BoardModel board, String tileId) {
    return board.legalMovesForTile(tileId);
  }

  @override
  SimulationResult simulate(BoardModel board, {Move? playerMove}) {
    final run = _cycleRunner.run(board);
    return SimulationResult(
      steps: run.steps,
      finalBoard: run.finalBoard,
      isStable: run.isStable,
      hitCycleCap: run.hitCycleCap,
    );
  }
}
