import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/id_set_notifier.dart';
import '../../data/datasources/learning_local_datasource.dart';
import '../../domain/entities/learning_entities.dart';

final learningDataSourceProvider = Provider<LearningLocalDataSource>((ref) => LearningLocalDataSource());

final learningSearchQueryProvider = StateProvider<String>((ref) => '');

final learningCategoryFilterProvider = StateProvider<String>((ref) => 'All');

final roadmapsProvider = Provider<List<LearningRoadmap>>((ref) {
  ref.watch(learningSearchQueryProvider);
  return ref.read(learningDataSourceProvider).getRoadmaps();
});

final lessonsProvider = Provider<List<LearningLesson>>((ref) {
  final query = ref.watch(learningSearchQueryProvider);
  final category = ref.watch(learningCategoryFilterProvider);
  final datasource = ref.read(learningDataSourceProvider);
  var lessons = datasource.searchLessons(query);
  if (category != 'All') {
    lessons = lessons.where((l) => l.category == category).toList();
  }
  return lessons;
});

final videosProvider = Provider<List<LearningVideo>>((ref) {
  return ref.read(learningDataSourceProvider).getVideos();
});

final notesProvider = Provider<List<LearningNote>>((ref) {
  return ref.read(learningDataSourceProvider).getNotes();
});

final cheatSheetsProvider = Provider<List<LearningCheatSheet>>((ref) {
  return ref.read(learningDataSourceProvider).getCheatSheets();
});

final dailyChallengesProvider = Provider<List<DailyChallenge>>((ref) {
  return ref.read(learningDataSourceProvider).getDailyChallenges();
});

final quizzesProvider = Provider<List<LearningQuiz>>((ref) {
  return ref.read(learningDataSourceProvider).getQuizzes();
});

final certificatesProvider = Provider<List<LearningCertificate>>((ref) {
  return ref.read(learningDataSourceProvider).getCertificates();
});

final learningAchievementsProvider = Provider<List<LearningAchievement>>((ref) {
  return ref.read(learningDataSourceProvider).getAchievements();
});

final streakProvider = Provider<LearningStreak>((ref) {
  return ref.read(learningDataSourceProvider).getStreakData();
});

final roadmapDetailProvider = Provider.family<LearningRoadmap?, String>((ref, roadmapId) {
  try {
    return ref.read(learningDataSourceProvider).getRoadmaps().firstWhere((r) => r.id == roadmapId);
  } catch (_) {
    return null;
  }
});

final lessonDetailProvider = Provider.family<LearningLesson?, String>((ref, lessonId) {
  try {
    return ref.read(learningDataSourceProvider).getLessons().firstWhere((l) => l.id == lessonId);
  } catch (_) {
    return null;
  }
});

final quizDetailProvider = Provider.family<LearningQuiz?, String>((ref, quizId) {
  try {
    return ref.read(learningDataSourceProvider).getQuizzes().firstWhere((q) => q.id == quizId);
  } catch (_) {
    return null;
  }
});

final savedLessonsProvider = StateNotifierProvider<IdSetNotifier, List<String>>((ref) {
  return IdSetNotifier(['l1', 'l4']);
});
