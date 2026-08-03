import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.title,
    required this.location,
    required this.bio,
    required this.joinDate,
    required this.isPremium,
  });
  final String name;
  final String email;
  final String avatarUrl;
  final String title;
  final String location;
  final String bio;
  final String joinDate;
  final bool isPremium;
}

class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.unlockedAt,
    required this.isUnlocked,
    required this.progress,
    required this.maxProgress,
  });
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String? unlockedAt;
  final bool isUnlocked;
  final int progress;
  final int maxProgress;
}

class HistoryItem {
  const HistoryItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.timestamp,
    required this.icon,
  });
  final String id;
  final String title;
  final String subtitle;
  final HistoryItemType type;
  final String timestamp;
  final IconData icon;
}

enum HistoryItemType { job, article, project, lesson, quiz, skillTest, aiChat }

class BookmarkItem {
  const BookmarkItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.savedAt,
    required this.icon,
  });
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String savedAt;
  final IconData icon;
}

class LearningStats {
  const LearningStats({
    required this.totalLessonsCompleted,
    required this.totalHoursLearned,
    required this.currentStreak,
    required this.longestStreak,
    required this.coursesCompleted,
    required this.quizzesPassed,
    required this.skillsLearned,
    required this.weeklyProgress,
    required this.monthlyProgress,
  });
  final int totalLessonsCompleted;
  final int totalHoursLearned;
  final int currentStreak;
  final int longestStreak;
  final int coursesCompleted;
  final int quizzesPassed;
  final int skillsLearned;
  final List<double> weeklyProgress;
  final List<double> monthlyProgress;
}

class GitHubStats {
  const GitHubStats({
    required this.totalRepos,
    required this.totalStars,
    required this.totalCommits,
    required this.totalPRs,
    required this.totalIssues,
    required this.contributionStreak,
    required this.topLanguages,
    required this.recentActivity,
  });
  final int totalRepos;
  final int totalStars;
  final int totalCommits;
  final int totalPRs;
  final int totalIssues;
  final int contributionStreak;
  final List<LanguageStat> topLanguages;
  final List<String> recentActivity;
}

class LanguageStat {
  const LanguageStat({required this.name, required this.percentage, required this.color});
  final String name;
  final double percentage;
  final Color color;
}

class ResumeScore {
  const ResumeScore({
    required this.overallScore,
    required this.atsScore,
    required this.readabilityScore,
    required this.keywordScore,
    required this.formatScore,
    required this.suggestions,
    required this.sectionScores,
  });
  final int overallScore;
  final int atsScore;
  final int readabilityScore;
  final int keywordScore;
  final int formatScore;
  final List<String> suggestions;
  final List<SectionScore> sectionScores;
}

class SectionScore {
  const SectionScore({required this.name, required this.score, required this.color});
  final String name;
  final int score;
  final Color color;
}

class ThemeSetting {
  const ThemeSetting({
    required this.id,
    required this.label,
    required this.icon,
    required this.isActive,
  });
  final String id;
  final String label;
  final IconData icon;
  final bool isActive;
}
