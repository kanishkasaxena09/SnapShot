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

class ExploreCategoryDetailScreen extends ConsumerWidget {
  const ExploreCategoryDetailScreen({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  ExploreCategory? get _category {
    for (final c in ExploreCategory.values) {
      if (c.name == categoryName) return c;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final category = _category;

    if (category == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Category not found')),
      );
    }

    final articles =
        ref.read(exploreDataSourceProvider).getArticlesByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(category.icon, color: category.color, size: 22),
            const SizedBox(width: AppSpacing.sm),
            Text(category.label),
          ],
        ),
      ),
      body: articles.isEmpty
          ? Center(
              child: Text(
                'No articles in ${category.label} yet',
                style: AppTypography.bodyLarge(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.base),
              itemCount: articles.length,
              itemBuilder: (context, index) => ExploreArticleCard(
                article: articles[index],
                onTap: () => context.push(
                  '${RouteNames.explore}/article/${articles[index].id}',
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 40 * index),
                  )
                  .slideY(begin: 0.05),
            ),
    );
  }
}
