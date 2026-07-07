import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class GameActionBar extends StatelessWidget {
  const GameActionBar({
    required this.onUndo,
    required this.onHint,
    super.key,
    this.canUndo = false,
    this.canHint = true,
    this.undoSubtitle,
    this.undoBadgeCount,
  });

  final VoidCallback onUndo;
  final VoidCallback onHint;
  final bool canUndo;
  final bool canHint;
  final String? undoSubtitle;
  final int? undoBadgeCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ActionPill(
            icon: Icons.undo_rounded,
            subtitle: undoSubtitle,
            badgeCount: undoBadgeCount,
            onPressed: canUndo ? onUndo : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          _ActionPill(
            icon: Icons.lightbulb_outline_rounded,
            onPressed: canHint ? onHint : null,
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.onPressed,
    this.subtitle,
    this.badgeCount,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? subtitle;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final enabled = onPressed != null;
    final surface = brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final border = AppColors.surfaceBorder(brightness);
    final muted = AppColors.onSurfaceMuted(brightness);
    final primary = Theme.of(context).colorScheme.primary;
    final hasSubtitle = subtitle != null;

    return Material(
      color: surface,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Ink(
          width: hasSubtitle ? 72 : 52,
          height: hasSubtitle ? 60 : 52,
          decoration: ShapeDecoration(
            shape: StadiumBorder(side: BorderSide(color: border)),
            color: surface,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: enabled ? 1 : 0.4,
                  child: hasSubtitle
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon, color: enabled ? primary : muted, size: 24),
                            const SizedBox(height: 2),
                            Text(
                              subtitle!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: muted,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        )
                      : Center(
                          child: Icon(icon, color: enabled ? primary : muted, size: 24),
                        ),
                ),
              ),
              if (badgeCount != null && badgeCount! > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$badgeCount',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
