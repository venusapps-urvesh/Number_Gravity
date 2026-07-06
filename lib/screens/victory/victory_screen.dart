import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_scaffold.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({
    required this.stars,
    required this.moves,
    super.key,
  });

  final int stars;
  final int moves;

  @override
  Widget build(BuildContext context) {
    return NGScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Victory!', style: Theme.of(context).textTheme.displayLarge),
            Text('★' * stars),
            Text('Moves: $moves'),
            const SizedBox(height: 24),
            NGButton(
              label: 'Continue',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
