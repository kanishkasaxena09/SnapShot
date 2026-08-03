import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppErrorWidget extends StatelessWidget {

  const AppErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    required this.message,
    this.actionLabel,
    this.onAction,
    this.icon,
  });
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.error_outline_rounded,
                size: 40,
                color: colorScheme.error,
              ),
            ),
            AppSpacing.gapLg,
            Text(
              title,
              style: AppTypography.titleLarge(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapSm,
            Text(
              message,
              style: AppTypography.bodyMedium(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.gapXl,
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppEmptyWidget extends StatelessWidget {

  const AppEmptyWidget({
    super.key,
    this.title = 'Nothing here yet',
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });
  final String title;
  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 72,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            AppSpacing.gapLg,
            Text(
              title,
              style: AppTypography.titleMedium(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapSm,
            Text(
              message,
              style: AppTypography.bodyMedium(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.gapXl,
              FilledButton.tonal(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
