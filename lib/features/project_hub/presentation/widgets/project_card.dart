import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/project_entities.dart';
import 'project_widgets.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push('/project-hub/${project.id}'),
      child: Container(
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
                Hero(
                  tag: 'project_icon_${project.id}',
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: project.heroColor.withValues(alpha: 0.12),
                      borderRadius: AppSpacing.borderRadiusMd,
                    ),
                    child: Icon(project.icon, color: project.heroColor, size: 24),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.name, style: AppTypography.titleSmall(color: colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(project.estimatedTime, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                DifficultyBadge(difficulty: project.difficulty),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(project.shortDescription, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: project.technologies.take(4).map((t) => TechnologyChip(label: t)).toList(),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.star_rounded, size: 14, color: AppColors.accentYellow),
                const SizedBox(width: 2),
                Text(project.rating.toString(), style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.access_time, size: 12, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 3),
                Text(project.estimatedTime, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                const Spacer(),
                if (project.isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: AppSpacing.borderRadiusXs,
                    ),
                    child: Text('NEW', style: AppTypography.labelSmall(color: Colors.green)),
                  ),
                if (project.isFeatured && !project.isNew)
                  Icon(Icons.star, size: 14, color: AppColors.accentYellow),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectHorizontalCard extends StatelessWidget {
  const ProjectHorizontalCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push('/project-hub/${project.id}'),
      child: Container(
        width: 240,
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
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: project.heroColor.withValues(alpha: 0.12),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Icon(project.icon, color: project.heroColor, size: 20),
                ),
                const Spacer(),
                DifficultyBadge(difficulty: project.difficulty),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(project.name, style: AppTypography.titleSmall(color: colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(project.shortDescription, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant), maxLines: 2, overflow: TextOverflow.ellipsis),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.star_rounded, size: 14, color: AppColors.accentYellow),
                const SizedBox(width: 2),
                Text(project.rating.toString(), style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                const Spacer(),
                Icon(Icons.access_time, size: 12, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 3),
                Text(project.estimatedTime, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
