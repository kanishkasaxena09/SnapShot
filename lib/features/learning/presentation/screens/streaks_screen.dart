import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/learning_providers.dart';

class StreaksScreen extends ConsumerWidget {
  const StreaksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);
    final xpProgress = streak.levelProgress;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Your Streaks', style: AppTypography.headlineLarge()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: AppSpacing.paddingXl,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                children: [
                  Text(
                    '${streak.currentStreak}',
                    style: AppTypography.displayLarge(
                      color: AppColors.textInverseLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.accentOrange,
                        size: AppSpacing.iconMd,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Day Streak',
                        style: AppTypography.titleMedium(
                          color: AppColors.textInverseLight.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Longest: ${streak.longestStreak} days',
                    style: AppTypography.bodyMedium(
                      color: AppColors.textInverseLight.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${streak.level}',
                      style: AppTypography.titleMedium(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level ${streak.level}',
                        style: AppTypography.titleSmall(
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      ClipRRect(
                        borderRadius: AppSpacing.borderRadiusFull,
                        child: LinearProgressIndicator(
                          value: xpProgress,
                          minHeight: 8,
                          backgroundColor: AppColors.borderLight,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        '${(streak.totalXP % streak.xpToNextLevel)} / ${streak.xpToNextLevel} XP to next level',
                        style: AppTypography.labelSmall(
                          color: AppColors.textTertiaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: _XpStatCard(
                    label: "Today's XP",
                    value: '${streak.todayXP}',
                    icon: Icons.today_rounded,
                    color: AppColors.successLight,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _XpStatCard(
                    label: 'Weekly XP',
                    value: '${streak.weeklyXP}',
                    icon: Icons.date_range_rounded,
                    color: AppColors.accentBlue,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _XpStatCard(
                    label: 'Total XP',
                    value: '${streak.totalXP}',
                    icon: Icons.star_rounded,
                    color: AppColors.accentOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Activity Calendar',
              style: AppTypography.titleMedium(
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: AppSpacing.paddingBase,
              decoration: BoxDecoration(
                color: AppColors.cardLight,
                borderRadius: AppSpacing.borderRadiusMd,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: List.generate(30, (index) {
                  final dayIndex = streak.calendarDays.length > index
                      ? streak.calendarDays[index]
                      : null;
                  final isActive = dayIndex?.isActive ?? false;
                  final minutes = dayIndex?.minutesStudied ?? 0;

                  Color bgColor;
                  if (!isActive) {
                    bgColor = AppColors.surfaceVariantLight;
                  } else if (minutes > 60) {
                    bgColor = AppColors.successLight;
                  } else if (minutes > 30) {
                    bgColor = AppColors.successLight.withOpacity(0.7);
                  } else {
                    bgColor = AppColors.successLight.withOpacity(0.4);
                  }

                  return Tooltip(
                    message: isActive
                        ? '$minutes min studied'
                        : 'No activity',
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: AppSpacing.borderRadiusXs,
                      ),
                      child: isActive
                          ? const Icon(
                              Icons.check_rounded,
                              size: AppSpacing.iconSm,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.6,
              children: [
                _StatCard(
                  label: 'Total Days Studied',
                  value: '${streak.totalDaysStudied}',
                  icon: Icons.calendar_today_rounded,
                  color: AppColors.primaryLight,
                ),
                _StatCard(
                  label: 'Total Hours',
                  value: '${streak.totalHoursStudied}',
                  icon: Icons.access_time_rounded,
                  color: AppColors.accentBlue,
                ),
                _StatCard(
                  label: 'Current Streak',
                  value: '${streak.currentStreak}',
                  icon: Icons.local_fire_department_rounded,
                  color: AppColors.accentOrange,
                ),
                _StatCard(
                  label: 'Longest Streak',
                  value: '${streak.longestStreak}',
                  icon: Icons.emoji_events_rounded,
                  color: AppColors.accentYellow,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _XpStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _XpStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppSpacing.iconMd, color: color),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.titleMedium(
              color: AppColors.textPrimaryLight,
            ),
          ),
          Text(
            label,
            style: AppTypography.labelSmall(
              color: AppColors.textTertiaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: AppSpacing.borderRadiusMd,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: AppSpacing.iconMd, color: color),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.headlineSmall(
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.labelSmall(
              color: AppColors.textTertiaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
