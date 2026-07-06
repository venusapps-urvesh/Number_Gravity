class LeaderboardEntry {
  const LeaderboardEntry({
    required this.playerId,
    required this.score,
    required this.displayName,
  });

  final String playerId;
  final int score;
  final String displayName;
}

abstract class LeaderboardService {
  Future<List<LeaderboardEntry>> fetchGlobal();
  Future<List<LeaderboardEntry>> fetchWeekly();
  Future<void> submitGameplayEarnedScore(int score);
  Future<void> submitDailySkillScore(int moves);
}

class LeaderboardServiceStub implements LeaderboardService {
  final List<LeaderboardEntry> _global = [];

  @override
  Future<List<LeaderboardEntry>> fetchGlobal() async => _global;

  @override
  Future<List<LeaderboardEntry>> fetchWeekly() async => _global;

  @override
  Future<void> submitDailySkillScore(int moves) async {}

  @override
  Future<void> submitGameplayEarnedScore(int score) async {
    _global.add(
      LeaderboardEntry(
        playerId: 'local',
        score: score,
        displayName: 'You',
      ),
    );
  }
}
