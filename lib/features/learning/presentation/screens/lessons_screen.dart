import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

class LessonsScreen extends ConsumerStatefulWidget {
  const LessonsScreen({super.key});

  @override
  ConsumerState<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends ConsumerState<LessonsScreen> {
  String _selectedSort = 'Popular';

  static const _categories = [
    'All',
    'Frontend',
    'Mobile',
    'AI',
    'Backend',
    'DevOps',
    'System Design',
  ];

  static const _sortOptions = [
    'Popular',
    'Rating',
    'Duration',
    'Newest',
  ];

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

  List<LearningLesson> _sortLessons(List<LearningLesson> lessons) {
    final sorted = List<LearningLesson>.from(lessons);
    switch (_selectedSort) {
      case 'Popular':
        sorted.sort((a, b) => b.enrolledCount.compareTo(a.enrolledCount));
      case 'Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
      case 'Duration':
        sorted.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
      case 'Newest':
        sorted.sort((a, b) => b.id.compareTo(a.id));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lessons = ref.watch(lessonsProvider);
    final sortedLessons = _sortLessons(lessons);
    final savedIds = ref.watch(savedLessonsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Lessons', style: AppTypography.headlineLarge()),
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
            child: TextField(
              onChanged: (value) {
                ref.read(learningSearchQueryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                hintText: 'Search lessons...',
                hintStyle: AppTypography.bodyMedium(
                  color: colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: AppSpacing.chipHeightLg,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
              ),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => AppSpacing.hGapSm,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected =
                    ref.watch(learningCategoryFilterProvider) == category;
                return FilterChip(
                  label: Text(
                    category,
                    style: AppTypography.labelMedium(
                      color: isSelected
                          ? AppColors.textInverseLight
                          : colorScheme.onSurface,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: colorScheme.primary,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  checkmarkColor: AppColors.textInverseLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusFull,
                    side: BorderSide(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outlineVariant,
                    ),
                  ),
                  onSelected: (_) {
                    ref.read(learningCategoryFilterProvider.notifier).state =
                        category;
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base,
              AppSpacing.md,
              AppSpacing.base,
              0,
            ),
            child: Row(
              children: [
                Text(
                  '${sortedLessons.length} lessons found',
                  style: AppTypography.bodyMedium(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: _selectedSort,
                  underline: const SizedBox.shrink(),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  style: AppTypography.labelMedium(
                    color: colorScheme.onSurface,
                  ),
                  items: _sortOptions
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedSort = value);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: sortedLessons.isEmpty
                ? Center(
                    child: Text(
                      'No lessons found',
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
                    itemCount: sortedLessons.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final lesson = sortedLessons[index];
                      final isBookmarked = savedIds.contains(lesson.id);
                      final thumbnailColor = Color(
                        int.parse(
                              lesson.thumbnailColor.replaceFirst('#', '0xFF'),
                            ),
                      );

                      return GestureDetector(
                        onTap: () => context.push(
                          '/learning/lesson/${lesson.id}',
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadowLight,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 6,
                                width: double.infinity,
                                color: thumbnailColor,
                              ),
                              Padding(
                                padding: AppSpacing.cardPadding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lesson.title,
                                            style: AppTypography.titleMedium(
                                              color:
                                                  colorScheme.onSurface,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(savedLessonsProvider
                                                    .notifier)
                                                .toggle(lesson.id);
                                          },
                                          icon: Icon(
                                            isBookmarked
                                                ? Icons.bookmark_rounded
                                                : Icons.bookmark_outline_rounded,
                                            color: isBookmarked
                                                ? colorScheme.primary
                                                : colorScheme.onSurfaceVariant,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          splashRadius: 20,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      lesson.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.bodySmall(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Row(
                                      children: [
                                        _CategoryChip(
                                          label: lesson.category,
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        _DifficultyChip(
                                          label: lesson.difficulty.name,
                                          color: _difficultyColor(
                                            lesson.difficulty,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: AppSpacing.iconSm,
                                          color:
                                              colorScheme.onSurfaceVariant,
                                        ),
                                        const SizedBox(width: AppSpacing.xs),
                                        Text(
                                          '${lesson.durationMinutes} min',
                                          style: AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.md,
                                        ),
                                        const Icon(
                                          Icons.star_rounded,
                                          size: AppSpacing.iconSm,
                                          color: AppColors.accentYellow,
                                        ),
                                        const SizedBox(width: AppSpacing.xs),
                                        Text(
                                          lesson.rating.toStringAsFixed(1),
                                          style: AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.md,
                                        ),
                                        Icon(
                                          Icons.people_outline_rounded,
                                          size: AppSpacing.iconSm,
                                          color:
                                              colorScheme.onSurfaceVariant,
                                        ),
                                        const SizedBox(width: AppSpacing.xs),
                                        Text(
                                          '${lesson.enrolledCount}',
                                          style: AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (lesson.completedModules > 0) ...[
                                      const SizedBox(height: AppSpacing.sm),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          AppSpacing.radiusFull,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: lesson.progress,
                                          backgroundColor:
                                              colorScheme.primaryContainer,
                                          valueColor:
                                              AlwaysStoppedAnimation(
                                                colorScheme.primary,
                                              ),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall(color: colorScheme.primary),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  final String label;
  final Color color;

  const _DifficultyChip({required this.label, required this.color});

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
