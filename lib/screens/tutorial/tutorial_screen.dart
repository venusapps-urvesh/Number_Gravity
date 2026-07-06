import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import '../../widgets/common/ng_button.dart';
import '../../widgets/common/ng_scaffold.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NGScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tutorial', style: Theme.of(context).textTheme.headlineMedium),
            const Text('Learn attraction by playing level 1.'),
            const Spacer(),
            NGButton(
              label: 'Start Level 1',
              onPressed: () => context.go('${AppRoutes.play}/1'),
            ),
          ],
        ),
      ),
    );
  }
}
