import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/game_session_provider.dart';
import '../common/ng_coin_badge.dart';
import '../common/ng_icon_button.dart';

class GameHud extends StatelessWidget {
  const GameHud({
    required this.levelId,
    required this.movesUsed,
    required this.optimalMoves,
    required this.onPause,
    required this.onUndo,
    required this.onHint,
    super.key,
    this.hintCount = 0,
    this.coinAmount = 0,
    this.canUndo = false,
    this.canHint = true,
  });

  final int levelId;
  final int movesUsed;
  final int? optimalMoves;
  final VoidCallback onPause;
  final VoidCallback onUndo;
  final VoidCallback onHint;
  final int hintCount;
  final int coinAmount;
  final bool canUndo;
  final bool canHint;

  factory GameHud.fromSession({
    required GameSessionState session,
    required VoidCallback onPause,
    required VoidCallback onUndo,
    required VoidCallback onHint,
    int hintCount = 0,
    int coinAmount = 0,
  }) {
    return GameHud(
      levelId: session.level.id,
      movesUsed: session.movesUsed,
      optimalMoves: session.level.minimumMoves,
      onPause: onPause,
      onUndo: onUndo,
      onHint: onHint,
      hintCount: hintCount,
      coinAmount: coinAmount,
      canUndo: session.moveHistory.length > 1,
      canHint: session.level.solutionMoves.isNotEmpty,
    );
  }

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

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: brightness == Brightness.dark ? 0.2 : 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
                    ),
                  ],
                ),
              ),
              NGCoinBadge(amount: coinAmount, compact: true),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (optimal != null)
                Expanded(
                  child: Text(
                    l10n.movesOptimal(movesUsed, optimal),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: muted,
                        ),
                  ),
                ),
              NGIconButton(
                icon: Icons.undo_rounded,
                tooltip: l10n.undo,
                onPressed: canUndo ? onUndo : null,
              ),
              NGIconButton(
                icon: Icons.lightbulb_outline_rounded,
                tooltip: l10n.hint,
                onPressed: canHint ? onHint : null,
                badge: hintCount > 0 ? hintCount : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
