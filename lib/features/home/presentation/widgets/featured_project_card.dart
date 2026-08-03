import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key, required this.projects});

  final List<FeaturedProject> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Featured Projects', trailing: 'See All', onSeeAll: () => GoRouter.of(context).push('/project-hub')),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 165,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: projects.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index])
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 100 * index),
                    duration: 400.ms,
                  )
                  .slideX(begin: 0.08);
            },
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final FeaturedProject project;

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 260,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: 'home_project_icon_${project.title}',
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: const Icon(Icons.folder_rounded, size: 18, color: Colors.white),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  project.title,
                  style: AppTypography.titleSmall(color: colorScheme.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            project.description,
            style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: project.techStack
                .take(3)
                .map(
                  (tech) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: AppSpacing.borderRadiusXs,
                    ),
                    child: Text(
                      tech,
                      style: AppTypography.labelSmall(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.star_outline_rounded, size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                _formatCount(project.stars),
                style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.fork_right_outlined, size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                _formatCount(project.forks),
                style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              Text(
                '@${project.author}',
                style: AppTypography.labelSmall(color: colorScheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
