import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class TrendingAiToolsSection extends StatelessWidget {
  const TrendingAiToolsSection({super.key, required this.tools});

  final List<AiTool> tools;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Trending AI Tools', trailing: 'See All', onSeeAll: () => GoRouter.of(context).push('/ai-tools')),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 150,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: tools.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return AiToolCard(tool: tools[index])
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

class AiToolCard extends StatelessWidget {
  const AiToolCard({super.key, required this.tool});

  final AiTool tool;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.sm),
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
                tag: 'home_ai_tool_icon_${tool.name}',
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: tool.color.withValues(alpha: 0.12),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Icon(tool.icon, color: tool.color, size: 18),
                ),
              ),
              const Spacer(),
              if (tool.isNew)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusXs,
                  ),
                  child: Text(
                    'NEW',
                    style: AppTypography.labelSmall(color: Colors.green),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            tool.name,
            style: AppTypography.titleSmall(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            tool.description,
            style: AppTypography.bodySmall(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.star_rounded, size: 14, color: AppColors.accentYellow),
              const SizedBox(width: 2),
              Text(
                tool.rating.toString(),
                style: AppTypography.labelSmall(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: AppSpacing.borderRadiusXs,
                ),
                child: Text(
                  tool.category,
                  style: AppTypography.labelSmall(
                    color: colorScheme.onSurfaceVariant,
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
