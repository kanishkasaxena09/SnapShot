import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/ai_tools_entities.dart';
import 'pricing_badge.dart';

class ToolCard extends StatelessWidget {

  const ToolCard({
    super.key,
    required this.tool,
    this.onTap,
    this.onBookmark,
    this.isBookmarked = false,
    this.onCompare,
    this.isCompared = false,
    this.compact = false,
  });
  final AiTool tool;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final bool isBookmarked;
  final VoidCallback? onCompare;
  final bool isCompared;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconSize = compact ? 20.0 : 24.0;
    final avatarRadius = compact ? 20.0 : 24.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 2,
              decoration: BoxDecoration(color: tool.color),
            ),
            Padding(
              padding: compact
                  ? const EdgeInsets.all(AppSpacing.sm)
                  : AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                    children: [
                      Hero(
                        tag: 'tool_icon_${tool.id}',
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: tool.color.withOpacity(0.15),
                          child: Icon(tool.icon, color: tool.color, size: iconSize),
                        ),
                      ),
                      const Spacer(),
                      if (tool.isTrending)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accentOrange.withOpacity(0.1),
                            borderRadius: AppSpacing.borderRadiusXs,
                          ),
                          child: Text(
                            'Trending',
                            style: AppTypography.labelSmall(color: AppColors.accentOrange),
                          ),
                        ),
                      if (tool.isTrending && tool.isNew) AppSpacing.hGapXs,
                      if (tool.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.successLight.withOpacity(0.1),
                            borderRadius: AppSpacing.borderRadiusXs,
                          ),
                          child: Text(
                            'New',
                            style: AppTypography.labelSmall(color: AppColors.successLight),
                          ),
                        ),
                    ],
                  ),
                  AppSpacing.gapSm,
                  Text(
                    tool.name,
                    style: AppTypography.titleSmall(color: colorScheme.onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.gapXxs,
                  Text(
                    tool.company,
                    style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.gapSm,
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: AppColors.accentYellow),
                      AppSpacing.hGapXs,
                      Text(
                        tool.rating.toStringAsFixed(1),
                        style: AppTypography.labelMedium(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      AppSpacing.hGapXs,
                      Text(
                        '(${tool.reviewCount})',
                        style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  AppSpacing.gapSm,
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: tool.color.withOpacity(0.1),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(
                          _categoryLabel(tool.category),
                          style: AppTypography.labelSmall(color: tool.color),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PricingBadge(tier: tool.pricing),
                    ],
                  ),
                  if (!compact) ...[
                    AppSpacing.gapSm,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onBookmark,
                          child: Icon(
                            isBookmarked ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: isBookmarked
                                ? AppColors.tertiaryLight
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        if (onCompare != null)
                          GestureDetector(
                            onTap: onCompare,
                            child: Icon(
                              isCompared ? Icons.compare_arrows : Icons.compare_arrows_outlined,
                              size: 20,
                              color: isCompared
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(AiToolCategory cat) {
    switch (cat) {
      case AiToolCategory.llm:
        return 'LLM';
      case AiToolCategory.imageGeneration:
        return 'Image Gen';
      case AiToolCategory.codeAssist:
        return 'Code';
      case AiToolCategory.productivity:
        return 'Productivity';
      case AiToolCategory.video:
        return 'Video';
      case AiToolCategory.audio:
        return 'Audio';
      case AiToolCategory.design:
        return 'Design';
      case AiToolCategory.dataScience:
        return 'Data Science';
      case AiToolCategory.writing:
        return 'Writing';
      case AiToolCategory.automation:
        return 'Automation';
      case AiToolCategory.research:
        return 'Research';
      case AiToolCategory.translation:
        return 'Translation';
    }
  }
}
