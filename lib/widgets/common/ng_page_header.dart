import 'package:flutter/material.dart';

import '../../app/router/navigation.dart';
import '../../app/theme/app_colors.dart';
import 'ng_coin_badge.dart';
import 'ng_icon_button.dart';

class NGPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const NGPageHeader({
    required this.title,
    super.key,
    this.coinAmount,
    this.onAddCoins,
    this.showBack = true,
    this.actions,
  });

  final String title;
  final int? coinAmount;
  final VoidCallback? onAddCoins;
  final bool showBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        children: [
          if (showBack)
            NGIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () => ngGoBack(context),
              variant: NGIconButtonVariant.surface,
            )
          else
            const SizedBox(width: AppSpacing.minTapTarget),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (coinAmount != null)
            NGCoinBadge(
              amount: coinAmount!,
              onAddTap: onAddCoins,
              compact: true,
            )
          else if (actions != null && actions!.isNotEmpty)
            Row(mainAxisSize: MainAxisSize.min, children: actions!)
          else
            SizedBox(width: showBack ? AppSpacing.minTapTarget : 0),
        ],
      ),
    );
  }
}
