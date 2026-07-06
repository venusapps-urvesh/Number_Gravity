import 'package:flutter/material.dart';

import '../../widgets/common/ng_scaffold.dart';

class ZenScreen extends StatelessWidget {
  const ZenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NGScaffold(
      body: Center(child: Text('Zen / Practice mode')),
    );
  }
}
