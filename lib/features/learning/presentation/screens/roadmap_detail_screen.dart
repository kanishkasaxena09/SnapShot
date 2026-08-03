import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

class RoadmapDetailScreen extends ConsumerWidget {
  final String roadmapId;

  const RoadmapDetailScreen({super.key, required this.roadmapId});

  Color _difficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.successLight;
      case DifficultyLevel.intermediate:
        return AppColors.accentOrange;
      case DifficultyLevel.advanced:
        return AppColors.errorLight;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roadmap = ref.watch(roadmapDetailProvider(roadmapId));

    if (roadmap == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Roadmap',
              style: AppTypography.headlineMedium(
                  color: AppColors.textPrimaryLight)),
        ),
        body: Center(
          child: Text('Roadmap not found',
              style: AppTypography.bodyMedium(
                  color: AppColors.textTertiaryLight)),
        ),
      );
    }

    final currentStep =
        roadmap.steps.where((s) => s.isCurrent).firstOrNull;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(roadmap.title,
            style: AppTypography.headlineMedium(
                color: AppColors.textPrimaryLight)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.paddingLg,
                    decoration: BoxDecoration(
                      color: roadmap.color.withOpacity(0.08),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color:
                                    roadmap.color.withOpacity(0.15),
                                borderRadius:
                                    AppSpacing.borderRadiusMd,
                              ),
                              child: Icon(roadmap.icon,
                                  color: roadmap.color, size: 28),
                            ),
                            AppSpacing.hGapMd,
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(roadmap.title,
                                      style: AppTypography.titleLarge(
                                          color: AppColors
                                              .textPrimaryLight)),
                                  const SizedBox(
                                      height: AppSpacing.xs),
                                  Text(roadmap.description,
                                      style: AppTypography.bodySmall(
                                          color: AppColors
                                              .textSecondaryLight)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xxs),
                              decoration: BoxDecoration(
                                color: _difficultyColor(
                                        roadmap.difficulty)
                                    .withOpacity(0.1),
                                borderRadius:
                                    AppSpacing.borderRadiusFull,
                              ),
                              child: Text(
                                roadmap.difficulty.name
                                    .toUpperCase(),
                                style: AppTypography.labelSmall(
                                    color: _difficultyColor(
                                        roadmap.difficulty)),
                              ),
                            ),
                            AppSpacing.hGapMd,
                            Icon(Icons.schedule_outlined,
                                size: 14,
                                color:
                                    AppColors.textTertiaryLight),
                            Text(' ${roadmap.estimatedTime}',
                                style: AppTypography.labelSmall(
                                    color: AppColors
                                        .textTertiaryLight)),
                            const Spacer(),
                            Text(
                                '${roadmap.completedSteps}/${roadmap.totalSteps}',
                                style: AppTypography.labelMedium(
                                    color: AppColors
                                        .primaryLight)),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              AppSpacing.radiusFull),
                          child: LinearProgressIndicator(
                            value: roadmap.progress,
                            backgroundColor:
                                AppColors.primaryContainerLight,
                            valueColor:
                                const AlwaysStoppedAnimation(
                                    AppColors.primaryLight),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text('Steps',
                      style: AppTypography.titleLarge(
                          color: AppColors.textPrimaryLight)),
                  const SizedBox(height: AppSpacing.md),
                  ...roadmap.steps.asMap().entries.map(
                        (entry) {
                          final stepIndex = entry.key;
                          final step = entry.value;
                          final isLast =
                              stepIndex == roadmap.steps.length - 1;
                          return _StepItem(
                            step: step,
                            isLast: isLast,
                          );
                        },
                      ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
          if (currentStep != null)
            Container(
              padding: AppSpacing.screenPadding,
              decoration: const BoxDecoration(
                color: AppColors.surfaceLight,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(
                      '/learning/lesson/${currentStep.lessonId ?? currentStep.id}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: AppColors.textInverseLight,
                    padding:
                        AppSpacing.paddingVerticalMd,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSpacing.borderRadiusSm,
                    ),
                  ),
                  child: Text(
                    currentStep.isCompleted
                        ? 'Review Step'
                        : 'Continue Learning',
                    style: AppTypography.labelLarge(
                        color: AppColors.textInverseLight),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final RoadmapStep step;
  final bool isLast;

  const _StepItem({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.isCompleted
                        ? AppColors.successLight
                        : step.isCurrent
                            ? AppColors.primaryLight
                            : AppColors.surfaceVariantLight,
                    border: step.isCurrent
                        ? Border.all(
                            color: AppColors.primaryLight,
                            width: 2)
                        : null,
                  ),
                  child: Center(
                    child: step.isCompleted
                        ? const Icon(Icons.check,
                            size: 16,
                            color: AppColors.textInverseLight)
                        : step.isCurrent
                            ? const Icon(Icons.play_arrow,
                                size: 16,
                                color:
                                    AppColors.textInverseLight)
                            : Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.textTertiaryLight,
                                ),
                              ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 4),
                      color: step.isCompleted
                          ? AppColors.successLight
                              .withOpacity(0.4)
                          : AppColors.borderLight,
                    ),
                  ),
              ],
            ),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                  bottom: AppSpacing.md),
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                color: step.isCurrent
                    ? AppColors.primaryContainerLight
                        .withOpacity(0.3)
                    : AppColors.cardLight,
                borderRadius: AppSpacing.borderRadiusMd,
                border: step.isCurrent
                    ? Border.all(
                        color: AppColors.primaryLight
                            .withOpacity(0.3))
                    : null,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(step.title,
                      style: AppTypography.titleSmall(
                          color:
                              AppColors.textPrimaryLight)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(step.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall(
                          color:
                              AppColors.textSecondaryLight)),
                  if (step.isCurrent &&
                      step.lessonId != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => context.push(
                            '/learning/lesson/${step.lessonId}'),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal:
                                      AppSpacing.md,
                                  vertical:
                                      AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius:
                                AppSpacing.borderRadiusSm,
                          ),
                          child: Text(
                            step.isCompleted
                                ? 'Review'
                                : 'Continue',
                            style: AppTypography.labelMedium(
                                color: AppColors
                                    .textInverseLight),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
