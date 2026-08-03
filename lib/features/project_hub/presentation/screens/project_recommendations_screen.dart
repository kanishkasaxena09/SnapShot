import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/score_utils.dart';
import '../../domain/entities/project_entities.dart';
import '../providers/project_hub_providers.dart';
import '../widgets/project_widgets.dart';

class ProjectRecommendationsScreen extends ConsumerWidget {
  const ProjectRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendations = ref.watch(projectRecommendationsProvider);
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
        title: Text('Recommended Projects', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.md, AppSpacing.base, AppSpacing.md),
              child: Container(
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.8)],
                  ),
                  borderRadius: AppSpacing.borderRadiusLg,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Personalized for You', style: AppTypography.titleMedium(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('Based on your skills: Flutter, React, Node.js, Python, JavaScript',
                              style: AppTypography.bodySmall(color: Colors.white.withValues(alpha: 0.9))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (recommendations.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Column(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 64, color: colorScheme.outlineVariant),
                    const SizedBox(height: AppSpacing.md),
                    Text('No recommendations yet', style: AppTypography.titleMedium(color: AppColors.textSecondaryLight)),
                    const SizedBox(height: AppSpacing.xs),
                    Text('Update your skills to get personalized suggestions', style: AppTypography.bodySmall(color: AppColors.textSecondaryLight)),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _RecommendationCard(recommendation: recommendations[i]),
                  childCount: recommendations.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.recommendation});
  final ProjectRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final project = recommendation.project;
    final matchColor = ScoreUtils.colorForScore(recommendation.matchScore.toDouble());
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push('/project-hub/${project.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: project.heroColor.withValues(alpha: 0.12),
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Icon(project.icon, color: project.heroColor, size: 24),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.name, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                      Text(project.estimatedTime, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                // Match Score
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: matchColor.withValues(alpha: 0.12),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Column(
                    children: [
                      Text('${recommendation.matchScore}%', style: AppTypography.labelMedium(color: matchColor)),
                      Text('Match', style: AppTypography.labelSmall(color: matchColor)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(project.shortDescription, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: project.technologies.map((t) => TechnologyChip(label: t)).toList(),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...recommendation.reasons.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 14, color: matchColor),
                  const SizedBox(width: 6),
                  Expanded(child: Text(r, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant))),
                ],
              ),
            )),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                DifficultyBadge(difficulty: project.difficulty),
                const Spacer(),
                Text('Portfolio: ${project.portfolioValue}/100', style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.star_rounded, size: 14, color: AppColors.accentYellow),
                Text(project.rating.toString(), style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
