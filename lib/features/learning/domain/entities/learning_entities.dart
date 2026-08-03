import 'package:flutter/material.dart';

enum DifficultyLevel { beginner, intermediate, advanced }

enum ChallengeStatus { pending, active, completed, failed }

enum AchievementRarity { common, uncommon, rare, epic, legendary }

class LearningRoadmap {

  const LearningRoadmap({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.totalSteps,
    required this.completedSteps,
    required this.steps,
    required this.estimatedTime,
    required this.difficulty,
    this.isLocked = false,
  });
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int totalSteps;
  final int completedSteps;
  final List<RoadmapStep> steps;
  final String estimatedTime;
  final DifficultyLevel difficulty;
  final bool isLocked;

  double get progress => totalSteps > 0 ? completedSteps / totalSteps : 0.0;
}

class RoadmapStep {

  const RoadmapStep({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isCurrent = false,
    this.lessonId,
  });
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isCurrent;
  final String? lessonId;
}

class LearningLesson {

  const LearningLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.totalModules,
    required this.completedModules,
    required this.author,
    required this.rating,
    required this.enrolledCount,
    required this.tags,
    required this.thumbnailColor,
    this.isBookmarked = false,
  });
  final String id;
  final String title;
  final String description;
  final String category;
  final DifficultyLevel difficulty;
  final int durationMinutes;
  final int totalModules;
  final int completedModules;
  final String author;
  final double rating;
  final int enrolledCount;
  final List<String> tags;
  final String thumbnailColor;
  final bool isBookmarked;

  double get progress => totalModules > 0 ? completedModules / totalModules : 0.0;
}

class LearningVideo {

  const LearningVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.channel,
    required this.durationMinutes,
    required this.viewCount,
    required this.publishedAt,
    required this.category,
    required this.difficulty,
    required this.rating,
    this.isWatched = false,
    this.isSaved = false,
    required this.thumbnailColor,
  });
  final String id;
  final String title;
  final String description;
  final String channel;
  final int durationMinutes;
  final int viewCount;
  final String publishedAt;
  final String category;
  final DifficultyLevel difficulty;
  final double rating;
  final bool isWatched;
  final bool isSaved;
  final String thumbnailColor;
}

class LearningNote {

  const LearningNote({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.difficulty,
    required this.pageCount,
    required this.readTimeMinutes,
    this.isBookmarked = false,
    required this.lastUpdated,
    required this.author,
    required this.tags,
  });
  final String id;
  final String title;
  final String content;
  final String category;
  final DifficultyLevel difficulty;
  final int pageCount;
  final int readTimeMinutes;
  final bool isBookmarked;
  final DateTime lastUpdated;
  final String author;
  final List<String> tags;
}

class LearningCheatSheet {

  const LearningCheatSheet({
    required this.id,
    required this.title,
    required this.category,
    required this.color,
    required this.itemCount,
    required this.readTimeMinutes,
    required this.difficulty,
    this.isBookmarked = false,
    required this.lastUpdated,
  });
  final String id;
  final String title;
  final String category;
  final Color color;
  final int itemCount;
  final int readTimeMinutes;
  final DifficultyLevel difficulty;
  final bool isBookmarked;
  final String lastUpdated;
}

class DailyChallenge {

  const DailyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.points,
    required this.timeLimitMinutes,
    required this.status,
    this.completedAt,
    required this.expiresAt,
  });
  final String id;
  final String title;
  final String description;
  final String category;
  final DifficultyLevel difficulty;
  final int points;
  final int timeLimitMinutes;
  final ChallengeStatus status;
  final String? completedAt;
  final DateTime expiresAt;
}

class LearningQuiz {

  const LearningQuiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.questionCount,
    required this.timeLimitMinutes,
    required this.passingScore,
    this.isCompleted = false,
    this.bestScore,
    required this.rating,
    this.attemptCount = 0,
  });
  final String id;
  final String title;
  final String description;
  final String category;
  final DifficultyLevel difficulty;
  final int questionCount;
  final int timeLimitMinutes;
  final int passingScore;
  final bool isCompleted;
  final int? bestScore;
  final double rating;
  final int attemptCount;
}

class LearningCertificate {

  const LearningCertificate({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issuedDate,
    required this.expiryDate,
    required this.credentialId,
    this.credentialUrl,
    required this.color,
    this.isVerified = true,
  });
  final String id;
  final String title;
  final String issuer;
  final DateTime issuedDate;
  final DateTime expiryDate;
  final String credentialId;
  final String? credentialUrl;
  final Color color;
  final bool isVerified;
}

class LearningAchievement {

  const LearningAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.rarity,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0,
    this.totalRequired = 1,
  });
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final AchievementRarity rarity;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int progress;
  final int totalRequired;

  double get progressPercent => totalRequired > 0 ? progress / totalRequired : 0.0;
}

class LearningStreak {

  const LearningStreak({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalDaysStudied,
    required this.totalHoursStudied,
    required this.calendarDays,
    required this.todayXP,
    required this.weeklyXP,
    required this.totalXP,
    required this.level,
    required this.xpToNextLevel,
  });
  final int currentStreak;
  final int longestStreak;
  final int totalDaysStudied;
  final int totalHoursStudied;
  final List<StreakDay> calendarDays;
  final int todayXP;
  final int weeklyXP;
  final int totalXP;
  final int level;
  final int xpToNextLevel;

  double get levelProgress => xpToNextLevel > 0 ? (totalXP % xpToNextLevel) / xpToNextLevel : 0.0;
}

class StreakDay {

  const StreakDay({
    required this.date,
    this.minutesStudied = 0,
    this.isActive = false,
  });
  final DateTime date;
  final int minutesStudied;
  final bool isActive;
}
