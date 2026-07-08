/// Production doc Section 2.5 — deterministic priority order.
enum SimulationPriority {
  boundary,
  wall,
  portal,
  collision,
  modifier,
  gravity,
}

/// Ordered list matching production document priority.
const List<SimulationPriority> simulationPriorityOrder = [
  SimulationPriority.boundary,
  SimulationPriority.wall,
  SimulationPriority.portal,
  SimulationPriority.collision,
  SimulationPriority.modifier,
  SimulationPriority.gravity,
];

/// Maximum board dimensions (Section 14.1).
const int maxBoardRows = 10;
const int maxBoardCols = 10;
const int maxTiles = 100;

/// Gravity cycle safety cap (Section 2.2).
const int maxGravityCycles = 10;

/// Force range cap — distance 4+ has no effect (Section 2.1).
const int forceRangeCap = 4;

/// Tile value limits (Section 2.4).
const int maxTileValue = 99;
const int minTileMagnitude = 1;

/// Solver depth caps by tier (Section 8.1).
const int solverDepthCapBeginner = 20;
const int solverDepthCapIntermediate = 40;
const int solverDepthCapAdvanced = 80;
const int solverDepthCapExpert = 150;

/// Star thresholds (Section 7).
/// Keep a small grace window because some level minimums are aspirational.
const int starThresholdOptimal = 1;
const int starThresholdTwoStars = 4;

/// Coin rewards on first clear (Section 7 / 13.2).
const int coinsPerStar1 = 5;
const int coinsPerStar2 = 15;
const int coinsPerStar3 = 30;
const int coinsReplayClear = 2;
const int coinsNoHintBonus = 10;
const int coinsDailyPuzzleClear = 50;
const int coinsAchievementClaim = 25;

/// Escalating daily login rewards (Section 13.2).
const List<int> dailyLoginRewards = [10, 15, 20, 30, 50, 75, 100];

int firstClearBonusForWorld(int worldId) {
  if (worldId <= 0) {
    return 0;
  }
  return 10 + ((worldId - 1) * 30 ~/ 7);
}

/// One-time starting balance granted on first install.
const int startingCoins = 200;

/// Coin sinks for in-level helpers (Section 13.3).
const int coinCostUndoAfterFree = 10;
const int coinCostRedo = 5;
const int coinCostHintTier1 = 20;
const int coinCostHintTier2 = 40;
const int coinCostHintTier3 = 80;
const int freeUndosPerLevel = 1;

/// Animation timings in milliseconds (Section 11).
const int animationCycleStepMs = 200;
const int animationCycleStepMinMs = animationCycleStepMs;
const int animationCycleStepMaxMs = animationCycleStepMs;
const int animationTransitionMaxMs = 700;

/// World progression (Section 7).
const int totalWorlds = 8;
const int levelsPerWorld = 25;
const int totalLaunchLevels = 200;

int solverDepthCapForTier(String tier) {
  switch (tier.toLowerCase()) {
    case 'beginner':
      return solverDepthCapBeginner;
    case 'intermediate':
      return solverDepthCapIntermediate;
    case 'advanced':
      return solverDepthCapAdvanced;
    case 'expert':
      return solverDepthCapExpert;
    default:
      return solverDepthCapBeginner;
  }
}

int starsForMoves({required int movesUsed, required int minimumMoves}) {
  if (movesUsed <= minimumMoves + starThresholdOptimal) {
    return 3;
  }
  if (movesUsed <= minimumMoves + starThresholdTwoStars) {
    return 2;
  }
  return 1;
}
