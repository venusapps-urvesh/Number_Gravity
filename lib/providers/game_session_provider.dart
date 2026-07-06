import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/game_constants.dart';
import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/move.dart';
import '../models/replay/move_record.dart';
import '../services/replay/replay_service.dart';
import '../simulation/ghost_simulator.dart';
import '../simulation/objective_checker.dart';
import '../simulation/simulation_service.dart';
import '../simulation/stuck_detector.dart';
import 'providers.dart';

enum GamePhase { playing, paused, won, lost, stuck }

class GameSessionState {
  const GameSessionState({
    required this.level,
    required this.board,
    required this.moveHistory,
    required this.moveHistoryRecords,
    required this.movesUsed,
    required this.phase,
    this.selectedTileId,
    this.ghostBoard,
  });

  final LevelModel level;
  final BoardModel board;
  final List<BoardModel> moveHistory;
  final List<MoveRecord> moveHistoryRecords;
  final int movesUsed;
  final GamePhase phase;
  final String? selectedTileId;
  final BoardModel? ghostBoard;

  GameSessionState copyWith({
    LevelModel? level,
    BoardModel? board,
    List<BoardModel>? moveHistory,
    List<MoveRecord>? moveHistoryRecords,
    int? movesUsed,
    GamePhase? phase,
    String? selectedTileId,
    BoardModel? ghostBoard,
    bool clearGhost = false,
    bool clearSelection = false,
  }) {
    return GameSessionState(
      level: level ?? this.level,
      board: board ?? this.board,
      moveHistory: moveHistory ?? this.moveHistory,
      moveHistoryRecords: moveHistoryRecords ?? this.moveHistoryRecords,
      movesUsed: movesUsed ?? this.movesUsed,
      phase: phase ?? this.phase,
      selectedTileId:
          clearSelection ? null : (selectedTileId ?? this.selectedTileId),
      ghostBoard: clearGhost ? null : (ghostBoard ?? this.ghostBoard),
    );
  }
}

class GameSessionNotifier extends StateNotifier<GameSessionState?> {
  GameSessionNotifier(this.ref) : super(null);

  final Ref ref;

  SimulationService get _simulationService =>
      ref.read(simulationServiceProvider);
  GhostSimulator get _ghost =>
      GhostSimulator(engine: ref.read(gravityEngineProvider));
  ObjectiveChecker get _objectives => const ObjectiveChecker();
  StuckDetector get _stuck => const StuckDetector();

  void startLevel(LevelModel level) {
    state = GameSessionState(
      level: level,
      board: level.board,
      moveHistory: [level.board],
      moveHistoryRecords: const [],
      movesUsed: 0,
      phase: GamePhase.playing,
    );
  }

  void selectTile(String tileId) {
    final current = state;
    if (current == null) {
      return;
    }
    state = current.copyWith(selectedTileId: tileId);
  }

  void previewMove(Move move) {
    final current = state;
    if (current == null) {
      return;
    }
    final preview = _ghost.preview(current.board, move);
    state = current.copyWith(ghostBoard: preview.finalBoard);
  }

  void clearPreview() {
    state = state?.copyWith(clearGhost: true);
  }

  Future<void> commitMove(Move move) async {
    final current = state;
    if (current == null || current.phase != GamePhase.playing) {
      return;
    }

    final (result, newBoard) =
        _simulationService.executeMove(current.board, move);
    final movesUsed = current.movesUsed + 1;
    final records = [
      ...current.moveHistoryRecords,
      MoveRecord(tileId: move.tileId, direction: move.direction),
    ];

    var phase = GamePhase.playing;
    if (_objectives.isSolved(current.level, newBoard)) {
      phase = GamePhase.won;
    } else if (_stuck.isStuck(current.level, newBoard)) {
      phase = GamePhase.stuck;
    }

    state = current.copyWith(
      board: newBoard,
      moveHistory: [...current.moveHistory, newBoard],
      moveHistoryRecords: records,
      movesUsed: movesUsed,
      phase: phase,
      clearGhost: true,
      clearSelection: true,
    );

    await ref.read(statisticsRepositoryProvider).recordMove();
    if (phase == GamePhase.won) {
      await ref.read(statisticsRepositoryProvider).recordLevelComplete();
      final stars = starsForMoves(
        movesUsed: movesUsed,
        minimumMoves: current.level.minimumMoves,
      );
      await ref.read(progressRepositoryProvider).setLevelStars(
            levelId: current.level.id,
            stars: stars,
            movesUsed: movesUsed,
          );
    }
  }

  void undo() {
    final current = state;
    if (current == null || current.moveHistory.length <= 1) {
      return;
    }
    final history = [...current.moveHistory]..removeLast();
    final records = [...current.moveHistoryRecords];
    if (records.isNotEmpty) {
      records.removeLast();
    }
    state = current.copyWith(
      board: history.last,
      moveHistory: history,
      moveHistoryRecords: records,
      movesUsed: current.movesUsed > 0 ? current.movesUsed - 1 : 0,
      phase: GamePhase.playing,
      clearGhost: true,
      clearSelection: true,
    );
    ref.read(statisticsRepositoryProvider).recordUndo();
  }

  void restart() {
    final current = state;
    if (current == null) {
      return;
    }
    startLevel(current.level);
  }

  void pause() {
    state = state?.copyWith(phase: GamePhase.paused);
  }

  void resume() {
    state = state?.copyWith(phase: GamePhase.playing);
  }
}

final gameSessionProvider =
    StateNotifierProvider<GameSessionNotifier, GameSessionState?>((ref) {
  return GameSessionNotifier(ref);
});

final replayServiceProvider = Provider<ReplayService>((ref) {
  return ReplayService(engine: ref.watch(gravityEngineProvider));
});
