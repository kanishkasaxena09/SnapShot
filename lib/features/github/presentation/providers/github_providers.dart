import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/id_set_notifier.dart';
import '../../data/datasources/github_local_datasource.dart';
import '../../domain/entities/github_entities.dart';

final githubDataSourceProvider = Provider<GithubLocalDataSource>((ref) => GithubLocalDataSource());

final githubSearchQueryProvider = StateProvider<String>((ref) => '');

final trendingReposProvider = Provider<List<GithubRepository>>((ref) {
  final query = ref.watch(githubSearchQueryProvider);
  return ref.read(githubDataSourceProvider).searchRepos(query);
});

final trendingDevelopersProvider = Provider<List<GithubDeveloper>>((ref) {
  return ref.read(githubDataSourceProvider).getTrendingDevelopers();
});

final repoDetailProvider = Provider.family<GithubRepository?, String>((ref, repoId) {
  try {
    return ref.read(githubDataSourceProvider).getTrendingRepos().firstWhere((r) => r.id == repoId);
  } catch (_) {
    return null;
  }
});

final developerDetailProvider = Provider.family<GithubDeveloper?, String>((ref, devId) {
  try {
    return ref.read(githubDataSourceProvider).getTrendingDevelopers().firstWhere((d) => d.id == devId);
  } catch (_) {
    return null;
  }
});

final starredReposProvider = StateNotifierProvider<IdSetNotifier, List<String>>((ref) {
  return IdSetNotifier(['r1', 'r4']);
});
