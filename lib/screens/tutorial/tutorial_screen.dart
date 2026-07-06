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

class _Step {
  const _Step({
    required this.title,
    required this.body,
    required this.tileValue,
    required this.tileType,
  });

  final String title;
  final String body;
  final int tileValue;
  final TileType tileType;
}

class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({super.key});

  @override
  ConsumerState<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends ConsumerState<TutorialScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorBlind = ref.watch(colorBlindModeProvider).value ?? false;
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    final steps = [
      _Step(
        title: l10n.tutorialTitle1,
        body: l10n.tutorialBody1,
        tileValue: 3,
        tileType: TileType.number,
      ),
      _Step(
        title: l10n.tutorialTitle2,
        body: l10n.tutorialBody2,
        tileValue: -2,
        tileType: TileType.number,
      ),
      _Step(
        title: l10n.tutorialTitle3,
        body: l10n.tutorialBody3,
        tileValue: 0,
        tileType: TileType.goal,
      ),
    ];

    final step = steps[_index];
    final isLast = _index == steps.length - 1;

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(
            title: l10n.tutorial,
            actions: [
              TextButton(
                onPressed: () => context.push('${AppRoutes.play}/1'),
                child: Text(l10n.skip),
              ),
            ],
          ),
          Expanded(
            child: NGResponsiveLayout(
              child: Column(
                children: [
                  const Spacer(),
                  _MiniBoard(
                    activeValue: step.tileValue,
                    activeType: step.tileType,
                    colorBlind: colorBlind,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    step.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    step.body,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: muted),
                  ),
                  const Spacer(),
                  _Dots(count: steps.length, index: _index),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.tutorialStep(_index + 1, steps.length),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: muted),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  NGButton(
                    label: isLast ? l10n.startPlaying : l10n.next,
                    icon: isLast
                        ? Icons.play_arrow_rounded
                        : Icons.arrow_forward_rounded,
                    variant: NGButtonVariant.accent,
                    onPressed: () {
                      if (isLast) {
                        context.push('${AppRoutes.play}/1');
                      } else {
                        setState(() => _index++);
                      }
                    },
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

class _MiniBoard extends StatelessWidget {
  const _MiniBoard({
    required this.activeValue,
    required this.activeType,
    required this.colorBlind,
  });

  final int activeValue;
  final TileType activeType;
  final bool colorBlind;

  @override
  Widget build(BuildContext context) {
    const size = 60.0;
    const gap = 10.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TileBadge(
              value: activeValue,
              type: activeType,
              colorBlindMode: colorBlind,
              size: size,
              selected: true,
            ),
            const SizedBox(width: gap),
            const Icon(Icons.arrow_forward_rounded,
                color: AppColors.positive, size: 28),
            const SizedBox(width: gap),
            TileBadge(
              value: 0,
              type: TileType.goal,
              colorBlindMode: colorBlind,
              size: size,
            ),
          ],
        ),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == index ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index
                  ? AppColors.positive
                  : AppColors.surfaceBorder(Theme.of(context).brightness),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
