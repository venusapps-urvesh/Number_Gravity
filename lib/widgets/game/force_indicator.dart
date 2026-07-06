import 'package:flutter/material.dart';

import '../../models/simulation/force_vector.dart';

/// Shell widget for force telegraph lines — wired in Phase 4.
class ForceIndicator extends StatelessWidget {
  const ForceIndicator({
    super.key,
    this.vectors = const [],
  });

  final List<ForceVector> vectors;

  @override
  Widget build(BuildContext context) {
    if (vectors.isEmpty) {
      return const SizedBox.shrink();
    }

    return const SizedBox.shrink();
  }
}
