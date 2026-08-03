import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/explore_entities.dart';
import '../../data/datasources/explore_local_datasource.dart';

final exploreDataSourceProvider = Provider<ExploreLocalDataSource>((ref) {
  return ExploreLocalDataSource();
});

final exploreSearchQueryProvider = StateProvider<String>((ref) => '');

final exploreSelectedCategoryProvider = StateProvider<ExploreCategory?>((ref) => null);

class ExploreArticlesNotifier extends StateNotifier<List<ExploreArticle>> {
  ExploreArticlesNotifier(this._dataSource) : super(const []) {
    loadInitial();
  }

  final ExploreLocalDataSource _dataSource;
  static const _pageSize = 10;
  int _currentPage = 0;
  bool _hasMore = true;
  String _searchQuery = '';
  ExploreCategory? _category;

  bool get hasMore => _hasMore;

  void loadInitial() {
    _currentPage = 0;
    _hasMore = true;
    final all = _dataSource.getAllArticles();
    final filtered = _applyFilters(all);
    state = filtered.take(_pageSize).toList();
    _currentPage = 1;
    _hasMore = filtered.length > _pageSize;
  }

  void loadMore() {
    if (!_hasMore) return;
    final all = _dataSource.getAllArticles();
    final filtered = _applyFilters(all);
    final start = _currentPage * _pageSize;
    final end = start + _pageSize;
    if (start >= filtered.length) {
      _hasMore = false;
      return;
    }
    state = [
      ...state,
      ...filtered.sublist(start, end.clamp(0, filtered.length)),
    ];
    _currentPage++;
    _hasMore = end < filtered.length;
  }

  void updateSearch(String query) {
    _searchQuery = query;
    loadInitial();
  }

  void updateCategory(ExploreCategory? category) {
    _category = category;
    loadInitial();
  }

  List<ExploreArticle> _applyFilters(List<ExploreArticle> articles) {
    var result = articles;
    if (_category != null) {
      result = result.where((a) => a.category == _category).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result.where((a) =>
          a.title.toLowerCase().contains(q) ||
          a.summary.toLowerCase().contains(q) ||
          a.tags.any((t) => t.toLowerCase().contains(q))).toList();
    }
    return result;
  }
}

final exploreArticlesProvider =
    StateNotifierProvider<ExploreArticlesNotifier, List<ExploreArticle>>(
        (ref) {
  return ExploreArticlesNotifier(ref.read(exploreDataSourceProvider));
});

final exploreBookmarkIdsProvider = StateProvider<Set<String>>((ref) => {});

void toggleBookmark(WidgetRef ref, String articleId) {
  ref.read(exploreDataSourceProvider).toggleBookmark(articleId);
  final current = Set<String>.from(ref.read(exploreBookmarkIdsProvider));
  if (current.contains(articleId)) {
    current.remove(articleId);
  } else {
    current.add(articleId);
  }
  ref.read(exploreBookmarkIdsProvider.notifier).state = current;
}

final exploreReadingProgressProvider =
    StateProvider<Map<String, double>>((ref) => {});

void updateReadingProgress(
    WidgetRef ref, String articleId, double progress) {
  ref
      .read(exploreDataSourceProvider)
      .updateReadingProgress(articleId, progress);
  final current = Map<String, double>.from(ref.read(exploreReadingProgressProvider));
  current[articleId] = progress;
  ref.read(exploreReadingProgressProvider.notifier).state = current;
}
