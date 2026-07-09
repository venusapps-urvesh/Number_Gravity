import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/game_session_provider.dart';
import '../../services/economy/daily_quest_service.dart';
import '../../widgets/common/ng_card.dart';

class DailyQuestsPanel extends ConsumerWidget {
  const DailyQuestsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final questsAsync = ref.watch(_dailyQuestsProvider);

    return questsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (data) {
        return NGCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.dailyQuestsTitle,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final quest in data.quests)
                _QuestRow(
                  title: _titleForQuest(l10n, quest),
                  reward: quest.reward,
                  completed: data.completed.contains(quest.id),
                ),
            ],
          ),
        );
      },
    );
  }

  String _titleForQuest(AppLocalizations l10n, DailyQuest quest) {
    return switch (quest.titleKey) {
      'questClearLevel' => l10n.questClearLevel,
      'questNoHint' => l10n.questNoHint,
      'questDailyPuzzle' => l10n.questDailyPuzzle,
      _ => quest.titleKey,
    };
  }
}

class _QuestRow extends StatelessWidget {
  const _QuestRow({
    required this.title,
    required this.reward,
    required this.completed,
  });

  final String title;
  final int reward;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: completed ? AppColors.leaderboardAccent : muted,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            completed ? l10n.questClaimed : l10n.questReward(reward),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: completed ? AppColors.leaderboardAccent : muted,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

final _dailyQuestsProvider = FutureProvider<_QuestState>((ref) async {
  final service = ref.watch(dailyQuestServiceProvider);
  final quests = await service.activeQuests();
  final completed = <String>{};
  for (final quest in quests) {
    if (await service.isCompleted(quest.id)) {
      completed.add(quest.id);
    }
  }
  return _QuestState(quests: quests, completed: completed);
});

class _QuestState {
  const _QuestState({required this.quests, required this.completed});

  final List<DailyQuest> quests;
  final Set<String> completed;
}
