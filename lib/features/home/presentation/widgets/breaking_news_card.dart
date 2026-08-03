import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class BreakingNewsSection extends StatelessWidget {
  const BreakingNewsSection({super.key, required this.articles});

  final List<NewsArticle> articles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Breaking News', trailing: 'See All'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return NewsCard(article: articles[index])
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

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article, this.isCompact = false});

  final NewsArticle article;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isCompact) {
      return _CompactNewsCard(article: article);
    }

    return Container(
      width: 280,
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
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusLg),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.article_outlined,
                size: 32,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (article.isBreaking)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: AppSpacing.borderRadiusXs,
                          ),
                          child: Text(
                            'BREAKING',
                            style: AppTypography.labelSmall(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      if (article.isBreaking) const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(
                          article.category,
                          style: AppTypography.labelSmall(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    article.title,
                    style: AppTypography.titleSmall(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        article.source,
                        style: AppTypography.labelSmall(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '· ${article.timeAgo}',
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
        ],
      ),
    );
  }
}

class _CompactNewsCard extends StatelessWidget {
  const _CompactNewsCard({required this.article});

  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(
              Icons.article_outlined,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: AppTypography.titleSmall(
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '${article.source} · ${article.timeAgo}',
                  style: AppTypography.bodySmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
