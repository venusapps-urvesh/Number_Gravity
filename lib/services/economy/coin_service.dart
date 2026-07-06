enum CoinSource {
  levelFirstClear,
  starBonus,
  replay,
  dailyLogin,
  dailyPuzzle,
  quest,
  rewardedAd,
  achievement,
  iap,
}

enum CoinSink {
  undo,
  redo,
  hintTier1,
  hintTier2,
  hintTier3,
  skipLevel,
  streakFreeze,
  cosmetic,
}

class CoinTransaction {
  const CoinTransaction({
    required this.amount,
    required this.source,
    required this.countsTowardLeaderboard,
    required this.timestamp,
  });

  final int amount;
  final CoinSource source;
  final bool countsTowardLeaderboard;
  final DateTime timestamp;
}

class CoinService {
  int balance = 0;
  int gameplayEarnedTotal = 0;
  final List<CoinTransaction> ledger = [];

  void earn({
    required int amount,
    required CoinSource source,
    bool countsTowardLeaderboard = true,
  }) {
    balance += amount;
    if (countsTowardLeaderboard) {
      gameplayEarnedTotal += amount;
    }
    ledger.add(
      CoinTransaction(
        amount: amount,
        source: source,
        countsTowardLeaderboard: countsTowardLeaderboard,
        timestamp: DateTime.now(),
      ),
    );
  }

  bool spend({
    required int amount,
    required CoinSink sink,
  }) {
    if (balance < amount) {
      return false;
    }
    balance -= amount;
    return true;
  }
}
