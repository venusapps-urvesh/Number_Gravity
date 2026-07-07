import '../../core/constants/game_constants.dart';
import 'coin_service.dart';

int undoCostForLevel(int undoCountThisLevel) {
  if (undoCountThisLevel < freeUndosPerLevel) {
    return 0;
  }
  return coinCostUndoAfterFree;
}

int hintCostForTier(int tier) {
  return switch (tier) {
    1 => coinCostHintTier1,
    2 => coinCostHintTier2,
    3 => coinCostHintTier3,
    _ => coinCostHintTier3,
  };
}

CoinSink sinkForHintTier(int tier) {
  return switch (tier) {
    1 => CoinSink.hintTier1,
    2 => CoinSink.hintTier2,
    _ => CoinSink.hintTier3,
  };
}
