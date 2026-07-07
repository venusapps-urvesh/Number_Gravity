import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class GameActionBar extends StatelessWidget {
  const GameActionBar({
    required this.onUndo,
    required this.onHint,
    required this.onRedo,
    required this.onRestart,
    super.key,
    this.canUndo = false,
    this.canRedo = false,
    this.canHint = true,
    this.undoCostLabel,
    this.redoCostLabel,
  });

  final VoidCallback onUndo;
  final VoidCallback onHint;
  final VoidCallback onRedo;
  final VoidCallback onRestart;
  final bool canUndo;
  final bool canRedo;
  final bool canHint;
  final String? undoCostLabel;
  final String? redoCostLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          _ActionPill(
            icon: Icons.refresh_rounded,
            label: l10n.restart,
            onPressed: onRestart,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _ActionPill(
              icon: Icons.undo_rounded,
              label: l10n.undo,
              subtitle: undoCostLabel,
              onPressed: canUndo ? onUndo : null,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _ActionPill(
              icon: Icons.redo_rounded,
              label: l10n.redo,
              subtitle: redoCostLabel,
              onPressed: canRedo ? onRedo : null,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _ActionPill(
              icon: Icons.lightbulb_outline_rounded,
              label: l10n.hint,
              onPressed: canHint ? onHint : null,
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
    this.subtitle,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final String? subtitle;

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
          child: Opacity(
            opacity: enabled ? 1 : 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: enabled ? primary : muted, size: 20),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: enabled ? null : muted,
                            ),
                      ),
                    ),
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: muted,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
