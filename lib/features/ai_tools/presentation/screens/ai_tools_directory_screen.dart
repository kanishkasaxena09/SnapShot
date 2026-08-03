import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/ai_tools_entities.dart';
import '../providers/ai_tools_providers.dart';

class AiToolsDirectoryScreen extends ConsumerStatefulWidget {
  const AiToolsDirectoryScreen({super.key});

  @override
  ConsumerState<AiToolsDirectoryScreen> createState() => _AiToolsDirectoryScreenState();
}

class _AiToolsDirectoryScreenState extends ConsumerState<AiToolsDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _pricingBadgeColor(PricingTier tier) {
    switch (tier) {
      case PricingTier.free:
        return AppColors.successLight;
      case PricingTier.freemium:
        return AppColors.accentBlue;
      case PricingTier.paid:
        return AppColors.accentOrange;
      case PricingTier.enterprise:
        return AppColors.primaryLight;
      case PricingTier.contact:
        return AppColors.textSecondaryLight;
    }
  }

  String _pricingLabel(PricingTier tier) {
    switch (tier) {
      case PricingTier.free:
        return 'Free';
      case PricingTier.freemium:
        return 'Freemium';
      case PricingTier.paid:
        return 'Paid';
      case PricingTier.enterprise:
        return 'Enterprise';
      case PricingTier.contact:
        return 'Contact';
    }
  }

  Widget _buildStarRow(double rating, {double size = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: size, color: AppColors.accentYellow);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: size, color: AppColors.accentYellow);
        }
        return Icon(Icons.star_border, size: size, color: AppColors.accentYellow);
      }),
    );
  }

  Widget _buildHorizontalToolCard(AiTool tool, bool isBookmarked, bool isCompared, bool isCompareFull) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push('/ai-tools/${tool.id}'),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: AppSpacing.md),
        padding: AppSpacing.cardPadding,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: tool.color.withOpacity(0.15),
                  child: Icon(tool.icon, color: tool.color, size: AppSpacing.iconMd),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (tool.isTrending)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.tertiaryLight.withOpacity(0.1),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(
                          '🔥',
                          style: AppTypography.labelSmall(color: AppColors.tertiaryLight),
                        ),
                      ),
                    if (tool.isNew)
                      Container(
                        margin: tool.isTrending ? const EdgeInsets.only(left: 4) : null,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLight.withOpacity(0.1),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(
                          'NEW',
                          style: AppTypography.labelSmall(color: AppColors.secondaryLight),
                        ),
                      ),
                  ],
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
            _buildStarRow(tool.rating, size: 12),
            AppSpacing.gapXs,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _pricingBadgeColor(tool.pricing).withOpacity(0.12),
                borderRadius: AppSpacing.borderRadiusXs,
              ),
              child: Text(
                _pricingLabel(tool.pricing),
                style: AppTypography.labelSmall(color: _pricingBadgeColor(tool.pricing)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolGridCard(AiTool tool, bool isBookmarked, bool isCompared, bool isCompareFull) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push('/ai-tools/${tool.id}'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: tool.color.withOpacity(0.15),
                  child: Icon(tool.icon, color: tool.color, size: AppSpacing.iconMd),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (tool.isTrending)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.tertiaryLight.withOpacity(0.1),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(
                          '🔥',
                          style: AppTypography.labelSmall(color: AppColors.tertiaryLight),
                        ),
                      ),
                    if (tool.isNew)
                      Container(
                        margin: tool.isTrending ? const EdgeInsets.only(left: 4) : null,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLight.withOpacity(0.1),
                          borderRadius: AppSpacing.borderRadiusXs,
                        ),
                        child: Text(
                          'NEW',
                          style: AppTypography.labelSmall(color: AppColors.secondaryLight),
                        ),
                      ),
                  ],
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
                _buildStarRow(tool.rating, size: 14),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '(${tool.reviewCount})',
                  style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            AppSpacing.gapSm,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
            AppSpacing.gapSm,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _pricingBadgeColor(tool.pricing).withOpacity(0.12),
                borderRadius: AppSpacing.borderRadiusXs,
              ),
              child: Text(
                _pricingLabel(tool.pricing),
                style: AppTypography.labelSmall(color: _pricingBadgeColor(tool.pricing)),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(bookmarkedToolsProvider.notifier).toggle(tool.id);
                  },
                  child: Icon(
                    isBookmarked ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: isBookmarked ? AppColors.tertiaryLight : colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: isCompareFull && !isCompared
                      ? null
                      : () {
                          ref.read(comparedToolsProvider.notifier).toggle(tool.id);
                        },
                  child: Icon(
                    isCompared ? Icons.compare_arrows : Icons.compare_arrows_outlined,
                    size: 20,
                    color: isCompared
                        ? colorScheme.primary
                        : isCompareFull
                            ? colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
                            : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchQuery = ref.watch(aiToolsSearchQueryProvider);
    final selectedCategory = ref.watch(aiToolsCategoryFilterProvider);
    final selectedPricing = ref.watch(aiToolsPricingFilterProvider);
    final currentSort = ref.watch(aiToolsSortProvider);
    final categories = ref.watch(aiToolCategoriesProvider);
    final allTools = ref.watch(allAiToolsProvider);
    final trendingTools = ref.watch(trendingToolsProvider);
    final newTools = ref.watch(newToolsProvider);
    final bookmarked = ref.watch(bookmarkedToolsProvider);
    final compared = ref.watch(comparedToolsProvider);

    final hasActiveFilters = searchQuery.isNotEmpty || selectedCategory != null || selectedPricing != null;
    final isCompareFull = compared.length >= 3;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('AI Tools Directory', style: AppTypography.titleLarge(color: colorScheme.onSurface)),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.compare_arrows, size: 22),
                onPressed: () => context.push('/ai-tools/compare'),
              ),
              if (compared.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${compared.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark,
              size: 22,
              color: bookmarked.isNotEmpty ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
            onPressed: () => context.push(RouteNames.aiToolsBookmarks),
          ),
        ],
      ),
      body: RefreshIndicator(
      color: colorScheme.primary,
      backgroundColor: colorScheme.surface,
      onRefresh: () async => ref.invalidate(allAiToolsProvider),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.base, AppSpacing.base, 0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  ref.read(aiToolsSearchQueryProvider.notifier).state = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search AI tools...',
                  hintStyle: AppTypography.bodyMedium(color: colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant, size: 20),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(aiToolsSearchQueryProvider.notifier).state = '';
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  border: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: const BorderSide(color: AppColors.borderFocusLight, width: 1.5),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.md),
                itemCount: categories.length + 1,
                separatorBuilder: (_, __) => AppSpacing.hGapSm,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    final isSelected = selectedCategory == null;
                    return GestureDetector(
                      onTap: () {
                        ref.read(aiToolsCategoryFilterProvider.notifier).state = null;
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : colorScheme.surface,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(
                            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.grid_view_rounded,
                              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                              size: AppSpacing.iconMd,
                            ),
                            AppSpacing.gapXs,
                            Text(
                              'All',
                              style: AppTypography.labelSmall(
                                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final catInfo = categories[index - 1];
                  final isSelected = selectedCategory == catInfo.category;
                  return GestureDetector(
                    onTap: () {
                      ref.read(aiToolsCategoryFilterProvider.notifier).state = catInfo.category;
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isSelected ? catInfo.color.withOpacity(0.1) : colorScheme.surface,
                        borderRadius: AppSpacing.borderRadiusMd,
                        border: Border.all(
                          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            catInfo.icon,
                            color: isSelected ? catInfo.color : colorScheme.onSurfaceVariant,
                            size: AppSpacing.iconMd,
                          ),
                          AppSpacing.gapXs,
                          Text(
                            catInfo.name,
                            style: AppTypography.labelSmall(
                              color: isSelected ? catInfo.color : colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                itemCount: PricingTier.values.length,
                separatorBuilder: (_, __) => AppSpacing.hGapSm,
                itemBuilder: (context, index) {
                  final tier = PricingTier.values[index];
                  final isSelected = selectedPricing == tier;
                  return FilterChip(
                    selected: isSelected,
                    label: Text(
                      _pricingLabel(tier),
                      style: AppTypography.labelMedium(
                        color: isSelected ? Colors.white : _pricingBadgeColor(tier),
                      ),
                    ),
                    selectedColor: _pricingBadgeColor(tier),
                    backgroundColor: _pricingBadgeColor(tier).withOpacity(0.08),
                    side: BorderSide(
                      color: isSelected ? _pricingBadgeColor(tier) : _pricingBadgeColor(tier).withOpacity(0.3),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusFull),
                    onSelected: (selected) {
                      ref.read(aiToolsPricingFilterProvider.notifier).state = selected ? tier : null;
                    },
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.md, AppSpacing.base, AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${allTools.length} tools found',
                    style: AppTypography.bodyMedium(color: colorScheme.onSurfaceVariant),
                  ),
                  DropdownButton<String>(
                    value: currentSort,
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                    style: AppTypography.bodyMedium(color: colorScheme.onSurface),
                    items: const [
                      DropdownMenuItem(value: 'rating', child: Text('Rating')),
                      DropdownMenuItem(value: 'reviews', child: Text('Reviews')),
                      DropdownMenuItem(value: 'newest', child: Text('Newest')),
                      DropdownMenuItem(value: 'name', child: Text('Name')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(aiToolsSortProvider.notifier).state = value;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (!hasActiveFilters && trendingTools.isNotEmpty)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                    child: Text('Trending Now', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  ),
                  AppSpacing.gapSm,
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                      itemCount: trendingTools.length,
                      itemBuilder: (context, index) {
                        final tool = trendingTools[index];
                        final isBookmarked = bookmarked.contains(tool.id);
                        final isCompared = compared.contains(tool.id);
                        return _buildHorizontalToolCard(tool, isBookmarked, isCompared, isCompareFull);
                      },
                    ),
                  ),
                  AppSpacing.gapBase,
                ],
              ),
            ),
          if (!hasActiveFilters && newTools.isNotEmpty)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                    child: Text('New & Noteworthy', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                  ),
                  AppSpacing.gapSm,
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                      itemCount: newTools.length,
                      itemBuilder: (context, index) {
                        final tool = newTools[index];
                        final isBookmarked = bookmarked.contains(tool.id);
                        final isCompared = compared.contains(tool.id);
                        return _buildHorizontalToolCard(tool, isBookmarked, isCompared, isCompareFull);
                      },
                    ),
                  ),
                  AppSpacing.gapBase,
                ],
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tool = allTools[index];
                  final isBookmarked = bookmarked.contains(tool.id);
                  final isCompared = compared.contains(tool.id);
                  return RepaintBoundary(
                    child: Semantics(
                      label: '${tool.name} by ${tool.company}. Rating ${tool.rating}',
                      button: true,
                      child: _buildToolGridCard(tool, isBookmarked, isCompared, isCompareFull),
                    ),
                  );
                },
                childCount: allTools.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      ),
      floatingActionButton: compared.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/ai-tools/compare'),
              backgroundColor: colorScheme.primary,
              icon: const Icon(Icons.compare_arrows, color: Colors.white, size: 20),
              label: Text(
                'Compare (${compared.length})',
                style: AppTypography.labelLarge(color: Colors.white),
              ),
            )
          : null,
    );
  }
}
