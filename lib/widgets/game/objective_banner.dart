import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/level/level_model.dart';
import '../../models/objective/objective_model.dart';

class ObjectiveBanner extends StatelessWidget {
  const ObjectiveBanner({
    required this.level,
    super.key,
  });

  final LevelModel level;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightness = Theme.of(context).brightness;
    final muted = AppColors.onSurfaceMuted(brightness);
    final text = _objectiveText(l10n, level.objective);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: muted,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  String _objectiveText(AppLocalizations l10n, ObjectiveModel objective) {
    return objective.when(
      position: (tileId, _, _) => l10n.objectivePosition(tileId),
      sequence: (_, values) => l10n.objectiveSequence(values.join(' → ')),
      sum: (_, target) => l10n.objectiveSum(target),
      balance: (_, target) => l10n.objectiveBalance(target),
      collection: (_) => l10n.objectiveCollection,
      chain: (_) => l10n.objectiveChain,
    );
  }
}
