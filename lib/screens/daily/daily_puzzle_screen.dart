import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/game_constants.dart';
import '../../app/router/navigation.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../game/game_flow_controller.dart';
import '../../levels/daily_puzzle_generator.dart';
import '../../models/board_model.dart';
import '../../models/tile_model.dart';
import '../../providers/game_session_provider.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/game/tile_badge.dart';

class DailyPuzzleScreen extends ConsumerStatefulWidget {
  DailyPuzzleScreen({super.key});

  @override
  ConsumerState<DailyPuzzleScreen> createState() => _DailyPuzzleScreenState();
}

class _DailyPuzzleScreenState extends ConsumerState<DailyPuzzleScreen> {
  final _generator = DailyPuzzleGenerator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final reward =
          await GameFlowController(ref).claimDailyLoginRewardIfNeeded();
      if (reward > 0 && mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.coinCount(reward))),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final today = DateTime.now();
    final puzzle = _generator.generateForDate(today);
    final progress = ref.watch(playerProgressProvider).value;
    final streak = progress?.dailyStreak ?? 0;
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(
            title: l10n.dailyPuzzle,
            actions: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    color: AppColors.coinGold,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$streak',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: NGResponsiveLayout(
              child: ListView(
                children: [
                  Text(
                    l10n.dailySeed(_formatDate(today)),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: muted,
                      fontFeatures: const [],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _StreakStrip(rewards: dailyLoginRewards, streak: streak),
                  const SizedBox(height: AppSpacing.md),
                  _ChestCard(),
                  const SizedBox(height: AppSpacing.sm),
                  _StreakFreezeCard(),
                  const SizedBox(height: AppSpacing.lg),
                  _BoardPreview(board: puzzle.board, colorBlind: colorBlind),
                  const SizedBox(height: AppSpacing.lg),
                  NGButton(
                    label: l10n.solveTodaysPuzzle,
                    icon: Icons.play_arrow_rounded,
                    variant: NGButtonVariant.accent,
                    accent: NGButtonAccent.daily,
                    onPressed: () => ngPushToDailyPlay(context, puzzle),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.skillLadderNote,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: muted),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)}';
  }
}

class _ChestCard extends ConsumerWidget {
  const _ChestCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final chestAsync = ref.watch(_chestProvider);

    return chestAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (canClaim) {
        return NGButton(
          label: canClaim
              ? l10n.timeChestReady(coinsTimeChest)
              : l10n.timeChestCooldown(chestCooldownHours),
          icon: Icons.card_giftcard_rounded,
          variant: NGButtonVariant.secondary,
          onPressed: canClaim
              ? () async {
                  final reward =
                      await ref.read(chestServiceProvider).claim();
                  if (!context.mounted || reward == null) {
                    return;
                  }
                  ref.invalidate(_chestProvider);
                  ref.invalidate(playerProgressProvider);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.questReward(reward))),
                  );
                }
              : null,
        );
      },
    );
  }
}

class _StreakFreezeCard extends ConsumerWidget {
  const _StreakFreezeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(playerProgressProvider).value;
    final owned = progress?.streakFreezes ?? 0;

    return NGButton(
      label: owned > 0
          ? '${l10n.streakFreeze} ($owned)'
          : '${l10n.streakFreeze} · ${l10n.undoCostCoins(coinCostStreakFreeze)}',
      icon: Icons.ac_unit_rounded,
      variant: NGButtonVariant.secondary,
      onPressed: () async {
        if (owned > 0) {
          await ref.read(engagementServiceProvider).useStreakFreeze();
        } else {
          final bought =
              await ref.read(engagementServiceProvider).buyStreakFreeze();
          if (!bought && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.notEnoughCoins)),
            );
            return;
          }
        }
        ref.invalidate(playerProgressProvider);
      },
    );
  }
}

final _chestProvider = FutureProvider<bool>((ref) async {
  return ref.watch(chestServiceProvider).canClaim();
});

class _StreakStrip extends StatelessWidget {
  const _StreakStrip({required this.rewards, required this.streak});

  final List<int> rewards;
  final int streak;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var day = 1; day <= rewards.length; day++)
          _dayCell(context, day, rewards[day - 1], muted),
      ],
    );
  }

  Widget _dayCell(BuildContext context, int day, int reward, Color muted) {
    final claimed = day <= streak;
    final isToday = day == streak + 1;
    final Color bg;
    final Color fg;
    if (claimed) {
      bg = AppColors.goal;
      fg = AppColors.neutral900;
    } else if (isToday) {
      bg = AppColors.positive;
      fg = Colors.white;
    } else {
      bg = AppColors.surfaceBorder(Theme.of(context).brightness);
      fg = muted;
    }

    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: claimed
              ? Icon(Icons.check_rounded, color: fg, size: 18)
              : Text(
                  '$reward',
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
        ),
        const SizedBox(height: 2),
        Text('$day', style: TextStyle(color: muted, fontSize: 9)),
      ],
    );
  }
}

class _BoardPreview extends StatelessWidget {
  const _BoardPreview({required this.board, required this.colorBlind});

  final BoardModel board;
  final bool colorBlind;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = 5.0;
          final maxWidth = constraints.maxWidth.clamp(0, 340).toDouble();
          final tileSize = (maxWidth - gap * (board.cols - 1)) / board.cols;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var r = 0; r < board.rows; r++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: r < board.rows - 1 ? gap : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var c = 0; c < board.cols; c++)
                        Padding(
                          padding: EdgeInsets.only(
                            right: c < board.cols - 1 ? gap : 0,
                          ),
                          child: _cell(board.tileAt(r, c), tileSize),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _cell(TileModel? tile, double size) {
    if (tile == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.neutral500.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(size * 0.16),
        ),
      );
    }
    return TileBadge(
      value: tile.value,
      type: tile.type,
      colorBlindMode: colorBlind,
      size: size,
    );
  }
}
