import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class NGCoinBadge extends StatelessWidget {
  const NGCoinBadge({
    required this.amount,
    super.key,
    this.onAddTap,
    this.compact = false,
  });

  final int amount;
  final VoidCallback? onAddTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final surface = brightness == Brightness.dark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final border = AppColors.surfaceBorder(brightness);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 12,
        vertical: compact ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: brightness == Brightness.dark ? 0.2 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.monetization_on_rounded,
            size: compact ? 18 : 20,
            color: AppColors.coinGold,
          ),
          const SizedBox(width: 6),
          Text(
            _formatAmount(amount),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          if (onAddTap != null) ...[
            const SizedBox(width: 4),
            NGAddCoinButton(onTap: onAddTap!),
          ],
        ],
      ),
    );
  }

  String _formatAmount(int value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}k'
          .replaceAll('.0k', 'k');
    }
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}

class NGAddCoinButton extends StatelessWidget {
  const NGAddCoinButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.positive,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: const SizedBox(
          width: AppSpacing.minTapTarget,
          height: 28,
          child: Icon(Icons.add_rounded, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
