import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(bookmarkedJobsProvider);
    final articles = ref.watch(bookmarkedArticlesProvider);
    final projects = ref.watch(bookmarkedProjectsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Bookmarks', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          indicatorColor: colorScheme.primary,
          tabs: const [
            Tab(text: 'Jobs'),
            Tab(text: 'Articles'),
            Tab(text: 'Projects'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BookmarkList(
            items: jobs,
            emptyMessage: 'No saved jobs',
            onRemove: (id) => ref.read(bookmarkedJobsProvider.notifier).remove(id),
          ),
          _BookmarkList(
            items: articles,
            emptyMessage: 'No saved articles',
            onRemove: (id) => ref.read(bookmarkedArticlesProvider.notifier).remove(id),
          ),
          _BookmarkList(
            items: projects,
            emptyMessage: 'No saved projects',
            onRemove: (id) => ref.read(bookmarkedProjectsProvider.notifier).remove(id),
          ),
        ],
      ),
    );
  }
}

class _BookmarkList extends StatelessWidget {
  const _BookmarkList({required this.items, required this.emptyMessage, this.onRemove});
  final List items;
  final String emptyMessage;
  final void Function(String id)? onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 64, color: colorScheme.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            Text(emptyMessage, style: AppTypography.bodyMedium(color: colorScheme.onSurfaceVariant)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.base),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Icon(item.icon, color: colorScheme.primary, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                    Text(item.subtitle, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.bookmark_remove, color: colorScheme.error, size: 20),
                onPressed: () => onRemove?.call(item.id),
              ),
            ],
          ),
        );
      },
    );
  }
}
