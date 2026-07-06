import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NGScaffold extends StatelessWidget {
  const NGScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.floatingActionButton,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  AppColors.darkBackground,
                  AppColors.neutral900,
                ]
              : [
                  AppColors.lightBackground,
                  AppColors.neutral200,
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: SafeArea(child: body),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
