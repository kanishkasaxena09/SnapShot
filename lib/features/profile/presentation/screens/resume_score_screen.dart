import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class ResumeScoreScreen extends ConsumerWidget {
  const ResumeScoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(resumeScoreProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Resume Score', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Score
            Center(
              child: SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: score.overallScore / 100,
                      strokeWidth: 10,
                      backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation(
                        score.overallScore >= 80 ? Colors.green : score.overallScore >= 60 ? AppColors.accentOrange : AppColors.accentPink,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${score.overallScore}', style: AppTypography.displaySmall(color: colorScheme.onSurface)),
                          Text('Overall', style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Score Breakdown
            Text('Score Breakdown', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            ...score.sectionScores.map((section) => Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(section.name, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: AppSpacing.borderRadiusXs,
                          child: LinearProgressIndicator(
                            value: section.score / 100,
                            minHeight: 8,
                            backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                            valueColor: AlwaysStoppedAnimation(section.color),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text('${section.score}', style: AppTypography.titleMedium(color: section.color)),
                ],
              ),
            )),
            const SizedBox(height: AppSpacing.lg),

            // Category Scores
            Text('Detailed Scores', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _ScoreChip(label: 'ATS', score: score.atsScore, color: AppColors.accentBlue),
                _ScoreChip(label: 'Readability', score: score.readabilityScore, color: AppColors.accentCyan),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _ScoreChip(label: 'Keywords', score: score.keywordScore, color: AppColors.accentOrange),
                _ScoreChip(label: 'Format', score: score.formatScore, color: AppColors.accentPink),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Suggestions
            Text('Suggestions', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            ...score.suggestions.asMap().entries.map((entry) => Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: AppSpacing.borderRadiusSm,
                    ),
                    child: Center(
                      child: Text('${entry.key + 1}', style: AppTypography.labelSmall(color: colorScheme.primary)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(entry.value, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  const _ScoreChip({required this.label, required this.score, required this.color});
  final String label;
  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text('$score', style: AppTypography.titleLarge(color: color)),
            Text(label, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
