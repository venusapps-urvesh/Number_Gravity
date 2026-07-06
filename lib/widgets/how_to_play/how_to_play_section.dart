import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../common/ng_card.dart';

class HowToPlaySection extends StatelessWidget {
  const HowToPlaySection({
    required this.imageAsset,
    required this.title,
    required this.body,
    super.key,
  });

  final String imageAsset;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.onSurfaceMuted(Theme.of(context).brightness);

    return NGCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: AppColors.surfaceBorder(Theme.of(context).brightness),
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            body,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: muted),
          ),
        ],
      ),
    );
  }
}
