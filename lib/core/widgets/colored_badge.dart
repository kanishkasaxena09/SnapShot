import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class ColoredBadge extends StatelessWidget {
  const ColoredBadge({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.textStyle,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusXs,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: textStyle ?? TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
