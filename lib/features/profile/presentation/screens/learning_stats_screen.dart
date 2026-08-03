import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class LearningStatsScreen extends ConsumerWidget {
  const LearningStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(learningStatsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Learning Stats', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak Banner
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.accentOrange, AppColors.accentOrange.withValues(alpha: 0.8)]),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.white, size: 40),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${stats.currentStreak} Day Streak!', style: AppTypography.titleLarge(color: Colors.white)),
                      Text('Longest: ${stats.longestStreak} days', style: AppTypography.bodySmall(color: Colors.white.withValues(alpha: 0.85))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Stats Grid
            Text('Overview', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _StatTile(value: '${stats.totalLessonsCompleted}', label: 'Lessons\nCompleted', color: AppColors.accentBlue),
                _StatTile(value: '${stats.totalHoursLearned}h', label: 'Hours\nLearned', color: AppColors.accentCyan),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _StatTile(value: '${stats.coursesCompleted}', label: 'Courses\nCompleted', color: Colors.green),
                _StatTile(value: '${stats.quizzesPassed}', label: 'Quizzes\nPassed', color: AppColors.accentPink),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _StatTile(value: '${stats.skillsLearned}', label: 'Skills\nLearned', color: AppColors.primaryLight),
                _StatTile(value: '${stats.longestStreak}d', label: 'Longest\nStreak', color: AppColors.accentYellow),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Weekly Progress
            Text('This Week', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusLg,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: SizedBox(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (i) {
                    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    final value = stats.weeklyProgress[i];
                    final maxValue = stats.weeklyProgress.reduce((a, b) => a > b ? a : b);
                    final height = maxValue > 0 ? (value / maxValue) * 80.0 : 0.0;
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${value}h', style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                          const SizedBox(height: 4),
                          Container(
                            height: height,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: AppSpacing.borderRadiusXs,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(days[i], style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Monthly Trend
            Text('Monthly Trend (hours)', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusLg,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: SizedBox(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(12, (i) {
                    final value = stats.monthlyProgress[i];
                    final maxValue = stats.monthlyProgress.reduce((a, b) => a > b ? a : b);
                    final height = maxValue > 0 ? (value / maxValue) * 80.0 : 0.0;
                    return Expanded(
                      child: Container(
                        height: height,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentCyan.withValues(alpha: 0.8),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label, required this.color});
  final String value, label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(value, style: AppTypography.titleLarge(color: color)),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
