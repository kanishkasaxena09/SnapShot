import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';

enum SocialLoginType { google, github, apple }

class SocialLoginButton extends StatelessWidget {

  const SocialLoginButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
  });
  final SocialLoginType type;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        side: BorderSide(color: colorScheme.outline),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(),
                AppSpacing.hGapMd,
                Text(
                  _label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildIcon() {
    switch (type) {
      case SocialLoginType.google:
        return const Icon(Icons.g_mobiledata_rounded, size: 24);
      case SocialLoginType.github:
        return const Icon(Icons.code_rounded, size: 22);
      case SocialLoginType.apple:
        return const Icon(Icons.apple_rounded, size: 22);
    }
  }

  String get _label {
    switch (type) {
      case SocialLoginType.google:
        return 'Continue with Google';
      case SocialLoginType.github:
        return 'Continue with GitHub';
      case SocialLoginType.apple:
        return 'Continue with Apple';
    }
  }
}
