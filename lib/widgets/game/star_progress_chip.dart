import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../core/constants/game_constants.dart';
import '../common/ng_star_rating.dart';

class StarProgressChip extends StatelessWidget {
  const StarProgressChip({
    required this.movesUsed,
    required this.minimumMoves,
    super.key,
  });

  final int movesUsed;
  final int minimumMoves;

  @override
  Widget build(BuildContext context) {
    final stars = starsForMoves(
      movesUsed: movesUsed,
      minimumMoves: minimumMoves,
    );
    final color = switch (stars) {
      3 => AppColors.positive,
      2 => AppColors.goal,
      _ => AppColors.onSurfaceMuted(Theme.of(context).brightness),
    };

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: NGStarRating(
        stars: stars,
        maxStars: 3,
        size: 18,
        color: color,
      ),
    );
  }
}
