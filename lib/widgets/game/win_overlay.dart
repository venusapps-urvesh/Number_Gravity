import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/game_constants.dart';
import '../../l10n/app_localizations.dart';

class WinOverlay extends StatelessWidget {
  const WinOverlay({
    required this.movesUsed,
    required this.minimumMoves,
    required this.onNextLevel,
    required this.onReplay,
    super.key,
  });

  final int movesUsed;
  final int minimumMoves;
  final VoidCallback onNextLevel;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stars = starsForMoves(
      movesUsed: movesUsed,
      minimumMoves: minimumMoves,
    );
    final brightness = Theme.of(context).brightness;

    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.55),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.goal.withValues(alpha: 0.35),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.levelComplete,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.goal,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final filled = index < stars;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      filled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: filled ? AppColors.goal : AppColors.neutral400,
                      size: 36,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.movesOptimal(movesUsed, minimumMoves),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onNextLevel,
                  child: Text(l10n.nextLevel),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onReplay,
                  child: Text(l10n.replay),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
