import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/explore_entities.dart';
import '../providers/explore_providers.dart';

class ExploreArticleDetailScreen extends ConsumerStatefulWidget {
  const ExploreArticleDetailScreen({
    super.key,
    required this.articleId,
  });

  final String articleId;

  @override
  ConsumerState<ExploreArticleDetailScreen> createState() =>
      _ExploreArticleDetailScreenState();
}

class _ExploreArticleDetailScreenState
    extends ConsumerState<ExploreArticleDetailScreen> {
  final _scrollController = ScrollController();
  ExploreArticle? _article;

  @override
  void initState() {
    super.initState();
    final articles =
        ref.read(exploreDataSourceProvider).getAllArticles();
    final matches =
        articles.where((a) => a.id == widget.articleId).toList();
    if (matches.isNotEmpty) _article = matches.first;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _article == null) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll <= 0) return;
    final progress =
        (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
    updateReadingProgress(ref, _article!.id, progress);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final article = _article;
    final bookmarkIds = ref.watch(exploreBookmarkIdsProvider);
    final readingProgressMap = ref.watch(exploreReadingProgressProvider);

    if (article == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Article not found')),
      );
    }

    final isBookmarked = bookmarkIds.contains(article.id);
    final progress = readingProgressMap[article.id] ?? 0.0;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      article.category.color,
                      article.category.color.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    article.category.icon,
                    size: 64,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                ),
                onPressed: () => toggleBookmark(ref, article.id),
              ),
              IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: () => _shareArticle(article),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: article.category.color.withValues(alpha: 0.15),
                      borderRadius: AppSpacing.borderRadiusFull,
                    ),
                    child: Text(
                      article.category.label,
                      style: AppTypography.labelSmall(
                        color: article.category.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    article.title,
                    style: AppTypography.headlineMedium(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            article.category.color.withValues(alpha: 0.2),
                        child: Text(
                          article.author[0],
                          style: AppTypography.labelMedium(
                            color: article.category.color,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.author,
                              style: AppTypography.labelMedium(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              '${article.source} \u00b7 ${article.readTime} min read \u00b7 ${article.publishedAt}',
                              style: AppTypography.bodySmall(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  if (article.tags.isNotEmpty)
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: article.tags
                          .map(
                            (tag) => Chip(
                              label: Text(
                                tag,
                                style: AppTypography.labelSmall(),
                              ),
                              backgroundColor:
                                  colorScheme.surfaceContainerHighest,
                              side: BorderSide.none,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                    ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    article.content,
                    style: AppTypography.bodyLarge(
                      color: colorScheme.onSurface,
                    ).copyWith(height: 1.8),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: progress > 0 && progress < 1
          ? LinearProgressIndicator(
              value: progress,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(article.category.color),
            )
          : null,
    );
  }

  void _shareArticle(ExploreArticle article) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shared: ${article.title}')),
    );
  }
}
