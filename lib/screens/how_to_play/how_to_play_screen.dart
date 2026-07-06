import 'package:flutter/material.dart';

import '../../app/router/navigation.dart';
import '../../app/theme/app_colors.dart';
import '../../core/constants/how_to_play_assets.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_page_header.dart';
import '../../widgets/common/ng_responsive_layout.dart';
import '../../widgets/common/ng_scaffold.dart';
import '../../widgets/how_to_play/how_to_play_section.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    final sections = [
      (HowToPlayAssets.goal, l10n.howToPlayGoalTitle, l10n.howToPlayGoalBody),
      (HowToPlayAssets.pull, l10n.howToPlayPullTitle, l10n.howToPlayPullBody),
      (HowToPlayAssets.push, l10n.howToPlayPushTitle, l10n.howToPlayPushBody),
      (
        HowToPlayAssets.swipe,
        l10n.howToPlaySwipeTitle,
        l10n.howToPlaySwipeBody,
      ),
      (
        HowToPlayAssets.gravity,
        l10n.howToPlayGravityTitle,
        l10n.howToPlayGravityBody,
      ),
      (
        HowToPlayAssets.stars,
        l10n.howToPlayStarsTitle,
        l10n.howToPlayStarsBody,
      ),
      (
        HowToPlayAssets.controls,
        l10n.howToPlayControlsTitle,
        l10n.howToPlayControlsBody,
      ),
    ];

    return NGScaffold(
      body: Column(
        children: [
          NGPageHeader(title: l10n.howToPlay),
          Expanded(
            child: NGResponsiveLayout(
              child: ListView(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                children: [
                  Text(
                    l10n.howToPlayIntro,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: muted),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (final section in sections) ...[
                    HowToPlaySection(
                      imageAsset: section.$1,
                      title: section.$2,
                      body: section.$3,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  NGButton(
                    label: l10n.howToPlayStart,
                    icon: Icons.play_arrow_rounded,
                    variant: NGButtonVariant.accent,
                    onPressed: () => ngPushToPlay(context, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
