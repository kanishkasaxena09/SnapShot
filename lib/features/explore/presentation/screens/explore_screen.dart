import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/entities/explore_entities.dart';
import '../providers/explore_providers.dart';
import '../widgets/explore_widgets.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(exploreArticlesProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final articles = ref.watch(exploreArticlesProvider);
    final selectedCategory = ref.watch(exploreSelectedCategoryProvider);
    final hasMore = ref.read(exploreArticlesProvider.notifier).hasMore;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore',
          style: AppTypography.headlineMedium(color: colorScheme.onSurface),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base,
              0,
              AppSpacing.base,
              AppSpacing.md,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles, topics...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                           ref.read(exploreSearchQueryProvider.notifier).state = '';
                          ref
                              .read(exploreArticlesProvider.notifier)
                              .updateSearch('');
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusFull,
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.md,
                ),
              ),
              onChanged: (v) {
                ref.read(exploreSearchQueryProvider.notifier).state = v;
                ref.read(exploreArticlesProvider.notifier).updateSearch(v);
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              scrollDirection: Axis.horizontal,
              itemCount: ExploreCategory.values.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final cat = ExploreCategory.values[index];
                final isSelected = selectedCategory == cat;
                return ExploreCategoryChip(
                  category: cat,
                  isSelected: isSelected,
                  onTap: () {
                    final newCat = isSelected ? null : cat;
                    ref.read(exploreSelectedCategoryProvider.notifier).state =
                        newCat;
                    ref
                        .read(exploreArticlesProvider.notifier)
                        .updateCategory(newCat);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: articles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 64,
                          color: colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'No articles found',
                          style: AppTypography.bodyLarge(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                    itemCount: articles.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == articles.length) {
                        return const Padding(
                          padding: EdgeInsets.all(AppSpacing.lg),
                          child:
                              Center(child: CircularProgressIndicator()),
                        );
                      }
                      return ExploreArticleCard(
                        article: articles[index],
                        onTap: () => context.push(
                          '${RouteNames.explore}/article/${articles[index].id}',
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(
                              milliseconds: 30 * (index % 10),
                            ),
                          )
                          .slideY(begin: 0.05);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
