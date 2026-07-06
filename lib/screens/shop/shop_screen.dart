import 'package:flutter/material.dart';

import '../../widgets/common/ng_scaffold.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NGScaffold(
      body: Center(child: Text('Coin packs & cosmetics')),
    );
  }
}
