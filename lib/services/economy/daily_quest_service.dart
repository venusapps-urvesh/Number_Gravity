import '../../core/constants/game_constants.dart';
import '../../storage/adapters/player_progress.dart';
import '../../storage/repositories/progress_repository.dart';
import 'coin_service.dart';

class DailyQuest {
  const DailyQuest({
    required this.id,
    required this.titleKey,
    required this.reward,
  });

  final String id;
  final String titleKey;
  final int reward;
}

const List<DailyQuest> dailyQuestTemplates = [
  DailyQuest(id: 'clear_level', titleKey: 'questClearLevel', reward: coinsQuestReward),
  DailyQuest(id: 'no_hint', titleKey: 'questNoHint', reward: coinsQuestReward),
  DailyQuest(id: 'daily_puzzle', titleKey: 'questDailyPuzzle', reward: coinsQuestReward),
];

class DailyQuestService {
  DailyQuestService(this._repository);

  final ProgressRepository _repository;

  String _todayKey(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)}';
  }

  Future<void> _resetIfNewDay(PlayerProgress progress) async {
    final today = _todayKey(DateTime.now());
    if (progress.questsDate != today) {
      progress.questsDate = today;
      progress.completedQuestIds = [];
      await _repository.saveProgress(progress);
    }
  }

  Future<List<DailyQuest>> activeQuests() async {
    final progress = await _repository.getProgress();
    await _resetIfNewDay(progress);
    return dailyQuestTemplates.take(dailyQuestCount).toList();
  }

  Future<bool> isCompleted(String questId) async {
    final progress = await _repository.getProgress();
    await _resetIfNewDay(progress);
    return progress.completedQuestIds.contains(questId);
  }

  Future<int?> completeQuest(String questId) async {
    final progress = await _repository.getProgress();
    await _resetIfNewDay(progress);
    if (progress.completedQuestIds.contains(questId)) {
      return null;
    }
    final quest = dailyQuestTemplates.firstWhere(
      (q) => q.id == questId,
      orElse: () => throw ArgumentError('Unknown quest: $questId'),
    );
    progress.completedQuestIds = [...progress.completedQuestIds, questId];
    progress.coins += quest.reward;
    progress.gameplayEarnedCoins += quest.reward;
    await _repository.saveProgress(progress);
    return quest.reward;
  }

  Future<void> markQuestProgress({
    required String questId,
  }) async {
    await completeQuest(questId);
  }
}
