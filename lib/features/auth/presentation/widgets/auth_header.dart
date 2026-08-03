import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AuthHeader extends StatelessWidget {

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    this.onBackPressed,
    this.currentStep,
    this.totalSteps,
  });
  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final int? currentStep;
  final int? totalSteps;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBackButton) ...[
          IconButton(
            onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
          AppSpacing.gapMd,
        ],
        if (currentStep != null && totalSteps != null) ...[
          Row(
            children: [
              Text(
                'Step ${currentStep! + 1} of $totalSteps',
                style: AppTypography.labelMedium(
                  color: colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                '${(((currentStep! + 1) / totalSteps!) * 100).round()}%',
                style: AppTypography.labelMedium(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          AppSpacing.gapSm,
          ClipRRect(
            borderRadius: AppSpacing.borderRadiusFull,
            child: LinearProgressIndicator(
              value: (currentStep! + 1) / totalSteps!,
              minHeight: 4,
              backgroundColor: colorScheme.surfaceContainerHighest,
            ),
          ),
          AppSpacing.gapXl,
        ],
        Text(
          title,
          style: AppTypography.headlineLarge(
            color: colorScheme.onSurface,
          ),
        ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.05),
        AppSpacing.gapSm,
        Text(
          subtitle,
          style: AppTypography.bodyLarge(
            color: colorScheme.onSurfaceVariant,
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideX(begin: -0.05),
      ],
    );
  }
}
