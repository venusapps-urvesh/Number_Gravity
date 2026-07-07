import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/game_constants.dart';
import '../../l10n/app_localizations.dart';
import '../common/ng_coin_badge.dart';
import '../common/ng_icon_button.dart';

class GameHud extends StatelessWidget {
  const GameHud({
    required this.levelId,
    required this.movesUsed,
    required this.optimalMoves,
    required this.onPause,
    super.key,
    this.onBack,
    this.coinAmount = 0,
    this.showCoins = true,
    this.starChip,
  });

  final int levelId;
  final int movesUsed;
  final int? optimalMoves;
  final VoidCallback onPause;
  final VoidCallback? onBack;
  final int coinAmount;
  final bool showCoins;
  final Widget? starChip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;
    final surface = brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final border = AppColors.surfaceBorder(brightness);
    final muted = AppColors.onSurfaceMuted(brightness);
    final optimal = optimalMoves;
    final overPar = optimal != null && movesUsed > optimal + starThresholdTwoStars;
    final moveColor = overPar ? AppColors.negative : muted;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: brightness == Brightness.dark ? 0.2 : 0.06,
            ),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (onBack != null)
                NGIconButton(
                  icon: Icons.arrow_back_rounded,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: onBack,
                  variant: NGIconButtonVariant.plain,
                ),
              NGIconButton(
                icon: Icons.pause_rounded,
                tooltip: l10n.pause,
                onPressed: onPause,
                variant: NGIconButtonVariant.plain,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      l10n.levelTitle(levelId),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      l10n.appName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: muted),
                    ),
                  ],
                ),
              ),
              if (showCoins) NGCoinBadge(amount: coinAmount, compact: true),
            ],
          ),
          if (optimal != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.movesOptimal(movesUsed, optimal),
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(
                    color: moveColor,
                    fontWeight: overPar ? FontWeight.w700 : FontWeight.normal,
                  ),
            ),
            if (starChip != null) starChip!,
          ],
        ],
      ),
    );
  }
}
