import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class RecommendedJobsSection extends StatelessWidget {
  const RecommendedJobsSection({super.key, required this.jobs});

  final List<JobListing> jobs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Recommended Jobs', trailing: 'See All'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 170,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: jobs.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return JobCard(job: jobs[index])
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

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job});

  final JobListing job;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: job.isFeatured
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: 'home_job_logo_${job.title}',
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Center(
                    child: Text(
                      job.company[0],
                      style: AppTypography.titleMedium(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.company,
                      style: AppTypography.titleSmall(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      job.postedAgo,
                      style: AppTypography.bodySmall(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (job.isFeatured)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentOrange.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusXs,
                  ),
                  child: Text(
                    'Featured',
                    style: AppTypography.labelSmall(
                      color: AppColors.accentOrange,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            job.title,
            style: AppTypography.titleMedium(
              color: colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                job.location,
                style: AppTypography.bodySmall(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (job.isRemote) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusXs,
                  ),
                  child: Text(
                    'Remote',
                    style: AppTypography.labelSmall(
                      color: AppColors.secondaryLight,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                job.salary,
                style: AppTypography.labelMedium(
                  color: AppColors.successLight,
                ),
              ),
              const Spacer(),
              ...job.tags.take(2).map(
                    (tag) => Container(
                      margin: const EdgeInsets.only(left: AppSpacing.xs),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: AppSpacing.borderRadiusXs,
                      ),
                      child: Text(
                        tag,
                        style: AppTypography.labelSmall(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
