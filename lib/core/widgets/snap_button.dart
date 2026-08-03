import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

enum ButtonVariant { filled, outlined, text, tonal }

class SnapButton extends StatelessWidget {

  const SnapButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    this.isExpanded = false,
    this.isDense = false,
    this.color,
    this.tooltip,
  });
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isExpanded;
  final bool isDense;
  final Color? color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final child = _buildChild(context);

    Widget button;
    switch (variant) {
      case ButtonVariant.filled:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: color,
            minimumSize: Size(
              0,
              isDense ? AppSpacing.buttonHeightMd : AppSpacing.buttonHeightLg,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDense ? AppSpacing.base : AppSpacing.xl,
              vertical: isDense ? AppSpacing.sm : AppSpacing.md,
            ),
          ),
          child: child,
        );
      case ButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            minimumSize: Size(
              0,
              isDense ? AppSpacing.buttonHeightMd : AppSpacing.buttonHeightLg,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDense ? AppSpacing.base : AppSpacing.xl,
              vertical: isDense ? AppSpacing.sm : AppSpacing.md,
            ),
          ),
          child: child,
        );
      case ButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: color,
            minimumSize: Size(0, isDense ? AppSpacing.buttonHeightMd : AppSpacing.buttonHeightMd),
            padding: EdgeInsets.symmetric(
              horizontal: isDense ? AppSpacing.sm : AppSpacing.base,
              vertical: isDense ? AppSpacing.xs : AppSpacing.sm,
            ),
          ),
          child: child,
        );
      case ButtonVariant.tonal:
        button = FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: color,
            minimumSize: Size(
              0,
              isDense ? AppSpacing.buttonHeightMd : AppSpacing.buttonHeightLg,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isDense ? AppSpacing.base : AppSpacing.xl,
              vertical: isDense ? AppSpacing.sm : AppSpacing.md,
            ),
          ),
          child: child,
        );
    }

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon!, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      );
    }

    return Text(label);
  }
}

class SnapIconButton extends StatelessWidget {

  const SnapIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 40,
    this.color,
    this.backgroundColor,
    this.isSelected = false,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Widget button = IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size * 0.6,
        color: isSelected ? colorScheme.primary : color,
      ),
      style: IconButton.styleFrom(
        minimumSize: Size(size, size),
        backgroundColor: isSelected
            ? colorScheme.primaryContainer
            : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusSm,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
