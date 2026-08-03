import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AuthBottomBar extends StatelessWidget {

  const AuthBottomBar({
    super.key,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
    this.isLoading = false,
    this.isPrimaryEnabled = true,
  });
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final bool isLoading;
  final bool isPrimaryEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: isPrimaryEnabled && !isLoading
              ? onPrimaryPressed
              : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(primaryLabel),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
        if (secondaryLabel != null && onSecondaryPressed != null) ...[
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: onSecondaryPressed,
            child: Text(secondaryLabel!),
          ),
        ],
      ],
    );
  }
}

class OnboardingWelcome extends StatelessWidget {

  const OnboardingWelcome({
    super.key,
    required this.title,
    required this.description,
    this.lottieAsset,
    this.child,
  });
  final String title;
  final String description;
  final String? lottieAsset;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        if (lottieAsset != null)
          SizedBox(
            height: 200,
            child: Lottie.asset(
              lottieAsset!,
              repeat: true,
              animate: true,
            ),
          ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
        const SizedBox(height: AppSpacing.xxl),
        Text(
          title,
          style: AppTypography.headlineMedium(
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
        const SizedBox(height: AppSpacing.md),
        Text(
          description,
          style: AppTypography.bodyLarge(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
        if (child != null) ...[
          const SizedBox(height: AppSpacing.xxl),
          child!,
        ],
      ],
    );
  }
}
