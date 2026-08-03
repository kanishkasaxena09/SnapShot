import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class LearningHubSection extends StatelessWidget {
  const LearningHubSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school_rounded, color: AppColors.primaryLight, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Learning Hub',
                style: AppTypography.titleMedium(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push('/learning-hub'),
                child: Text(
                  'View All',
                  style: AppTypography.labelMedium(color: AppColors.primaryLight),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.base),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryLight.withValues(alpha: 0.12),
                  AppColors.accentCyan.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.15),
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: AppColors.primaryLight,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Master New Skills',
                            style: AppTypography.titleSmall(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Roadmaps, lessons, quizzes & more',
                            style: AppTypography.bodySmall(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    _QuickLink(
                      icon: Icons.map_outlined,
                      label: 'Roadmaps',
                      color: AppColors.accentBlue,
                      onTap: () => context.push('/learning/roadmaps'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _QuickLink(
                      icon: Icons.book_outlined,
                      label: 'Lessons',
                      color: AppColors.primaryLight,
                      onTap: () => context.push('/learning/lessons'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _QuickLink(
                      icon: Icons.play_circle_outline,
                      label: 'Videos',
                      color: AppColors.accentPink,
                      onTap: () => context.push('/learning/videos'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _QuickLink(
                      icon: Icons.quiz_outlined,
                      label: 'Quizzes',
                      color: AppColors.accentYellow,
                      onTap: () => context.push('/learning/quizzes'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _QuickLink(
                      icon: Icons.emoji_events_outlined,
                      label: 'Streaks',
                      color: AppColors.accentOrange,
                      onTap: () => context.push('/learning/streaks'),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
