import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';

class LearningContinueCard extends StatelessWidget {
  const LearningContinueCard({super.key, required this.progress});

  final LearningProgress progress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              progress.color.withValues(alpha: 0.08),
              progress.color.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(
            color: progress.color.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: progress.color.withValues(alpha: 0.15),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    color: progress.color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Continue Learning',
                        style: AppTypography.labelMedium(
                          color: progress.color,
                        ),
                      ),
                      Text(
                        progress.courseName,
                        style: AppTypography.titleSmall(
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(progress.progress * 100).round()}%',
                  style: AppTypography.titleMedium(
                    color: progress.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: AppSpacing.borderRadiusFull,
              child: LinearProgressIndicator(
                value: progress.progress,
                minHeight: 6,
                backgroundColor: progress.color.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(progress.color),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Text(
                  '${progress.completedLessons}/${progress.totalLessons} lessons',
                  style: AppTypography.bodySmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(Icons.access_time_rounded, size: 12, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 2),
                Text(
                  progress.lastAccessed,
                  style: AppTypography.bodySmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05),
    );
  }
}
