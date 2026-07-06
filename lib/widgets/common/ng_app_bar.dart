import 'package:flutter/material.dart';

class NGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NGAppBar({
    required this.title,
    super.key,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      actions: actions,
    );
  }
}
