import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary,
              colorScheme.primary.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: AppSpacing.borderRadiusXxl,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 56,
                color: Colors.white,
              ),
            )
                .animate(controller: _controller)
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutBack,
                )
                .then()
                .shimmer(
                  duration: 1200.ms,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Snapshot',
              style: AppTypography.displaySmall(
                color: Colors.white,
              ),
            )
                .animate(controller: _controller)
                .fadeIn(delay: 300.ms, duration: 600.ms)
                .slideY(begin: 0.2),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your Tech Super App',
              style: AppTypography.bodyLarge(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            )
                .animate(controller: _controller)
                .fadeIn(delay: 500.ms, duration: 600.ms)
                .slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }
}
