import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/project_entities.dart';
import '../providers/project_hub_providers.dart';
import '../widgets/project_widgets.dart';

class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({super.key, required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectDetailProvider(projectId));
    final colorScheme = Theme.of(context).colorScheme;

    if (project == null) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldLight,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceLight,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(child: Text('Project not found', style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight))),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: project.heroColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [project.heroColor, project.heroColor.withValues(alpha: 0.7)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'project_icon_${project.id}',
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: AppSpacing.borderRadiusLg,
                          ),
                          child: Icon(project.icon, color: Colors.white, size: 36),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(project.name, style: AppTypography.titleLarge(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags Row
                  Row(
                    children: [
                      DifficultyBadge(difficulty: project.difficulty),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withValues(alpha: 0.12),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(project.category.name, style: AppTypography.labelSmall(color: AppColors.primaryLight)),
                      ),
                      const Spacer(),
                      Text(project.estimatedTime, style: AppTypography.labelMedium(color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Description
                  Text('About', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(project.description, style: AppTypography.bodyMedium(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.lg),

                  // Stats Row
                  Row(
                    children: [
                      _StatItem(icon: Icons.star_rounded, value: project.rating.toString(), label: 'Rating', color: AppColors.accentYellow),
                      _StatItem(icon: Icons.people_outline, value: '${project.reviewCount}', label: 'Reviews', color: AppColors.accentBlue),
                      _StatItem(icon: Icons.check_circle_outline, value: '${project.completionRate}%', label: 'Completion', color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Portfolio Value
                  Text('Portfolio Value', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  const SizedBox(height: AppSpacing.sm),
                  PortfolioValueBar(value: project.portfolioValue),
                  const SizedBox(height: AppSpacing.lg),

                  // Technologies
                  Text('Technologies', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.map((t) => TechnologyChip(label: t)).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Tags
                  Text('Tags', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags.map((t) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Text('#$t', style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                    )).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Build Guide
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Build Guide', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withValues(alpha: 0.12),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text('${project.buildSteps.length} steps', style: AppTypography.labelSmall(color: AppColors.primaryLight)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...project.buildSteps.map((step) => _BuildStepCard(step: step, accentColor: project.heroColor)),
                  const SizedBox(height: AppSpacing.lg),

                  // Resources
                  Text('Resources', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  const SizedBox(height: AppSpacing.sm),
                  ...project.resources.map((r) => _ResourceTile(resource: r)),
                  const SizedBox(height: AppSpacing.lg),

                  // GitHub CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(project.githubLink);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.code, color: Colors.white),
                      label: Text('View on GitHub', style: AppTypography.labelLarge(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.icon, required this.value, required this.label, required this.color});
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(value, style: AppTypography.titleSmall(color: color)),
            Text(label, style: AppTypography.labelSmall(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _BuildStepCard extends StatelessWidget {
  const _BuildStepCard({required this.step, required this.accentColor});
  final BuildStep step;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
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
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Center(
              child: Text('${step.stepNumber}', style: AppTypography.labelMedium(color: accentColor)),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(step.title, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                    if (step.duration != null)
                      Text(step.duration!, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(step.description, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceTile extends StatelessWidget {
  const _ResourceTile({required this.resource});
  final ProjectResource resource;

  IconData _iconForType(ResourceType type) {
    switch (type) {
      case ResourceType.documentation: return Icons.menu_book;
      case ResourceType.tutorial: return Icons.school;
      case ResourceType.video: return Icons.play_circle_outline;
      case ResourceType.article: return Icons.article_outlined;
      case ResourceType.github: return Icons.code;
      case ResourceType.tool: return Icons.build_outlined;
    }
  }

  Color _colorForType(ResourceType type) {
    switch (type) {
      case ResourceType.documentation: return AppColors.accentBlue;
      case ResourceType.tutorial: return Colors.green;
      case ResourceType.video: return AppColors.accentPink;
      case ResourceType.article: return AppColors.accentOrange;
      case ResourceType.github: return Colors.grey.shade700;
      case ResourceType.tool: return AppColors.accentCyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = _colorForType(resource.type);

    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(resource.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(_iconForType(resource.type), color: color, size: 18),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resource.title, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                  Text(resource.type.name.toUpperCase(), style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: 16, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
