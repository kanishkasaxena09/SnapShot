import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

final _quizSearchProvider = StateProvider<String>((ref) => '');
final _quizCategoryProvider = StateProvider<String>((ref) => 'All');

class QuizzesScreen extends ConsumerStatefulWidget {
  const QuizzesScreen({super.key});

  @override
  ConsumerState<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends ConsumerState<QuizzesScreen> {
  static const _categories = [
    'All',
    'Dart',
    'Algorithms',
    'System Design',
    'React',
    'Databases',
    'ML',
    'Data Structures',
    'Cloud',
    'DevOps',
    'Python',
    'Flutter',
    'JavaScript',
  ];

  Color _difficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.successLight;
      case DifficultyLevel.intermediate:
        return AppColors.warningLight;
      case DifficultyLevel.advanced:
        return Theme.of(context).colorScheme.error;
    }
  }

  List<LearningQuiz> _filterQuizzes(List<LearningQuiz> quizzes) {
    final query = ref.read(_quizSearchProvider);
    final category = ref.read(_quizCategoryProvider);
    var filtered = quizzes;
    if (query.isNotEmpty) {
      filtered = filtered
          .where((q) =>
              q.title.toLowerCase().contains(query.toLowerCase()) ||
              q.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (category != 'All') {
      filtered = filtered.where((q) => q.category == category).toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final allQuizzes = ref.watch(quizzesProvider);
    final filtered = _filterQuizzes(allQuizzes);
    final completedCount =
        allQuizzes.where((q) => q.isCompleted).length;
    final avgScore = allQuizzes
            .where((q) => q.bestScore != null)
            .fold<int>(0, (sum, q) => sum + q.bestScore!) /
        (allQuizzes.where((q) => q.bestScore != null).length | 0 == 0
            ? 1
            : allQuizzes.where((q) => q.bestScore != null).length);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Quizzes', style: AppTypography.headlineLarge()),
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
                ref.read(_quizSearchProvider.notifier).state = value;
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search quizzes...',
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
                    ref.watch(_quizCategoryProvider) == category;
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
                    ref.read(_quizCategoryProvider.notifier).state =
                        category;
                    setState(() {});
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
                _StatCard(
                  label: 'Total',
                  value: '${allQuizzes.length}',
                  icon: Icons.quiz_outlined,
                ),
                const SizedBox(width: AppSpacing.sm),
                _StatCard(
                  label: 'Completed',
                  value: '$completedCount',
                  icon: Icons.check_circle_outline_rounded,
                ),
                const SizedBox(width: AppSpacing.sm),
                _StatCard(
                  label: 'Avg Score',
                  value: avgScore.isNaN ? '0%' : '${avgScore.round()}%',
                  icon: Icons.leaderboard_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No quizzes found',
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
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final quiz = filtered[index];
                      final passed = quiz.bestScore != null &&
                          quiz.bestScore! >= quiz.passingScore;

                      return Container(
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
                        padding: AppSpacing.cardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quiz.title,
                              style: AppTypography.titleMedium(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              quiz.description,
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
                                  label: quiz.category,
                                  color: colorScheme.primary,
                                ),
                                _InfoChip(
                                  label: quiz.difficulty.name,
                                  color: _difficultyColor(quiz.difficulty),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  size: AppSpacing.iconSm,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  '${quiz.questionCount} Qs',
                                  style: AppTypography.labelSmall(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Icon(
                                  Icons.timer_outlined,
                                  size: AppSpacing.iconSm,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  '${quiz.timeLimitMinutes} min',
                                  style: AppTypography.labelSmall(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Icon(
                                  Icons.flag_outlined,
                                  size: AppSpacing.iconSm,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  '${quiz.passingScore}% pass',
                                  style: AppTypography.labelSmall(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const Spacer(),
                                ...List.generate(5, (i) {
                                  return Icon(
                                    Icons.star,
                                    size: AppSpacing.iconSm,
                                    color: i < quiz.rating.round()
                                        ? AppColors.accentYellow
                                        : colorScheme.onSurfaceVariant
                                            .withValues(alpha: 0.3),
                                  );
                                }),
                              ],
                            ),
                            if (quiz.isCompleted) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.sm,
                                      vertical: AppSpacing.xxs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: passed
                                          ? AppColors.successLight
                                              .withValues(alpha: 0.1)
                                          : colorScheme.error
                                              .withValues(alpha: 0.1),
                                      borderRadius:
                                          AppSpacing.borderRadiusFull,
                                    ),
                                    child: Text(
                                      'Best: ${quiz.bestScore}%',
                                      style: AppTypography.labelSmall(
                                        color: passed
                                            ? AppColors.successLight
                                            : colorScheme.error,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text(
                                    '${quiz.attemptCount} attempts',
                                    style: AppTypography.labelSmall(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: AppSpacing.md),
                            quiz.isCompleted
                                ? SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: colorScheme.primary,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              AppSpacing.borderRadiusMd,
                                        ),
                                        minimumSize: const Size(
                                          0,
                                          AppSpacing.buttonHeightMd,
                                        ),
                                      ),
                                      child: Text(
                                        'Retake',
                                        style:
                                            AppTypography.labelMedium(
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient:
                                            AppColors.primaryGradient,
                                        borderRadius:
                                            AppSpacing.borderRadiusMd,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.push(
                                            '/learning/quiz/${quiz.id}',
                                          );
                                        },
                                        style:
                                            ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.transparent,
                                          shadowColor:
                                              Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                AppSpacing
                                                    .borderRadiusMd,
                                          ),
                                          minimumSize: const Size(
                                            0,
                                            AppSpacing.buttonHeightMd,
                                          ),
                                        ),
                                        child: Text(
                                          'Start Quiz',
                                          style: AppTypography
                                              .labelMedium(
                                            color: AppColors
                                                .textInverseLight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: AppSpacing.borderRadiusSm,
        ),
        child: Row(
          children: [
            Icon(icon, size: AppSpacing.iconMd, color: colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: AppTypography.titleMedium(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    label,
                    style: AppTypography.labelSmall(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
