import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.height = 6,
    this.borderRadius,
  });

  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: borderRadius ?? AppSpacing.borderRadiusXs,
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: backgroundColor ?? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        valueColor: AlwaysStoppedAnimation(color ?? Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
