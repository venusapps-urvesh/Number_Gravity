import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/tile_type.dart';
import '../../providers/providers.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/game/tile_badge.dart';

class ZenScreen extends ConsumerWidget {
  const ZenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.zenMode),
          Expanded(
            child: NGResponsiveLayout(
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.dailyAccent.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.nightlight_round,
                        color: AppColors.dailyAccent, size: 44),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileBadge(
                        value: 2,
                        type: TileType.number,
                        colorBlindMode: colorBlind,
                        size: 44,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      TileBadge(
                        value: -1,
                        type: TileType.number,
                        colorBlindMode: colorBlind,
                        size: 44,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      TileBadge(
                        value: 0,
                        type: TileType.goal,
                        colorBlindMode: colorBlind,
                        size: 44,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.zenSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.zenBody,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: muted),
                  ),
                  const Spacer(),
                  NGButton(
                    label: l10n.startZen,
                    icon: Icons.play_arrow_rounded,
                    variant: NGButtonVariant.accent,
                    accent: NGButtonAccent.daily,
                    onPressed: () => context.push('${AppRoutes.play}/1'),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
