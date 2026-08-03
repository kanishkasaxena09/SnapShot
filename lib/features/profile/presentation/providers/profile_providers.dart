import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/profile_local_datasource.dart';
import '../../domain/entities/profile_entities.dart';

final profileDataSourceProvider = Provider<ProfileLocalDataSource>((ref) => ProfileLocalDataSource());

final profileProvider = Provider<UserProfile>((ref) {
  return ref.read(profileDataSourceProvider).getProfile();
});

final profileAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.read(profileDataSourceProvider).getAchievements();
});

final historyProvider = Provider<List<HistoryItem>>((ref) {
  return ref.read(profileDataSourceProvider).getHistory();
});

class BookmarkListNotifier extends StateNotifier<List<BookmarkItem>> {
  BookmarkListNotifier(List<BookmarkItem> items) : super(items);

  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final bookmarkedJobsProvider = StateNotifierProvider<BookmarkListNotifier, List<BookmarkItem>>((ref) {
  return BookmarkListNotifier(ref.read(profileDataSourceProvider).getBookmarkedJobs());
});

final bookmarkedArticlesProvider = StateNotifierProvider<BookmarkListNotifier, List<BookmarkItem>>((ref) {
  return BookmarkListNotifier(ref.read(profileDataSourceProvider).getBookmarkedArticles());
});

final bookmarkedProjectsProvider = StateNotifierProvider<BookmarkListNotifier, List<BookmarkItem>>((ref) {
  return BookmarkListNotifier(ref.read(profileDataSourceProvider).getBookmarkedProjects());
});

final learningStatsProvider = Provider<LearningStats>((ref) {
  return ref.read(profileDataSourceProvider).getLearningStats();
});

final gitHubStatsProvider = Provider<GitHubStats>((ref) {
  return ref.read(profileDataSourceProvider).getGitHubStats();
});

final resumeScoreProvider = Provider<ResumeScore>((ref) {
  return ref.read(profileDataSourceProvider).getResumeScore();
});

final themeSettingsProvider = Provider<List<ThemeSetting>>((ref) {
  return ref.read(profileDataSourceProvider).getThemeSettings();
});

final selectedThemeProvider = StateProvider<String>((ref) => 'system');
