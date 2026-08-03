import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/score_utils.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobCard extends StatelessWidget {

  const JobCard({super.key, required this.job, this.onTap, this.compact = false});
  final Job job;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap ?? () => context.push('/jobs/${job.id}'),
      child: Container(
        padding: compact ? AppSpacing.paddingSm : AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'job_logo_${job.id}',
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withValues(alpha: 0.1),
                      borderRadius: AppSpacing.borderRadiusSm,
                    ),
                    child: Center(
                      child: Text(
                        job.company.logo,
                        style: AppTypography.titleMedium(color: AppColors.primaryLight),
                      ),
                    ),
                  ),
                ),
                AppSpacing.hGapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title, style: AppTypography.titleSmall(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      AppSpacing.gapXxs,
                      Text(
                        '${job.company.name} • ${job.location}',
                        style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _buildSaveButton(context),
              ],
            ),
            AppSpacing.gapSm,
            Row(
              children: [
                _buildChip(context, job.typeLabel, job.typeIcon),
                AppSpacing.hGapSm,
                _buildChip(context, job.experienceLabel, Icons.work_outline_rounded),
                if (job.isRemote) ...[
                  AppSpacing.hGapSm,
                  _buildChip(context, 'Remote', Icons.language_rounded),
                ],
                const Spacer(),
                _buildMatchScore(context),
              ],
            ),
            if (!compact) ...[
              AppSpacing.gapSm,
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: job.skills.take(4).map((s) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: AppSpacing.borderRadiusXs,
                  ),
                  child: Text(s, style: AppTypography.labelSmall(color: colorScheme.primary)),
                )).toList(),
              ),
              AppSpacing.gapSm,
              Row(
                children: [
                  Icon(Icons.schedule_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  AppSpacing.hGapXs,
                  Text('${job.postedDate}', style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                  const Spacer(),
                  Text(
                    job.salaryRange,
                    style: AppTypography.labelMedium(color: AppColors.secondaryLight),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: AppSpacing.borderRadiusXs,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
          AppSpacing.hGapXxs,
          Text(label, style: AppTypography.labelSmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  Widget _buildMatchScore(BuildContext context) {
    final color = ScoreUtils.colorForScore(job.aiMatchScore);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 12, color: color),
          AppSpacing.hGapXxs,
          Text('${job.aiMatchScore}%', style: AppTypography.labelSmall(color: color)),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final saved = ref.watch(savedJobsProvider);
        final isSaved = saved.contains(job.id);
        final cs = Theme.of(context).colorScheme;
        return GestureDetector(
          onTap: () => ref.read(savedJobsProvider.notifier).toggle(job.id),
          child: Icon(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
            color: isSaved ? AppColors.primaryLight : cs.onSurface.withValues(alpha: 0.3),
            size: 22,
          ),
        );
      },
    );
  }
}
