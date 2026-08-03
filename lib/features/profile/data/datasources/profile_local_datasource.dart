import 'package:flutter/material.dart';
import '../../domain/entities/profile_entities.dart';

class ProfileLocalDataSource {
  UserProfile getProfile() => const UserProfile(
    name: 'Alex Morgan',
    email: 'alex.morgan@email.com',
    avatarUrl: '',
    title: 'Full Stack Developer',
    location: 'San Francisco, CA',
    bio: 'Passionate developer with 3+ years of experience in Flutter and React. Love building beautiful, performant apps.',
    joinDate: 'January 2026',
    isPremium: true,
  );

  List<Achievement> getAchievements() => const [
        Achievement(id: 'a1', title: 'First Steps', description: 'Complete your first lesson', icon: Icons.flag, color: Color(0xFF6C63FF), unlockedAt: 'Jan 15, 2026', isUnlocked: true, progress: 1, maxProgress: 1),
        Achievement(id: 'a2', title: 'Week Warrior', description: 'Maintain a 7-day streak', icon: Icons.local_fire_department, color: Color(0xFFFF9F43), unlockedAt: 'Feb 2, 2026', isUnlocked: true, progress: 7, maxProgress: 7),
        Achievement(id: 'a3', title: 'Code Ninja', description: 'Complete 50 coding challenges', icon: Icons.code, color: Color(0xFF00D2D3), unlockedAt: null, isUnlocked: false, progress: 32, maxProgress: 50),
        Achievement(id: 'a4', title: 'Portfolio Pro', description: 'Build 5 portfolio projects', icon: Icons.workspace_premium, color: Color(0xFFFF6B9D), unlockedAt: null, isUnlocked: false, progress: 3, maxProgress: 5),
        Achievement(id: 'a5', title: 'Skill Master', description: 'Score 90%+ on 10 skill tests', icon: Icons.psychology, color: Color(0xFFA8E06C), unlockedAt: 'Mar 10, 2026', isUnlocked: true, progress: 10, maxProgress: 10),
        Achievement(id: 'a6', title: 'Job Hunter', description: 'Apply to 20 jobs', icon: Icons.work, color: Color(0xFF4A9EFF), unlockedAt: null, isUnlocked: false, progress: 12, maxProgress: 20),
        Achievement(id: 'a7', title: 'Knowledge Seeker', description: 'Complete all roadmaps', icon: Icons.menu_book, color: Color(0xFFFFD93D), unlockedAt: null, isUnlocked: false, progress: 2, maxProgress: 6),
        Achievement(id: 'a8', title: 'Open Source Hero', description: 'Contribute to 5 open source repos', icon: Icons.code_rounded, color: Color(0xFF8B83FF), unlockedAt: null, isUnlocked: false, progress: 1, maxProgress: 5),
        Achievement(id: 'a9', title: 'Fast Learner', description: 'Complete a roadmap in under a week', icon: Icons.speed, color: Color(0xFFFF6B9D), unlockedAt: 'Apr 5, 2026', isUnlocked: true, progress: 1, maxProgress: 1),
        Achievement(id: 'a10', title: 'Community Star', description: 'Get 100 helpful votes on reviews', icon: Icons.star, color: Color(0xFFFFD93D), unlockedAt: null, isUnlocked: false, progress: 67, maxProgress: 100),
        Achievement(id: 'a11', title: 'Tool Explorer', description: 'Try 15 AI tools', icon: Icons.smart_toy, color: Color(0xFF00D2D3), unlockedAt: null, isUnlocked: false, progress: 8, maxProgress: 15),
        Achievement(id: 'a12', title: 'Full Stack Legend', description: 'Complete all full stack projects', icon: Icons.layers, color: Color(0xFFFF9F43), unlockedAt: null, isUnlocked: false, progress: 1, maxProgress: 4),
      ];

  List<HistoryItem> getHistory() => [
        HistoryItem(id: 'h1', title: 'Flutter State Management', subtitle: 'Completed lesson in Learning Hub', type: HistoryItemType.lesson, timestamp: '2 hours ago', icon: Icons.school),
        HistoryItem(id: 'h2', title: 'Senior Flutter Developer at Google', subtitle: 'Applied for this position', type: HistoryItemType.job, timestamp: '5 hours ago', icon: Icons.work),
        HistoryItem(id: 'h3', title: 'ChatGPT Review', subtitle: 'Read review on AI Tools Directory', type: HistoryItemType.article, timestamp: '1 day ago', icon: Icons.article),
        HistoryItem(id: 'h4', title: 'Weather Dashboard Project', subtitle: 'Started building guide', type: HistoryItemType.project, timestamp: '1 day ago', icon: Icons.folder),
        HistoryItem(id: 'h5', title: 'Flutter Quiz: Advanced', subtitle: 'Scored 92% - Passed!', type: HistoryItemType.quiz, timestamp: '2 days ago', icon: Icons.quiz),
        HistoryItem(id: 'h6', title: 'React Skill Test', subtitle: 'Scored 85/100', type: HistoryItemType.skillTest, timestamp: '3 days ago', icon: Icons.psychology),
        HistoryItem(id: 'h7', title: 'AI Assistant Chat', subtitle: 'Discussed Flutter architecture patterns', type: HistoryItemType.aiChat, timestamp: '3 days ago', icon: Icons.auto_awesome),
        HistoryItem(id: 'h8', title: 'Node.js Roadmap', subtitle: 'Completed Module 3: APIs', type: HistoryItemType.lesson, timestamp: '4 days ago', icon: Icons.school),
        HistoryItem(id: 'h9', title: 'Frontend Developer at Meta', subtitle: 'Applied for this position', type: HistoryItemType.job, timestamp: '5 days ago', icon: Icons.work),
        HistoryItem(id: 'h10', title: 'REST API Project', subtitle: 'Completed build guide step 5/7', type: HistoryItemType.project, timestamp: '1 week ago', icon: Icons.folder),
      ];

  List<BookmarkItem> getBookmarkedJobs() => const [
        BookmarkItem(id: 'bj1', title: 'Senior Flutter Developer', subtitle: 'Google • Mountain View, CA • \$180K-\$250K', category: 'Job', savedAt: '2 days ago', icon: Icons.work),
        BookmarkItem(id: 'bj2', title: 'Full Stack Engineer', subtitle: 'Meta • Remote • \$150K-\$220K', category: 'Job', savedAt: '4 days ago', icon: Icons.work),
        BookmarkItem(id: 'bj3', title: 'Mobile Developer', subtitle: 'Apple • Cupertino, CA • \$170K-\$240K', category: 'Job', savedAt: '1 week ago', icon: Icons.work),
        BookmarkItem(id: 'bj4', title: 'Flutter Developer', subtitle: 'Startup • San Francisco • \$120K-\$180K', category: 'Job', savedAt: '2 weeks ago', icon: Icons.work),
      ];

  List<BookmarkItem> getBookmarkedArticles() => const [
        BookmarkItem(id: 'ba1', title: 'Flutter vs React Native 2026', subtitle: 'Comprehensive comparison guide', category: 'Article', savedAt: '1 day ago', icon: Icons.article),
        BookmarkItem(id: 'ba2', title: 'State Management in Flutter', subtitle: 'Complete guide to Riverpod, Bloc, and more', category: 'Article', savedAt: '3 days ago', icon: Icons.article),
        BookmarkItem(id: 'ba3', title: 'Building Scalable APIs with Node.js', subtitle: 'Best practices and patterns', category: 'Article', savedAt: '1 week ago', icon: Icons.article),
      ];

  List<BookmarkItem> getBookmarkedProjects() => const [
        BookmarkItem(id: 'bp1', title: 'E-Commerce Mobile App', subtitle: 'Flutter • Firebase • Stripe • 4-6 weeks', category: 'Project', savedAt: '2 days ago', icon: Icons.folder),
        BookmarkItem(id: 'bp2', title: 'REST API with Auth', subtitle: 'Node.js • Express • MongoDB • 2-3 weeks', category: 'Project', savedAt: '5 days ago', icon: Icons.folder),
        BookmarkItem(id: 'bp3', title: 'Real-Time Chat App', subtitle: 'React • Socket.io • PostgreSQL • 4-5 weeks', category: 'Project', savedAt: '1 week ago', icon: Icons.folder),
        BookmarkItem(id: 'bp4', title: 'ML Image Classifier', subtitle: 'Python • TensorFlow • Flask • 6-8 weeks', category: 'Project', savedAt: '2 weeks ago', icon: Icons.folder),
      ];

  LearningStats getLearningStats() => const LearningStats(
    totalLessonsCompleted: 47,
    totalHoursLearned: 126,
    currentStreak: 12,
    longestStreak: 28,
    coursesCompleted: 3,
    quizzesPassed: 18,
    skillsLearned: 14,
    weeklyProgress: [1.5, 2.0, 1.0, 3.0, 2.5, 1.5, 2.0],
    monthlyProgress: [8.0, 12.0, 15.0, 10.0, 18.0, 14.0, 20.0, 16.0, 22.0, 19.0, 25.0, 21.0],
  );

  GitHubStats getGitHubStats() => const GitHubStats(
    totalRepos: 24,
    totalStars: 156,
    totalCommits: 842,
    totalPRs: 38,
    totalIssues: 67,
    contributionStreak: 45,
    topLanguages: [
      LanguageStat(name: 'Dart', percentage: 35, color: Color(0xFF00D2D3)),
      LanguageStat(name: 'JavaScript', percentage: 25, color: Color(0xFFFFD93D)),
      LanguageStat(name: 'Python', percentage: 20, color: Color(0xFF4A9EFF)),
      LanguageStat(name: 'TypeScript', percentage: 12, color: Color(0xFF6C63FF)),
      LanguageStat(name: 'Other', percentage: 8, color: Color(0xFFFF9F43)),
    ],
    recentActivity: [
      'Pushed 3 commits to snapshot-flutter',
      'Opened PR #42 in react-dashboard',
      'Starred flutter/riverpod',
      'Completed GitHub contribution streak: 45 days',
      'Created new repo: ai-tools-api',
    ],
  );

  ResumeScore getResumeScore() => const ResumeScore(
    overallScore: 82,
    atsScore: 88,
    readabilityScore: 76,
    keywordScore: 85,
    formatScore: 79,
    suggestions: [
      'Add more quantified achievements (e.g., "Improved app performance by 40%")',
      'Include relevant keywords: CI/CD, Docker, AWS',
      'Add a professional summary section at the top',
      'Use more action verbs: Architected, Optimized, Delivered',
      'List certifications (AWS, Google Cloud, etc.)',
    ],
    sectionScores: [
      SectionScore(name: 'Contact Info', score: 95, color: Color(0xFF6C63FF)),
      SectionScore(name: 'Experience', score: 85, color: Color(0xFF00D2D3)),
      SectionScore(name: 'Skills', score: 80, color: Color(0xFFFF9F43)),
      SectionScore(name: 'Projects', score: 78, color: Color(0xFFFF6B9D)),
      SectionScore(name: 'Education', score: 90, color: Color(0xFF4A9EFF)),
    ],
  );

  List<ThemeSetting> getThemeSettings() => const [
        ThemeSetting(id: 'system', label: 'System Default', icon: Icons.brightness_auto, isActive: true),
        ThemeSetting(id: 'light', label: 'Light Mode', icon: Icons.light_mode, isActive: false),
        ThemeSetting(id: 'dark', label: 'Dark Mode', icon: Icons.dark_mode, isActive: false),
      ];
}
