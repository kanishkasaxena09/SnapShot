import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/id_set_notifier.dart';
import '../../data/datasources/ai_tools_local_datasource.dart';
import '../../domain/entities/ai_tools_entities.dart';

final aiToolsDataSourceProvider = Provider<AiToolsLocalDataSource>((ref) => AiToolsLocalDataSource());

final aiToolsSearchQueryProvider = StateProvider<String>((ref) => '');
final aiToolsCategoryFilterProvider = StateProvider<AiToolCategory?>((ref) => null);
final aiToolsPricingFilterProvider = StateProvider<PricingTier?>((ref) => null);
final aiToolsSortProvider = StateProvider<String>((ref) => 'rating');

final allAiToolsProvider = Provider<List<AiTool>>((ref) {
  final ds = ref.read(aiToolsDataSourceProvider);
  final query = ref.watch(aiToolsSearchQueryProvider);
  final category = ref.watch(aiToolsCategoryFilterProvider);
  final pricing = ref.watch(aiToolsPricingFilterProvider);
  final sort = ref.watch(aiToolsSortProvider);

  List<AiTool> tools;
  if (query.isNotEmpty) {
    tools = ds.searchTools(query);
  } else if (category != null) {
    tools = ds.getToolsByCategory(category);
  } else if (pricing != null) {
    tools = ds.getToolsByPricing(pricing);
  } else {
    tools = ds.getTools();
  }

  switch (sort) {
    case 'rating':
      tools = List.from(tools)..sort((a, b) => b.rating.compareTo(a.rating));
    case 'reviews':
      tools = List.from(tools)..sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    case 'name':
      tools = List.from(tools)..sort((a, b) => a.name.compareTo(b.name));
    case 'newest':
      tools = List.from(tools)..sort((a, b) => (b.isNew ? 1 : 0).compareTo(a.isNew ? 1 : 0));
  }
  return tools;
});

final aiToolCategoriesProvider = Provider<List<AiToolCategoryInfo>>((ref) {
  return ref.read(aiToolsDataSourceProvider).getCategories();
});

final trendingToolsProvider = Provider<List<AiTool>>((ref) {
  return ref.read(aiToolsDataSourceProvider).getTrendingTools();
});

final newToolsProvider = Provider<List<AiTool>>((ref) {
  return ref.read(aiToolsDataSourceProvider).getNewTools();
});

final aiToolDetailProvider = Provider.family<AiTool?, String>((ref, toolId) {
  try {
    return ref.read(aiToolsDataSourceProvider).getTools().firstWhere((t) => t.id == toolId);
  } catch (_) {
    return null;
  }
});

final aiToolReviewsProvider = Provider.family<List<AiToolReview>, String>((ref, toolId) {
  return ref.read(aiToolsDataSourceProvider).getReviews(toolId);
});

final bookmarkedToolsProvider = StateNotifierProvider<IdSetNotifier, List<String>>((ref) {
  return IdSetNotifier(['t1', 't5', 't10']);
});

final comparedToolsProvider = StateNotifierProvider<IdSetNotifier, List<String>>((ref) {
  return IdSetNotifier([], 3);
});
