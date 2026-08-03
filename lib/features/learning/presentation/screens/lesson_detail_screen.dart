import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/learning_providers.dart';

class LessonDetailScreen extends ConsumerWidget {
  final String lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  static const _moduleNames = [
    'Introduction',
    'Core Concepts',
    'Hands-on Practice',
    'Advanced Topics',
    'Real-world Examples',
    'Best Practices',
    'Common Pitfalls',
    'Final Project',
    'Review & Quiz',
    'Next Steps',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson = ref.watch(lessonDetailProvider(lessonId));
    final savedIds = ref.watch(savedLessonsProvider);
    final isBookmarked = savedIds.contains(lessonId);

    if (lesson == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text('Lesson', style: AppTypography.headlineLarge()),
        ),
        body: Center(
          child: Text(
            'Lesson not found',
            style: AppTypography.bodyMedium(
              color: AppColors.textTertiaryLight,
            ),
          ),
        ),
      );
    }

    final thumbnailColor = Color(
      int.parse(lesson.thumbnailColor.replaceFirst('#', '0xFF')),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          lesson.title,
          style: AppTypography.titleLarge(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(savedLessonsProvider.notifier).toggle(lesson.id);
            },
            icon: Icon(
              isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              color: isBookmarked ? AppColors.primaryLight : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: AppSpacing.paddingXl,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    thumbnailColor,
                    thumbnailColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: AppTypography.headlineMedium(
                      color: AppColors.textInverseLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    lesson.author,
                    style: AppTypography.bodyMedium(
                      color: AppColors.textInverseLight.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: AppSpacing.iconMd,
                        color: AppColors.accentYellow,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        lesson.rating.toStringAsFixed(1),
                        style: AppTypography.labelLarge(
                          color: AppColors.textInverseLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      const Icon(
                        Icons.people_outline_rounded,
                        size: AppSpacing.iconMd,
                        color: AppColors.textInverseLight,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '${lesson.enrolledCount} enrolled',
                        style: AppTypography.labelLarge(
                          color: AppColors.textInverseLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _InfoChip(
                  icon: Icons.access_time_rounded,
                  label: '${lesson.durationMinutes} min',
                ),
                _InfoChip(
                  icon: Icons.library_books_outlined,
                  label: '${lesson.totalModules} modules',
                ),
                _InfoChip(
                  icon: Icons.signal_cellular_alt_rounded,
                  label: lesson.difficulty.name.toUpperCase(),
                ),
                _InfoChip(
                  icon: Icons.category_outlined,
                  label: lesson.category,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Description',
              style: AppTypography.titleLarge(
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              lesson.description,
              style: AppTypography.bodyMedium(
                color: AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Modules',
              style: AppTypography.titleLarge(
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...List.generate(lesson.totalModules, (index) {
              final isCompleted = index < lesson.completedModules;
              final moduleName = index < _moduleNames.length
                  ? _moduleNames[index]
                  : 'Module ${index + 1}';

              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: AppSpacing.paddingMd,
                decoration: BoxDecoration(
                  color: AppColors.cardLight,
                  borderRadius: AppSpacing.borderRadiusSm,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.successLight.withOpacity(0.1)
                            : AppColors.surfaceVariantLight,
                        borderRadius: AppSpacing.borderRadiusFull,
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check_rounded
                            : Icons.circle_outlined,
                        size: 16,
                        color: isCompleted
                            ? AppColors.successLight
                            : AppColors.textTertiaryLight,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        moduleName,
                        style: AppTypography.bodyMedium(
                          color: isCompleted
                              ? AppColors.textSecondaryLight
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    Text(
                      '${index + 1}/${lesson.totalModules}',
                      style: AppTypography.labelSmall(
                        color: AppColors.textTertiaryLight,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: AppSpacing.xl),
            if (lesson.tags.isNotEmpty) ...[
              Text(
                'Tags',
                style: AppTypography.titleLarge(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: lesson.tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariantLight,
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          tag,
                          style: AppTypography.labelMedium(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.base,
          0,
          AppSpacing.base,
          AppSpacing.xxl,
        ),
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
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeightLg,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                ),
                child: Text(
                  lesson.completedModules > 0
                      ? 'Continue Learning'
                      : 'Start Lesson',
                  style: AppTypography.labelLarge(
                    color: AppColors.textInverseLight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariantLight,
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSpacing.iconSm, color: AppColors.textSecondaryLight),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
