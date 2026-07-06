import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/providers.dart';
import '../../services/leaderboard/leaderboard_service.dart';
import '../../widgets/common/ng_card.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';

enum _LadderTab { coins, skill }

enum _Scope { global, weekly, friends }

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({required this.service, super.key});

  final LeaderboardService service;

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  _LadderTab _tab = _LadderTab.coins;
  _Scope _scope = _Scope.global;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(playerProgressProvider).value;
    final youScore = progress?.gameplayEarnedCoins ?? 0;

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.leaderboard),
          Expanded(
            child: NGResponsiveLayout(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _tabBar(context, l10n),
                  const SizedBox(height: AppSpacing.md),
                  _scopeRow(context, l10n),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: FutureBuilder<List<LeaderboardEntry>>(
                      future: _scope == _Scope.weekly
                          ? widget.service.fetchWeekly()
                          : widget.service.fetchGlobal(),
                      builder: (context, snapshot) {
                        final entries = snapshot.data ?? const [];
                        return _list(context, l10n, entries, youScore);
                      },
                    ),
                  ),
                  _fairnessNote(context, l10n),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar(BuildContext context, AppLocalizations l10n) {
    final brightness = Theme.of(context).brightness;
    final track = brightness == Brightness.dark
        ? AppColors.neutral800
        : AppColors.neutral200;

    Widget seg(_LadderTab tab, String label) {
      final selected = _tab == tab;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _tab = tab),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selected
                  ? (brightness == Brightness.dark
                      ? AppColors.darkSurface
                      : Colors.white)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? null
                        : AppColors.onSurfaceMuted(brightness),
                  ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: track,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          seg(_LadderTab.coins, l10n.coinsEarnedTab),
          const SizedBox(width: 4),
          seg(_LadderTab.skill, l10n.skillLadderTab),
        ],
      ),
    );
  }

  Widget _scopeRow(BuildContext context, AppLocalizations l10n) {
    Widget chip(_Scope scope, String label) {
      final selected = _scope == scope;
      return Padding(
        padding: const EdgeInsets.only(right: AppSpacing.sm),
        child: ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: (_) => setState(() => _scope = scope),
          showCheckmark: false,
          selectedColor: AppColors.positive,
          labelStyle: TextStyle(
            color: selected
                ? Colors.white
                : AppColors.onSurfaceMuted(Theme.of(context).brightness),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Row(
      children: [
        chip(_Scope.global, l10n.scopeGlobal),
        chip(_Scope.weekly, l10n.scopeWeekly),
        chip(_Scope.friends, l10n.scopeFriends),
      ],
    );
  }

  Widget _list(
    BuildContext context,
    AppLocalizations l10n,
    List<LeaderboardEntry> entries,
    int youScore,
  ) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    if (entries.isEmpty) {
      return Column(
        children: [
          _youRow(context, l10n, rank: null, score: youScore),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  l10n.leaderboardEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: muted),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final entry = entries[index];
        final isYou = entry.playerId == 'local';
        return _entryRow(
          context,
          rank: index + 1,
          name: isYou ? l10n.you : entry.displayName,
          score: entry.score,
          highlight: isYou,
        );
      },
    );
  }

  Widget _youRow(
    BuildContext context,
    AppLocalizations l10n, {
    required int? rank,
    required int score,
  }) {
    return _entryRow(
      context,
      rank: rank,
      name: l10n.you,
      score: score,
      highlight: true,
    );
  }

  Widget _entryRow(
    BuildContext context, {
    required int? rank,
    required String name,
    required int score,
    required bool highlight,
  }) {
    final medal = switch (rank) {
      1 => '🥇',
      2 => '🥈',
      3 => '🥉',
      _ => null,
    };

    return NGCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      borderColor: highlight ? AppColors.positive : null,
      borderWidth: highlight ? 2 : 0,
      child: Row(
        children: [
          SizedBox(
            width: 26,
            child: Text(
              rank == null ? '—' : '$rank',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 22,
            child: medal != null
                ? Text(medal, style: const TextStyle(fontSize: 18))
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: highlight ? AppColors.positive : null,
                  ),
            ),
          ),
          Text(
            _formatScore(score),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontFeatures: const [],
                ),
          ),
        ],
      ),
    );
  }

  Widget _fairnessNote(BuildContext context, AppLocalizations l10n) {
    final brightness = Theme.of(context).brightness;
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.positive.withValues(
          alpha: brightness == Brightness.dark ? 0.16 : 0.08,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.balance_rounded,
              size: 18, color: AppColors.positive),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.leaderboardFairness,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.positive,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatScore(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}
