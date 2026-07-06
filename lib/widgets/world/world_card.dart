import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../levels/world_config.dart';
import '../common/ng_card.dart';
import '../common/ng_star_rating.dart';

class WorldCard extends StatelessWidget {
  const WorldCard({
    required this.world,
    required this.completedLevels,
    required this.totalLevels,
    required this.earnedStars,
    required this.totalStars,
    required this.isUnlocked,
    required this.isCurrent,
    required this.onTap,
    super.key,
  });

  final WorldConfig world;
  final int completedLevels;
  final int totalLevels;
  final int earnedStars;
  final int totalStars;
  final bool isUnlocked;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final borderColor = isCurrent
        ? Theme.of(context).colorScheme.primary
        : AppColors.surfaceBorder(brightness);
    final muted = AppColors.onSurfaceMuted(brightness);
    final progress = totalLevels == 0 ? 0.0 : completedLevels / totalLevels;

    return Opacity(
      opacity: isUnlocked ? 1 : 0.55,
      child: NGCard(
        onTap: isUnlocked ? onTap : null,
        padding: const EdgeInsets.all(16),
        borderColor: borderColor,
        borderWidth: isCurrent ? 2 : 1,
        child: Stack(
          children: [
            if (isCurrent)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'CURRENT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
              ),
            Row(
              children: [
                _WorldIcon(worldId: world.id, isLocked: !isUnlocked),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WORLD ${world.id}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                      ),
                      Text(
                        world.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: brightness == Brightness.dark
                              ? AppColors.neutral700
                              : AppColors.neutral200,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$completedLevels / $totalLevels levels',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (isUnlocked)
                  NGStarCount(earned: earnedStars, total: totalStars)
                else
                  Container(
                    width: AppSpacing.minTapTarget,
                    height: AppSpacing.minTapTarget,
                    decoration: BoxDecoration(
                      color: brightness == Brightness.dark
                          ? AppColors.neutral800
                          : AppColors.neutral100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.lock_rounded, color: muted, size: 20),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WorldIcon extends StatelessWidget {
  const _WorldIcon({required this.worldId, required this.isLocked});

  final int worldId;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final icon = _iconForWorld(worldId);
    final color = isLocked
        ? AppColors.neutral400
        : _accentForWorld(worldId);

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: color.withValues(alpha: isLocked ? 0.15 : 0.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: isLocked ? AppColors.neutral400 : color, size: 32),
    );
  }

  IconData _iconForWorld(int id) {
    return switch (id) {
      1 => Icons.grid_view_rounded,
      2 => Icons.north_east_rounded,
      3 => Icons.layers_rounded,
      4 => Icons.swap_vert_rounded,
      5 => Icons.cyclone_rounded,
      6 => Icons.auto_fix_high_rounded,
      7 => Icons.toggle_on_rounded,
      _ => Icons.workspace_premium_rounded,
    };
  }

  Color _accentForWorld(int id) {
    return switch (id) {
      1 => AppColors.positive,
      2 => const Color(0xFF7C3AED),
      3 => const Color(0xFF16A34A),
      4 => AppColors.positive,
      5 => const Color(0xFF0891B2),
      6 => const Color(0xFFEA580C),
      7 => const Color(0xFFDB2777),
      _ => AppColors.goal,
    };
  }
}
