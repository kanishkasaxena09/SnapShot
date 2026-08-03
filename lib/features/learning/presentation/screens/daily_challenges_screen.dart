import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

class DailyChallengesScreen extends ConsumerWidget {
  const DailyChallengesScreen({super.key});

  Color _statusBorderColor(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.pending:
        return AppColors.textTertiaryLight;
      case ChallengeStatus.active:
        return AppColors.infoLight;
      case ChallengeStatus.completed:
        return AppColors.successLight;
      case ChallengeStatus.failed:
        return AppColors.errorLight;
    }
  }

  Color _difficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.successLight;
      case DifficultyLevel.intermediate:
        return AppColors.warningLight;
      case DifficultyLevel.advanced:
        return AppColors.errorLight;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final challenges = ref.watch(dailyChallengesProvider);
    final streak = ref.watch(streakProvider);
    final now = DateTime.now();
    final todayStr =
        '${now.day}/${now.month}/${now.year}';
    final completedCount =
        challenges.where((c) => c.status == ChallengeStatus.completed).length;
    final todayPoints = challenges
        .where((c) => c.status == ChallengeStatus.completed)
        .fold<int>(0, (sum, c) => sum + c.points);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Daily Challenges', style: AppTypography.headlineLarge()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base,
              AppSpacing.sm,
              AppSpacing.base,
              0,
            ),
            child: Container(
              width: double.infinity,
              padding: AppSpacing.paddingXl,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todayStr,
                    style: AppTypography.bodyMedium(
                      color: AppColors.textInverseLight.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.accentOrange,
                        size: AppSpacing.iconLg,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '${streak.currentStreak}',
                        style: AppTypography.headlineMedium(
                          color: AppColors.textInverseLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xxl),
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.accentYellow,
                        size: AppSpacing.iconLg,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '$todayPoints pts',
                        style: AppTypography.headlineMedium(
                          color: AppColors.textInverseLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xxl),
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppColors.textInverseLight,
                        size: AppSpacing.iconLg,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '$completedCount/${challenges.length}',
                        style: AppTypography.headlineMedium(
                          color: AppColors.textInverseLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          Expanded(
            child: challenges.isEmpty
                ? Center(
                    child: Text(
                      'No challenges available today',
                      style: AppTypography.bodyMedium(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.sm,
                    ),
                    itemCount: challenges.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final challenge = challenges[index];
                      final borderColor = _statusBorderColor(challenge.status);
                      final remaining = challenge.expiresAt.difference(now);
                      final expired = remaining.isNegative;

                      return Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border(
                            left: BorderSide(
                              color: borderColor,
                              width: 4,
                            ),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: AppSpacing.cardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              challenge.title,
                              style: AppTypography.titleMedium(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              challenge.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodySmall(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.xs,
                              children: [
                                _InfoChip(
                                  label: challenge.difficulty.name,
                                  color: _difficultyColor(
                                    challenge.difficulty,
                                  ),
                                ),
                                _InfoChip(
                                  label: challenge.category,
                                  color: colorScheme.primary,
                                ),
                                _InfoChip(
                                  label: '${challenge.timeLimitMinutes} min',
                                  color: AppColors.accentBlue,
                                ),
                                _InfoChip(
                                  label: '${challenge.points} pts',
                                  color: AppColors.accentOrange,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildActionButton(
                                    challenge.status,
                                  ),
                                ),
                                if (!expired &&
                                    challenge.status !=
                                        ChallengeStatus.completed) ...[
                                  const SizedBox(width: AppSpacing.sm),
                                  Icon(
                                    Icons.timer_outlined,
                                    size: AppSpacing.iconSm,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text(
                                    '${remaining.inHours}h ${remaining.inMinutes % 60}m',
                                    style: AppTypography.labelSmall(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (expired &&
                                challenge.status !=
                                    ChallengeStatus.completed) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Expired',
                                style: AppTypography.labelSmall(
                                  color: colorScheme.error,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(ChallengeStatus status) {
    switch (status) {
      case ChallengeStatus.pending:
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryLight),
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            minimumSize: const Size(0, AppSpacing.buttonHeightMd),
          ),
          child: Text(
            'Start Challenge',
            style: AppTypography.labelMedium(color: AppColors.primaryLight),
          ),
        );
      case ChallengeStatus.active:
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.infoLight.withOpacity(0.1),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.infoLight,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'In Progress...',
                  style: AppTypography.labelMedium(
                    color: AppColors.infoLight,
                  ),
                ),
              ],
            ),
          ),
        );
      case ChallengeStatus.completed:
        return Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: AppSpacing.iconMd,
              color: AppColors.successLight,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Completed',
              style: AppTypography.labelMedium(
                color: AppColors.successLight,
              ),
            ),
            const Spacer(),
            Text(
              'View Results',
              style: AppTypography.labelMedium(
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSpacing.iconXs,
              color: AppColors.primaryLight,
            ),
          ],
        );
      case ChallengeStatus.failed:
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.errorLight),
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            minimumSize: const Size(0, AppSpacing.buttonHeightMd),
          ),
          child: Text(
            'Try Again',
            style: AppTypography.labelMedium(color: AppColors.errorLight),
          ),
        );
    }
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;

  const _InfoChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.labelSmall(color: color),
      ),
    );
  }
}
