import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class GameActionBar extends StatelessWidget {
  const GameActionBar({
    required this.onUndo,
    required this.onHint,
    super.key,
    this.canUndo = false,
    this.canHint = true,
    this.hintCount = 0,
  });

  final VoidCallback onUndo;
  final VoidCallback onHint;
  final bool canUndo;
  final bool canHint;
  final int hintCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: _ActionPill(
              icon: Icons.undo_rounded,
              label: l10n.undo,
              onPressed: canUndo ? onUndo : null,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _ActionPill(
              icon: Icons.lightbulb_outline_rounded,
              label: l10n.hint,
              onPressed: canHint ? onHint : null,
              badge: hintCount > 0 ? hintCount : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.badge,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final int? badge;

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

    return Material(
      color: surface,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Ink(
          height: 52,
          decoration: ShapeDecoration(
            shape: StadiumBorder(side: BorderSide(color: border)),
            color: surface,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: enabled ? 1 : 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: enabled ? primary : muted, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: enabled ? null : muted,
                      ),
                    ),
                  ],
                ),
              ),
              if (badge != null)
                Positioned(
                  top: 6,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$badge',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
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
