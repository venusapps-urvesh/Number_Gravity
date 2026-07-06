import 'package:flutter/material.dart';

import '../../widgets/common/ng_scaffold.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NGScaffold(
      body: Center(child: Text('Achievements')),
    );
  }
}
