import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/explore_entities.dart';
import '../providers/explore_providers.dart';

class ExploreArticleCard extends ConsumerWidget {
  const ExploreArticleCard({
    super.key,
    required this.article,
    this.onTap,
  });

  final ExploreArticle article;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final bookmarkIds = ref.watch(exploreBookmarkIdsProvider);
    final isBookmarked = bookmarkIds.contains(article.id);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: article.category.color.withValues(alpha: 0.15),
                      borderRadius: AppSpacing.borderRadiusFull,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          article.category.icon,
                          size: 12,
                          color: article.category.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          article.category.label,
                          style: AppTypography.labelSmall(
                            color: article.category.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${article.readTime} min',
                    style: AppTypography.labelSmall(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: () => toggleBookmark(ref, article.id),
                    child: Icon(
                      isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 20,
                      color: isBookmarked
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                article.title,
                style: AppTypography.titleMedium(
                  color: colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                article.summary,
                style: AppTypography.bodySmall(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Text(
                    article.author,
                    style: AppTypography.labelSmall(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    ' \u00b7 ${article.source}',
                    style: AppTypography.labelSmall(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    article.publishedAt,
                    style: AppTypography.labelSmall(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreCategoryChip extends StatelessWidget {
  const ExploreCategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final ExploreCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            category.icon,
            size: 16,
            color: isSelected ? colorScheme.onPrimary : category.color,
          ),
          const SizedBox(width: 4),
          Text(category.label),
        ],
      ),
      onSelected: (_) => onTap(),
      selectedColor: category.color,
      backgroundColor: colorScheme.surfaceContainerHighest,
      side: BorderSide(
        color: isSelected
            ? category.color
            : colorScheme.outline.withValues(alpha: 0.3),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      checkmarkColor: colorScheme.onPrimary,
    );
  }
}
