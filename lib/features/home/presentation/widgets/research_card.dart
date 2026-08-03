import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class ResearchSection extends StatelessWidget {
  const ResearchSection({super.key, required this.papers});

  final List<ResearchPaper> papers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Latest Research', trailing: 'See All'),
        const SizedBox(height: AppSpacing.sm),
        ...papers.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            child: ResearchCard(paper: entry.value)
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 100 * entry.key),
                  duration: 400.ms,
                )
                .slideY(begin: 0.05),
          );
        }).toList(),
      ],
    );
  }
}

class ResearchCard extends StatelessWidget {
  const ResearchCard({super.key, required this.paper});

  final ResearchPaper paper;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusMd,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: AppSpacing.borderRadiusXs,
                ),
                child: Text(
                  paper.category,
                  style: AppTypography.labelSmall(color: colorScheme.primary),
                ),
              ),
              const Spacer(),
              Icon(Icons.format_quote_rounded, size: 16, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                '${paper.citationCount} citations',
                style: AppTypography.labelSmall(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            paper.title,
            style: AppTypography.titleSmall(color: colorScheme.onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            paper.authors,
            style: AppTypography.bodySmall(
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            paper.abstract,
            style: AppTypography.bodySmall(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 12, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.xs),
              Text(
                paper.publishedDate,
                style: AppTypography.labelSmall(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_rounded, size: 16, color: colorScheme.primary),
            ],
          ),
        ],
      ),
    );
  }
}
