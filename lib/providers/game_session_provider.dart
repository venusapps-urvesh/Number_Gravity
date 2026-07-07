import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/board_model.dart';
import '../models/level/level_model.dart';
import '../models/move.dart';
import '../models/simulation/force_vector.dart';
import '../services/economy/economy_service.dart';
import 'providers.dart';

class GameSessionState {
  const GameSessionState({
    this.movesUsed = 0,
    this.undoCountThisLevel = 0,
    this.selectedTileId,
    this.previewDirection,
    this.ghostBoard,
    this.forceVectors = const [],
    this.legalDirections = const [],
    this.canUndo = false,
    this.canRedo = false,
    this.isAnimating = false,
    this.isWon = false,
    this.isStuck = false,
    this.hintTierUsed = 0,
    this.hintsPurchasedThisLevel = 0,
  });

  final int movesUsed;
  final int undoCountThisLevel;
  final String? selectedTileId;
  final Direction? previewDirection;
  final BoardModel? ghostBoard;
  final List<ForceVector> forceVectors;
  final List<Direction> legalDirections;
  final bool canUndo;
  final bool canRedo;
  final bool isAnimating;
  final bool isWon;
  final bool isStuck;
  final int hintTierUsed;
  final int hintsPurchasedThisLevel;

  GameSessionState copyWith({
    int? movesUsed,
    int? undoCountThisLevel,
    String? selectedTileId,
    Direction? previewDirection,
    BoardModel? ghostBoard,
    bool clearGhost = false,
    List<ForceVector>? forceVectors,
    List<Direction>? legalDirections,
    bool? canUndo,
    bool? canRedo,
    bool? isAnimating,
    bool? isWon,
    bool? isStuck,
    int? hintTierUsed,
    int? hintsPurchasedThisLevel,
    bool clearSelection = false,
  }) {
    return GameSessionState(
      movesUsed: movesUsed ?? this.movesUsed,
      undoCountThisLevel: undoCountThisLevel ?? this.undoCountThisLevel,
      selectedTileId:
          clearSelection ? null : (selectedTileId ?? this.selectedTileId),
      previewDirection:
          clearSelection ? null : (previewDirection ?? this.previewDirection),
      ghostBoard: clearGhost ? null : (ghostBoard ?? this.ghostBoard),
      forceVectors: clearSelection
          ? const []
          : (forceVectors ?? this.forceVectors),
      legalDirections: clearSelection
          ? const []
          : (legalDirections ?? this.legalDirections),
      canUndo: canUndo ?? this.canUndo,
      canRedo: canRedo ?? this.canRedo,
      isAnimating: isAnimating ?? this.isAnimating,
      isWon: isWon ?? this.isWon,
      isStuck: isStuck ?? this.isStuck,
      hintTierUsed: hintTierUsed ?? this.hintTierUsed,
      hintsPurchasedThisLevel:
          hintsPurchasedThisLevel ?? this.hintsPurchasedThisLevel,
    );
  }
}

class GameSessionNotifier extends FamilyNotifier<GameSessionState, LevelModel> {
  @override
  GameSessionState build(LevelModel arg) => const GameSessionState();

  void syncFromGame({
    required int movesUsed,
    required bool canUndo,
    required bool canRedo,
    required bool isAnimating,
    required bool isWon,
    required bool isStuck,
  }) {
    state = state.copyWith(
      movesUsed: movesUsed,
      canUndo: canUndo,
      canRedo: canRedo,
      isAnimating: isAnimating,
      isWon: isWon,
      isStuck: isStuck,
    );
  }

  void onTileSelected({
    required String tileId,
    required List<ForceVector> forces,
    required List<Direction> directions,
  }) {
    state = state.copyWith(
      selectedTileId: tileId,
      forceVectors: forces,
      legalDirections: directions,
      clearGhost: true,
    );
  }

  void onPreview({
    required Direction direction,
    required BoardModel ghostBoard,
  }) {
    state = state.copyWith(
      previewDirection: direction,
      ghostBoard: ghostBoard,
    );
  }

  void clearPreview() {
    state = state.copyWith(clearGhost: true, previewDirection: null);
  }

  void clearSelection() {
    state = state.copyWith(clearSelection: true, clearGhost: true);
  }

  void onMoveCommitted() {
    state = state.copyWith(
      clearSelection: true,
      clearGhost: true,
      canRedo: false,
    );
  }

  void onUndo() {
    state = state.copyWith(
      undoCountThisLevel: state.undoCountThisLevel + 1,
      isStuck: false,
      clearSelection: true,
      clearGhost: true,
    );
  }

  void onRedo() {
    state = state.copyWith(clearSelection: true, clearGhost: true);
  }

  void onHintUsed(int tier) {
    state = state.copyWith(
      hintTierUsed: tier,
      hintsPurchasedThisLevel: state.hintsPurchasedThisLevel + 1,
    );
  }

  void onRestart() {
    state = const GameSessionState();
  }
}

final gameSessionProvider =
    NotifierProvider.family<GameSessionNotifier, GameSessionState, LevelModel>(
  GameSessionNotifier.new,
);

final economyServiceProvider = Provider<EconomyService>((ref) {
  return EconomyService(ref.watch(progressRepositoryProvider));
});
