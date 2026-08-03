import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/learning_providers.dart';

class QuizDetailScreen extends ConsumerWidget {
  final String quizId;

  const QuizDetailScreen({super.key, required this.quizId});

  static const _mockQuestions = [
    {
      'question':
          'What is the primary purpose of the "const" keyword in Dart?',
      'options': [
        'To declare a mutable variable',
        'To declare a compile-time constant',
        'To create a new instance',
        'To define a loop',
      ],
    },
    {
      'question':
          'Which widget is used for layout in Flutter that arranges children in a horizontal or vertical array?',
      'options': [
        'Container',
        'Stack',
        'Row / Column',
        'Text',
      ],
    },
    {
      'question':
          'What does "hot reload" do in Flutter development?',
      'options': [
        'Restarts the entire application',
        'Injects updated code into the running Dart VM',
        'Recompiles the native code',
        'Resets the device emulator',
      ],
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizDetailProvider(quizId));

    if (quiz == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text('Quiz', style: AppTypography.headlineLarge()),
        ),
        body: Center(
          child: Text(
            'Quiz not found',
            style: AppTypography.bodyMedium(
              color: AppColors.textTertiaryLight,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          quiz.title,
          style: AppTypography.titleLarge(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
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
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.title,
                    style: AppTypography.headlineMedium(
                      color: AppColors.textInverseLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    quiz.description,
                    style: AppTypography.bodyMedium(
                      color: AppColors.textInverseLight.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      _InfoChip(
                        label: quiz.category,
                        color: AppColors.textInverseLight,
                      ),
                      _InfoChip(
                        label: quiz.difficulty.name.toUpperCase(),
                        color: AppColors.accentYellow,
                      ),
                      _InfoChip(
                        label: '${quiz.questionCount} Questions',
                        color: AppColors.textInverseLight,
                      ),
                      _InfoChip(
                        label: '${quiz.timeLimitMinutes} min',
                        color: AppColors.textInverseLight,
                      ),
                      _InfoChip(
                        label: '${quiz.passingScore}% to pass',
                        color: AppColors.textInverseLight,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          Icons.star,
                          size: AppSpacing.iconMd,
                          color: i < quiz.rating.round()
                              ? AppColors.accentYellow
                              : AppColors.textInverseLight.withOpacity(0.3),
                        );
                      }),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        quiz.rating.toStringAsFixed(1),
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
            Text(
              'Quiz Instructions',
              style: AppTypography.titleLarge(
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _InstructionItem(
              text: 'Answer all ${quiz.questionCount} questions',
            ),
            _InstructionItem(
              text: 'Time limit: ${quiz.timeLimitMinutes} minutes',
            ),
            _InstructionItem(
              text: 'Passing score: ${quiz.passingScore}%',
            ),
            const _InstructionItem(
              text: 'You can retake the quiz',
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Sample Questions',
              style: AppTypography.titleLarge(
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...List.generate(_mockQuestions.length, (index) {
              final q = _mockQuestions[index];
              final options = q['options'] as List<String>;
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: AppSpacing.cardPadding,
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
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainerLight,
                            borderRadius: AppSpacing.borderRadiusFull,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: AppTypography.labelMedium(
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            q['question'] as String,
                            style: AppTypography.bodyMedium(
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...List.generate(options.length, (optIndex) {
                      final letter = String.fromCharCode(65 + optIndex);
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.sm,
                        ),
                        child: OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            disabledForegroundColor:
                                AppColors.textSecondaryLight,
                            side: const BorderSide(
                              color: AppColors.borderLight,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppSpacing.borderRadiusMd,
                            ),
                            minimumSize: const Size(
                              0,
                              AppSpacing.buttonHeightMd,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$letter. ${options[optIndex]}',
                              style: AppTypography.bodyMedium(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
            const SizedBox(height: AppSpacing.xxl),
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
                  'Start Quiz',
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
        color: color.withOpacity(0.15),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall(color: color),
      ),
    );
  }
}

class _InstructionItem extends StatelessWidget {
  final String text;

  const _InstructionItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: AppSpacing.iconSm,
            color: AppColors.primaryLight,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium(
                color: AppColors.textSecondaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
