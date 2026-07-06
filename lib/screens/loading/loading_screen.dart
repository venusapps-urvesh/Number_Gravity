import 'package:flutter/material.dart';

import '../../widgets/common/ng_loading.dart';
import '../../widgets/common/ng_scaffold.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NGScaffold(
      body: Center(child: NGLoading(message: 'Loading assets...')),
    );
  }
}
