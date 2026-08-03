import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class TrendingGithubSection extends StatelessWidget {
  const TrendingGithubSection({super.key, required this.repos});

  final List<TrendingRepo> repos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Trending GitHub', trailing: 'See All'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 150,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: repos.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return RepoCard(repo: repos[index])
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

class RepoCard extends StatelessWidget {
  const RepoCard({super.key, required this.repo});

  final TrendingRepo repo;

  String _formatStars(int count) {
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
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: const Icon(Icons.code_rounded, size: 18),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repo.name,
                      style: AppTypography.titleSmall(
                        color: colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      repo.fullName,
                      style: AppTypography.bodySmall(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            repo.description,
            style: AppTypography.bodySmall(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: repo.languageColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                repo.language,
                style: AppTypography.labelSmall(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Icon(Icons.star_outline_rounded, size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                _formatStars(repo.stars),
                style: AppTypography.labelSmall(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.trending_up_rounded, size: 14, color: Colors.green),
              const SizedBox(width: 2),
              Text(
                '+${_formatStars(repo.periodStars)}',
                style: AppTypography.labelSmall(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
