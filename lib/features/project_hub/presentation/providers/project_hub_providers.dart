import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/project_hub_local_datasource.dart';
import '../../domain/entities/project_entities.dart';

final projectDataSourceProvider = Provider<ProjectHubLocalDataSource>((ref) => ProjectHubLocalDataSource());

final projectSearchQueryProvider = StateProvider<String>((ref) => '');
final projectDifficultyFilterProvider = StateProvider<ProjectDifficulty?>((ref) => null);
final projectCategoryFilterProvider = StateProvider<ProjectCategory?>((ref) => null);
final projectTechnologyFilterProvider = StateProvider<String?>((ref) => null);
final projectSortProvider = StateProvider<String>((ref) => 'rating');

final allProjectsProvider = Provider<List<Project>>((ref) {
  final ds = ref.read(projectDataSourceProvider);
  final query = ref.watch(projectSearchQueryProvider);
  final difficulty = ref.watch(projectDifficultyFilterProvider);
  final category = ref.watch(projectCategoryFilterProvider);
  final technology = ref.watch(projectTechnologyFilterProvider);
  final sort = ref.watch(projectSortProvider);

  var projects = List<Project>.from(query.isNotEmpty ? ds.searchProjects(query) : ds.getProjects());
  if (difficulty != null) projects = projects.where((p) => p.difficulty == difficulty).toList();
  if (category != null) projects = projects.where((p) => p.category == category).toList();
  if (technology != null) projects = projects.where((p) => p.technologies.contains(technology)).toList();

  switch (sort) {
    case 'rating':
      projects.sort((a, b) => b.rating.compareTo(a.rating));
      break;
    case 'portfolio':
      projects.sort((a, b) => b.portfolioValue.compareTo(a.portfolioValue));
      break;
    case 'newest':
      projects = projects.where((p) => p.isNew).toList()..addAll(projects.where((p) => !p.isNew));
      break;
    case 'name':
      projects.sort((a, b) => a.name.compareTo(b.name));
      break;
  }
  return projects;
});

final featuredProjectsProvider = Provider<List<Project>>((ref) {
  return ref.read(projectDataSourceProvider).getFeaturedProjects();
});

final allTechnologiesProvider = Provider<List<String>>((ref) {
  return ref.read(projectDataSourceProvider).getAllTechnologies();
});

final projectDetailProvider = Provider.family<Project?, String>((ref, projectId) {
  return ref.read(projectDataSourceProvider).getProjects().where((p) => p.id == projectId).firstOrNull;
});

final projectRecommendationsProvider = Provider<List<ProjectRecommendation>>((ref) {
  return ref.read(projectDataSourceProvider).getRecommendations(['Flutter', 'React', 'Node.js', 'Python', 'JavaScript']);
});
