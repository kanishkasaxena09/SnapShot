import 'package:flutter/material.dart';
import '../../domain/entities/learning_entities.dart';
import '../../../../core/theme/app_colors.dart';

class LearningLocalDataSource {
  List<LearningRoadmap> getRoadmaps() {
    return [
      LearningRoadmap(
        id: 'rm1',
        title: 'Flutter Developer',
        description: 'Master Flutter from basics to advanced app development',
        icon: Icons.phone_android,
        color: AppColors.primaryLight,
        totalSteps: 5,
        completedSteps: 3,
        estimatedTime: '12 weeks',
        difficulty: DifficultyLevel.intermediate,
        steps: [
          const RoadmapStep(id: 'rms1', title: 'Dart Fundamentals', description: 'Learn Dart syntax, types, and async programming', isCompleted: true, lessonId: 'l1'),
          const RoadmapStep(id: 'rms2', title: 'Widget Tree & Layouts', description: 'Understand widget composition and layout systems', isCompleted: true, lessonId: 'l2'),
          const RoadmapStep(id: 'rms3', title: 'State Management', description: 'Explore Provider, Riverpod, and Bloc patterns', isCompleted: true, lessonId: 'l3'),
          const RoadmapStep(id: 'rms4', title: 'Navigation & Routing', description: 'Master navigation patterns and deep linking', isCompleted: false, isCurrent: true),
          const RoadmapStep(id: 'rms5', title: 'Testing & Deployment', description: 'Write tests and deploy to app stores', isCompleted: false),
        ],
      ),
      LearningRoadmap(
        id: 'rm2',
        title: 'AI/ML Engineer',
        description: 'Build intelligent systems with machine learning',
        icon: Icons.psychology,
        color: AppColors.accentBlue,
        totalSteps: 4,
        completedSteps: 1,
        estimatedTime: '16 weeks',
        difficulty: DifficultyLevel.advanced,
        steps: [
          const RoadmapStep(id: 'rms6', title: 'Python & NumPy', description: 'Data manipulation and numerical computing', isCompleted: true, lessonId: 'l5'),
          const RoadmapStep(id: 'rms7', title: 'Linear Algebra Refresher', description: 'Vectors, matrices, and transformations', isCompleted: false, isCurrent: true),
          const RoadmapStep(id: 'rms8', title: 'Neural Networks', description: 'Build and train neural networks from scratch', isCompleted: false),
          const RoadmapStep(id: 'rms9', title: 'Model Deployment', description: 'Deploy models to production with TensorFlow Lite', isCompleted: false),
        ],
      ),
      LearningRoadmap(
        id: 'rm3',
        title: 'Backend Developer',
        description: 'Build scalable server-side applications and APIs',
        icon: Icons.dns,
        color: AppColors.secondaryLight,
        totalSteps: 4,
        completedSteps: 2,
        estimatedTime: '10 weeks',
        difficulty: DifficultyLevel.intermediate,
        steps: [
          const RoadmapStep(id: 'rms10', title: 'REST API Design', description: 'Design and build RESTful APIs', isCompleted: true, lessonId: 'l7'),
          const RoadmapStep(id: 'rms11', title: 'Database Design', description: 'SQL, NoSQL, and data modeling', isCompleted: true, lessonId: 'l8'),
          const RoadmapStep(id: 'rms12', title: 'Authentication & Security', description: 'JWT, OAuth, and security best practices', isCompleted: false, isCurrent: true),
          const RoadmapStep(id: 'rms13', title: 'Microservices Architecture', description: 'Design and implement microservices', isCompleted: false),
        ],
      ),
      LearningRoadmap(
        id: 'rm4',
        title: 'DevOps',
        description: 'Automate infrastructure and streamline deployments',
        icon: Icons.settings,
        color: AppColors.accentOrange,
        totalSteps: 3,
        completedSteps: 0,
        estimatedTime: '8 weeks',
        difficulty: DifficultyLevel.intermediate,
        isLocked: true,
        steps: [
          const RoadmapStep(id: 'rms14', title: 'Docker & Containers', description: 'Containerize applications with Docker', isCompleted: false, isCurrent: true),
          const RoadmapStep(id: 'rms15', title: 'CI/CD Pipelines', description: 'Set up continuous integration and deployment', isCompleted: false),
          const RoadmapStep(id: 'rms16', title: 'Kubernetes Basics', description: 'Orchestrate containers at scale', isCompleted: false),
        ],
      ),
      LearningRoadmap(
        id: 'rm5',
        title: 'System Design',
        description: 'Learn to architect large-scale distributed systems',
        icon: Icons.architecture,
        color: AppColors.accentPink,
        totalSteps: 5,
        completedSteps: 2,
        estimatedTime: '14 weeks',
        difficulty: DifficultyLevel.advanced,
        steps: [
          const RoadmapStep(id: 'rms17', title: 'Scalability Fundamentals', description: 'Horizontal vs vertical scaling', isCompleted: true, lessonId: 'l11'),
          const RoadmapStep(id: 'rms18', title: 'Load Balancing', description: 'Distribute traffic across servers', isCompleted: true, lessonId: 'l12'),
          const RoadmapStep(id: 'rms19', title: 'Caching Strategies', description: 'Redis, Memcached, and cache invalidation', isCompleted: false, isCurrent: true),
          const RoadmapStep(id: 'rms20', title: 'Message Queues', description: 'Kafka, RabbitMQ, and event-driven systems', isCompleted: false),
          const RoadmapStep(id: 'rms21', title: 'Database Sharding', description: 'Partition data across multiple databases', isCompleted: false),
        ],
      ),
      LearningRoadmap(
        id: 'rm6',
        title: 'Open Source',
        description: 'Contribute to open source projects effectively',
        icon: Icons.code,
        color: AppColors.accentCyan,
        totalSteps: 4,
        completedSteps: 1,
        estimatedTime: '6 weeks',
        difficulty: DifficultyLevel.beginner,
        steps: [
          const RoadmapStep(id: 'rms22', title: 'Git & GitHub', description: 'Version control and collaboration workflows', isCompleted: true, lessonId: 'l9'),
          const RoadmapStep(id: 'rms23', title: 'Finding Projects', description: 'Discover beginner-friendly open source projects', isCompleted: false, isCurrent: true),
          const RoadmapStep(id: 'rms24', title: 'Making PRs', description: 'Write good pull requests and handle reviews', isCompleted: false),
          const RoadmapStep(id: 'rms25', title: 'Building Community', description: 'Engage with maintainers and grow your network', isCompleted: false),
        ],
      ),
    ];
  }

  List<LearningLesson> getLessons() {
    return [
      const LearningLesson(id: 'l1', title: 'Dart Fundamentals', description: 'Master the Dart programming language from scratch', category: 'Frontend', difficulty: DifficultyLevel.beginner, durationMinutes: 45, totalModules: 8, completedModules: 8, author: 'Sarah Chen', rating: 4.8, enrolledCount: 12500, tags: ['dart', 'programming', 'basics'], thumbnailColor: '0xFF6C63FF'),
      const LearningLesson(id: 'l2', title: 'Flutter Widget Mastery', description: 'Deep dive into Flutter widgets and custom compositions', category: 'Mobile', difficulty: DifficultyLevel.intermediate, durationMinutes: 60, totalModules: 10, completedModules: 6, author: 'James Wilson', rating: 4.7, enrolledCount: 9800, tags: ['flutter', 'widgets', 'ui'], thumbnailColor: '0xFF00D9A6'),
      const LearningLesson(id: 'l3', title: 'State Management Patterns', description: 'Learn Provider, Riverpod, Bloc, and GetX patterns', category: 'Mobile', difficulty: DifficultyLevel.advanced, durationMinutes: 90, totalModules: 12, completedModules: 4, author: 'Sarah Chen', rating: 4.9, enrolledCount: 8200, tags: ['state-management', 'riverpod', 'bloc'], thumbnailColor: '0xFFFF6B6B'),
      const LearningLesson(id: 'l4', title: 'Python for ML', description: 'Python programming essentials for machine learning', category: 'AI', difficulty: DifficultyLevel.beginner, durationMinutes: 55, totalModules: 9, completedModules: 3, author: 'Dr. Aisha Patel', rating: 4.6, enrolledCount: 15000, tags: ['python', 'machine-learning', 'basics'], thumbnailColor: '0xFF4A9EFF'),
      const LearningLesson(id: 'l5', title: 'Neural Networks Deep Dive', description: 'Build neural networks from the ground up', category: 'AI', difficulty: DifficultyLevel.advanced, durationMinutes: 120, totalModules: 15, completedModules: 0, author: 'Dr. Aisha Patel', rating: 4.8, enrolledCount: 6500, tags: ['neural-networks', 'deep-learning', 'tensorflow'], thumbnailColor: '0xFFFF9F43'),
      const LearningLesson(id: 'l6', title: 'REST API with Node.js', description: 'Build production-ready REST APIs with Express', category: 'Backend', difficulty: DifficultyLevel.intermediate, durationMinutes: 70, totalModules: 11, completedModules: 7, author: 'Mike Rodriguez', rating: 4.5, enrolledCount: 11000, tags: ['nodejs', 'express', 'rest-api'], thumbnailColor: '0xFF00D2D3'),
      const LearningLesson(id: 'l7', title: 'Database Design Masterclass', description: 'SQL and NoSQL database design best practices', category: 'Backend', difficulty: DifficultyLevel.intermediate, durationMinutes: 65, totalModules: 10, completedModules: 2, author: 'Mike Rodriguez', rating: 4.7, enrolledCount: 9500, tags: ['database', 'sql', 'mongodb'], thumbnailColor: '0xFFA8E06C'),
      const LearningLesson(id: 'l8', title: 'Docker for Developers', description: 'Containerize your applications with Docker', category: 'DevOps', difficulty: DifficultyLevel.beginner, durationMinutes: 50, totalModules: 8, completedModules: 0, author: 'Alex Kim', rating: 4.6, enrolledCount: 13000, tags: ['docker', 'containers', 'devops'], thumbnailColor: '0xFFFFD93D'),
      const LearningLesson(id: 'l9', title: 'CI/CD Pipeline Setup', description: 'Automate testing and deployment with GitHub Actions', category: 'DevOps', difficulty: DifficultyLevel.intermediate, durationMinutes: 45, totalModules: 7, completedModules: 0, author: 'Alex Kim', rating: 4.4, enrolledCount: 7800, tags: ['ci-cd', 'github-actions', 'automation'], thumbnailColor: '0xFF6C63FF'),
      const LearningLesson(id: 'l10', title: 'System Design Interview Prep', description: 'Ace system design interviews with real-world examples', category: 'System Design', difficulty: DifficultyLevel.advanced, durationMinutes: 100, totalModules: 14, completedModules: 5, author: 'Priya Sharma', rating: 4.9, enrolledCount: 5600, tags: ['system-design', 'interview', 'architecture'], thumbnailColor: '0xFFFF6B9D'),
      const LearningLesson(id: 'l11', title: 'Scalable Architecture Patterns', description: 'Design patterns for building scalable systems', category: 'System Design', difficulty: DifficultyLevel.advanced, durationMinutes: 85, totalModules: 12, completedModules: 1, author: 'Priya Sharma', rating: 4.8, enrolledCount: 4200, tags: ['architecture', 'scalability', 'patterns'], thumbnailColor: '0xFF8B83FF'),
      const LearningLesson(id: 'l12', title: 'GraphQL Complete Guide', description: 'From schema design to subscription handling', category: 'Backend', difficulty: DifficultyLevel.intermediate, durationMinutes: 75, totalModules: 11, completedModules: 0, author: 'Mike Rodriguez', rating: 4.6, enrolledCount: 8100, tags: ['graphql', 'api', 'backend'], thumbnailColor: '0xFF00D9A6'),
    ];
  }

  List<LearningVideo> getVideos() {
    return [
      const LearningVideo(id: 'v1', title: 'Flutter in 100 Seconds', description: 'Quick overview of the Flutter framework', channel: 'Fireship', durationMinutes: 2, viewCount: 1200000, publishedAt: '2025-01-15', category: 'Mobile', difficulty: DifficultyLevel.beginner, rating: 4.9, isWatched: true, thumbnailColor: '0xFF6C63FF'),
      const LearningVideo(id: 'v2', title: 'React vs Flutter vs Native', description: 'Comprehensive comparison of mobile dev frameworks', channel: 'Traversy Media', durationMinutes: 18, viewCount: 890000, publishedAt: '2025-03-02', category: 'Mobile', difficulty: DifficultyLevel.beginner, rating: 4.7, thumbnailColor: '0xFF4A9EFF'),
      const LearningVideo(id: 'v3', title: 'Neural Networks Explained', description: 'Visual introduction to how neural networks work', channel: '3Blue1Brown', durationMinutes: 25, viewCount: 2100000, publishedAt: '2024-11-20', category: 'AI', difficulty: DifficultyLevel.beginner, rating: 4.9, isWatched: true, thumbnailColor: '0xFFFF9F43'),
      const LearningVideo(id: 'v4', title: 'Docker Crash Course', description: 'Complete Docker tutorial for beginners', channel: 'Traversy Media', durationMinutes: 42, viewCount: 670000, publishedAt: '2025-02-10', category: 'DevOps', difficulty: DifficultyLevel.beginner, rating: 4.6, thumbnailColor: '0xFF00D2D3'),
      const LearningVideo(id: 'v5', title: 'System Design Primer', description: 'Learn system design fundamentals for interviews', channel: 'Fireship', durationMinutes: 12, viewCount: 1500000, publishedAt: '2025-04-05', category: 'System Design', difficulty: DifficultyLevel.intermediate, rating: 4.8, isWatched: true, thumbnailColor: '0xFFFF6B9D'),
      const LearningVideo(id: 'v6', title: 'Python Machine Learning', description: 'Build ML models with scikit-learn and TensorFlow', channel: 'freeCodeCamp', durationMinutes: 90, viewCount: 3200000, publishedAt: '2024-09-12', category: 'AI', difficulty: DifficultyLevel.intermediate, rating: 4.7, thumbnailColor: '0xFFA8E06C'),
      const LearningVideo(id: 'v7', title: 'Node.js Full Course', description: 'Complete Node.js backend development tutorial', channel: 'Fireship', durationMinutes: 35, viewCount: 980000, publishedAt: '2025-01-28', category: 'Backend', difficulty: DifficultyLevel.intermediate, rating: 4.5, thumbnailColor: '0xFF00D9A6'),
      const LearningVideo(id: 'v8', title: 'Git & GitHub Crash Course', description: 'Everything you need to know about Git in 30 minutes', channel: 'Traversy Media', durationMinutes: 32, viewCount: 4500000, publishedAt: '2024-08-05', category: 'Frontend', difficulty: DifficultyLevel.beginner, rating: 4.8, isWatched: true, thumbnailColor: '0xFFFFD93D'),
      const LearningVideo(id: 'v9', title: 'Kubernetes Tutorial', description: 'Learn Kubernetes from scratch with practical examples', channel: 'TechWorld with Nana', durationMinutes: 55, viewCount: 780000, publishedAt: '2025-05-10', category: 'DevOps', difficulty: DifficultyLevel.intermediate, rating: 4.6, thumbnailColor: '0xFF8B83FF'),
      const LearningVideo(id: 'v10', title: 'GraphQL Tutorial', description: 'Build a GraphQL API with Apollo Server', channel: 'Academind', durationMinutes: 48, viewCount: 560000, publishedAt: '2025-02-20', category: 'Backend', difficulty: DifficultyLevel.intermediate, rating: 4.5, thumbnailColor: '0xFFFF6B6B'),
      const LearningVideo(id: 'v11', title: 'Advanced Flutter Animations', description: 'Create stunning animations and transitions in Flutter', channel: 'Robert Brunhage', durationMinutes: 28, viewCount: 340000, publishedAt: '2025-06-01', category: 'Mobile', difficulty: DifficultyLevel.advanced, rating: 4.7, thumbnailColor: '0xFF6C63FF'),
      const LearningVideo(id: 'v12', title: 'LLMs Explained Simply', description: 'How large language models work under the hood', channel: 'Fireship', durationMinutes: 8, viewCount: 1800000, publishedAt: '2025-04-18', category: 'AI', difficulty: DifficultyLevel.intermediate, rating: 4.9, isWatched: true, thumbnailColor: '0xFFFF9F43'),
    ];
  }

  List<LearningNote> getNotes() {
    return [
      LearningNote(id: 'n1', title: 'Dart Cheat Sheet', content: 'Quick reference for Dart syntax and core libraries', category: 'Frontend', difficulty: DifficultyLevel.beginner, pageCount: 8, readTimeMinutes: 10, isBookmarked: true, lastUpdated: DateTime(2025, 6, 15), author: 'Sarah Chen', tags: ['dart', 'reference']),
      LearningNote(id: 'n2', title: 'Flutter Layout Guide', content: 'Complete guide to Row, Column, Stack, and Flex layouts', category: 'Mobile', difficulty: DifficultyLevel.intermediate, pageCount: 12, readTimeMinutes: 15, isBookmarked: false, lastUpdated: DateTime(2025, 5, 22), author: 'James Wilson', tags: ['flutter', 'layout', 'widgets']),
      LearningNote(id: 'n3', title: 'Riverpod Patterns', content: 'Common patterns and anti-patterns in Riverpod', category: 'Mobile', difficulty: DifficultyLevel.advanced, pageCount: 10, readTimeMinutes: 12, isBookmarked: true, lastUpdated: DateTime(2025, 4, 10), author: 'Sarah Chen', tags: ['riverpod', 'state-management']),
      LearningNote(id: 'n4', title: 'Python ML Libraries', content: 'Overview of NumPy, Pandas, and Scikit-learn', category: 'AI', difficulty: DifficultyLevel.beginner, pageCount: 15, readTimeMinutes: 20, isBookmarked: false, lastUpdated: DateTime(2025, 3, 8), author: 'Dr. Aisha Patel', tags: ['python', 'numpy', 'pandas']),
      LearningNote(id: 'n5', title: 'Neural Network Architectures', content: 'CNNs, RNNs, Transformers, and when to use each', category: 'AI', difficulty: DifficultyLevel.advanced, pageCount: 18, readTimeMinutes: 25, isBookmarked: false, lastUpdated: DateTime(2025, 6, 1), author: 'Dr. Aisha Patel', tags: ['neural-networks', 'architecture']),
      LearningNote(id: 'n6', title: 'REST API Best Practices', content: 'Design principles and conventions for RESTful APIs', category: 'Backend', difficulty: DifficultyLevel.intermediate, pageCount: 9, readTimeMinutes: 12, isBookmarked: true, lastUpdated: DateTime(2025, 2, 14), author: 'Mike Rodriguez', tags: ['rest', 'api', 'backend']),
      LearningNote(id: 'n7', title: 'SQL Query Optimization', content: 'Tips and tricks for writing efficient SQL queries', category: 'Backend', difficulty: DifficultyLevel.intermediate, pageCount: 11, readTimeMinutes: 14, isBookmarked: false, lastUpdated: DateTime(2025, 5, 30), author: 'Mike Rodriguez', tags: ['sql', 'database', 'optimization']),
      LearningNote(id: 'n8', title: 'Docker Commands', content: 'Essential Docker commands every developer should know', category: 'DevOps', difficulty: DifficultyLevel.beginner, pageCount: 6, readTimeMinutes: 8, isBookmarked: false, lastUpdated: DateTime(2025, 1, 20), author: 'Alex Kim', tags: ['docker', 'commands']),
      LearningNote(id: 'n9', title: 'Kubernetes Manifests', content: 'How to write and understand K8s YAML manifests', category: 'DevOps', difficulty: DifficultyLevel.advanced, pageCount: 14, readTimeMinutes: 18, isBookmarked: false, lastUpdated: DateTime(2025, 4, 25), author: 'Alex Kim', tags: ['kubernetes', 'yaml', 'manifests']),
      LearningNote(id: 'n10', title: 'System Design Notes', content: 'Core concepts for system design interviews', category: 'System Design', difficulty: DifficultyLevel.intermediate, pageCount: 20, readTimeMinutes: 30, isBookmarked: true, lastUpdated: DateTime(2025, 6, 10), author: 'Priya Sharma', tags: ['system-design', 'interview']),
      LearningNote(id: 'n11', title: 'Design Patterns in Flutter', content: 'Singleton, Factory, Observer, and Builder patterns for Flutter', category: 'Mobile', difficulty: DifficultyLevel.advanced, pageCount: 13, readTimeMinutes: 16, isBookmarked: false, lastUpdated: DateTime(2025, 3, 18), author: 'James Wilson', tags: ['design-patterns', 'flutter']),
      LearningNote(id: 'n12', title: 'CI/CD with GitHub Actions', content: 'Step-by-step guide to setting up CI/CD pipelines', category: 'DevOps', difficulty: DifficultyLevel.intermediate, pageCount: 7, readTimeMinutes: 9, isBookmarked: false, lastUpdated: DateTime(2025, 5, 5), author: 'Alex Kim', tags: ['ci-cd', 'github-actions']),
    ];
  }

  List<LearningCheatSheet> getCheatSheets() {
    return [
      const LearningCheatSheet(id: 'cs1', title: 'Dart Syntax', category: 'Frontend', color: AppColors.primaryLight, itemCount: 45, readTimeMinutes: 8, difficulty: DifficultyLevel.beginner, isBookmarked: true, lastUpdated: '2025-06-10'),
      const LearningCheatSheet(id: 'cs2', title: 'Flutter Widgets', category: 'Mobile', color: AppColors.secondaryLight, itemCount: 60, readTimeMinutes: 10, difficulty: DifficultyLevel.intermediate, isBookmarked: false, lastUpdated: '2025-05-15'),
      const LearningCheatSheet(id: 'cs3', title: 'Python NumPy', category: 'AI', color: AppColors.accentBlue, itemCount: 35, readTimeMinutes: 6, difficulty: DifficultyLevel.beginner, isBookmarked: false, lastUpdated: '2025-04-20'),
      const LearningCheatSheet(id: 'cs4', title: 'TensorFlow Commands', category: 'AI', color: AppColors.accentOrange, itemCount: 50, readTimeMinutes: 9, difficulty: DifficultyLevel.advanced, isBookmarked: true, lastUpdated: '2025-06-05'),
      const LearningCheatSheet(id: 'cs5', title: 'Express.js Routes', category: 'Backend', color: AppColors.accentCyan, itemCount: 40, readTimeMinutes: 7, difficulty: DifficultyLevel.intermediate, isBookmarked: false, lastUpdated: '2025-03-22'),
      const LearningCheatSheet(id: 'cs6', title: 'SQL Queries', category: 'Backend', color: AppColors.accentLime, itemCount: 55, readTimeMinutes: 8, difficulty: DifficultyLevel.intermediate, isBookmarked: false, lastUpdated: '2025-02-18'),
      const LearningCheatSheet(id: 'cs7', title: 'Docker CLI', category: 'DevOps', color: AppColors.accentPink, itemCount: 30, readTimeMinutes: 5, difficulty: DifficultyLevel.beginner, isBookmarked: true, lastUpdated: '2025-01-30'),
      const LearningCheatSheet(id: 'cs8', title: 'Kubernetes Commands', category: 'DevOps', color: AppColors.primaryDark, itemCount: 42, readTimeMinutes: 7, difficulty: DifficultyLevel.advanced, isBookmarked: false, lastUpdated: '2025-04-12'),
      const LearningCheatSheet(id: 'cs9', title: 'Git Commands', category: 'Frontend', color: AppColors.accentYellow, itemCount: 38, readTimeMinutes: 6, difficulty: DifficultyLevel.beginner, isBookmarked: false, lastUpdated: '2025-05-28'),
      const LearningCheatSheet(id: 'cs10', title: 'GraphQL Schema', category: 'Backend', color: AppColors.tertiaryLight, itemCount: 33, readTimeMinutes: 5, difficulty: DifficultyLevel.intermediate, isBookmarked: false, lastUpdated: '2025-06-12'),
      const LearningCheatSheet(id: 'cs11', title: 'System Design Concepts', category: 'System Design', color: AppColors.infoLight, itemCount: 48, readTimeMinutes: 10, difficulty: DifficultyLevel.advanced, isBookmarked: true, lastUpdated: '2025-03-05'),
      const LearningCheatSheet(id: 'cs12', title: 'Flutter Animation Props', category: 'Mobile', color: AppColors.successLight, itemCount: 28, readTimeMinutes: 4, difficulty: DifficultyLevel.advanced, isBookmarked: false, lastUpdated: '2025-02-10'),
    ];
  }

  List<DailyChallenge> getDailyChallenges() {
    return [
      DailyChallenge(id: 'dc1', title: 'Widget of the Day', description: 'Build a responsive card component using only Flutter widgets', category: 'Mobile', difficulty: DifficultyLevel.beginner, points: 50, timeLimitMinutes: 15, status: ChallengeStatus.completed, completedAt: '2025-06-20 14:30', expiresAt: DateTime.now().add(const Duration(hours: 6))),
      DailyChallenge(id: 'dc2', title: 'API Integration Sprint', description: 'Fetch data from a public API and display it in a list', category: 'Backend', difficulty: DifficultyLevel.intermediate, points: 100, timeLimitMinutes: 30, status: ChallengeStatus.active, expiresAt: DateTime.now().add(const Duration(hours: 12))),
      DailyChallenge(id: 'dc3', title: 'ML Model Training', description: 'Train a simple classification model on the Iris dataset', category: 'AI', difficulty: DifficultyLevel.intermediate, points: 120, timeLimitMinutes: 25, status: ChallengeStatus.pending, expiresAt: DateTime.now().add(const Duration(hours: 18))),
      DailyChallenge(id: 'dc4', title: 'SQL Query Challenge', description: 'Write optimized queries to solve 5 database problems', category: 'Backend', difficulty: DifficultyLevel.advanced, points: 150, timeLimitMinutes: 20, status: ChallengeStatus.failed, expiresAt: DateTime.now().add(const Duration(hours: 2))),
      DailyChallenge(id: 'dc5', title: 'Docker Build Race', description: 'Create an optimized multi-stage Dockerfile under 10 minutes', category: 'DevOps', difficulty: DifficultyLevel.intermediate, points: 80, timeLimitMinutes: 10, status: ChallengeStatus.pending, expiresAt: DateTime.now().add(const Duration(hours: 8))),
      DailyChallenge(id: 'dc6', title: 'System Design Quickfire', description: 'Design a URL shortener system in under 20 minutes', category: 'System Design', difficulty: DifficultyLevel.advanced, points: 200, timeLimitMinutes: 20, status: ChallengeStatus.active, expiresAt: DateTime.now().add(const Duration(hours: 4))),
    ];
  }

  List<LearningQuiz> getQuizzes() {
    return [
      const LearningQuiz(id: 'q1', title: 'Dart Basics Quiz', description: 'Test your knowledge of Dart fundamentals', category: 'Frontend', difficulty: DifficultyLevel.beginner, questionCount: 15, timeLimitMinutes: 20, passingScore: 70, isCompleted: true, bestScore: 92, rating: 4.5, attemptCount: 2),
      const LearningQuiz(id: 'q2', title: 'Flutter Widgets Quiz', description: 'Challenge yourself on Flutter widget knowledge', category: 'Mobile', difficulty: DifficultyLevel.intermediate, questionCount: 20, timeLimitMinutes: 25, passingScore: 75, isCompleted: true, bestScore: 88, rating: 4.7, attemptCount: 1),
      const LearningQuiz(id: 'q3', title: 'State Management Quiz', description: 'Advanced quiz on state management solutions', category: 'Mobile', difficulty: DifficultyLevel.advanced, questionCount: 25, timeLimitMinutes: 30, passingScore: 80, isCompleted: false, rating: 4.6, attemptCount: 0),
      const LearningQuiz(id: 'q4', title: 'Python for ML Quiz', description: 'Test your Python and ML fundamentals', category: 'AI', difficulty: DifficultyLevel.beginner, questionCount: 15, timeLimitMinutes: 20, passingScore: 70, isCompleted: true, bestScore: 95, rating: 4.8, attemptCount: 3),
      const LearningQuiz(id: 'q5', title: 'Neural Networks Quiz', description: 'Deep learning concepts and implementations', category: 'AI', difficulty: DifficultyLevel.advanced, questionCount: 30, timeLimitMinutes: 40, passingScore: 80, isCompleted: false, rating: 4.9, attemptCount: 0),
      const LearningQuiz(id: 'q6', title: 'REST API Design Quiz', description: 'RESTful API design principles and best practices', category: 'Backend', difficulty: DifficultyLevel.intermediate, questionCount: 18, timeLimitMinutes: 22, passingScore: 75, isCompleted: true, bestScore: 82, rating: 4.4, attemptCount: 2),
      const LearningQuiz(id: 'q7', title: 'Database Fundamentals Quiz', description: 'SQL queries, normalization, and indexing', category: 'Backend', difficulty: DifficultyLevel.intermediate, questionCount: 20, timeLimitMinutes: 25, passingScore: 70, isCompleted: false, rating: 4.5, attemptCount: 0),
      const LearningQuiz(id: 'q8', title: 'Docker Essentials Quiz', description: 'Docker concepts, commands, and best practices', category: 'DevOps', difficulty: DifficultyLevel.beginner, questionCount: 12, timeLimitMinutes: 15, passingScore: 65, isCompleted: true, bestScore: 90, rating: 4.3, attemptCount: 1),
      const LearningQuiz(id: 'q9', title: 'CI/CD Knowledge Check', description: 'Continuous integration and deployment concepts', category: 'DevOps', difficulty: DifficultyLevel.intermediate, questionCount: 15, timeLimitMinutes: 20, passingScore: 75, isCompleted: false, rating: 4.6, attemptCount: 0),
      const LearningQuiz(id: 'q10', title: 'System Design Quiz', description: 'Architecture patterns and scalability concepts', category: 'System Design', difficulty: DifficultyLevel.advanced, questionCount: 25, timeLimitMinutes: 35, passingScore: 80, isCompleted: true, bestScore: 78, rating: 4.8, attemptCount: 2),
      const LearningQuiz(id: 'q11', title: 'GraphQL Quiz', description: 'Schema design, resolvers, and subscriptions', category: 'Backend', difficulty: DifficultyLevel.intermediate, questionCount: 18, timeLimitMinutes: 22, passingScore: 70, isCompleted: false, rating: 4.5, attemptCount: 0),
      const LearningQuiz(id: 'q12', title: 'Git & GitHub Quiz', description: 'Version control concepts and workflows', category: 'Frontend', difficulty: DifficultyLevel.beginner, questionCount: 12, timeLimitMinutes: 15, passingScore: 65, isCompleted: true, bestScore: 98, rating: 4.7, attemptCount: 1),
    ];
  }

  List<LearningCertificate> getCertificates() {
    return [
      LearningCertificate(id: 'cert1', title: 'Flutter Developer', issuer: 'Snapshot Academy', issuedDate: DateTime(2025, 5, 20), expiryDate: DateTime(2027, 5, 20), credentialId: 'FL-2025-0520-A1', credentialUrl: 'https://snapshot.academy/verify/FL-2025-0520-A1', color: AppColors.primaryLight),
      LearningCertificate(id: 'cert2', title: 'Python for ML', issuer: 'Snapshot Academy', issuedDate: DateTime(2025, 4, 10), expiryDate: DateTime(2027, 4, 10), credentialId: 'PY-ML-2025-0410-B2', credentialUrl: 'https://snapshot.academy/verify/PY-ML-2025-0410-B2', color: AppColors.accentBlue),
      LearningCertificate(id: 'cert3', title: 'REST API Design', issuer: 'Backend Mastery', issuedDate: DateTime(2025, 3, 5), expiryDate: DateTime(2026, 3, 5), credentialId: 'BA-REST-2025-0305-C3', color: AppColors.secondaryLight),
      LearningCertificate(id: 'cert4', title: 'Docker Fundamentals', issuer: 'DevOps Institute', issuedDate: DateTime(2025, 2, 15), expiryDate: DateTime(2026, 2, 15), credentialId: 'DO-DCR-2025-0215-D4', credentialUrl: 'https://devops.institute/verify/DO-DCR-2025-0215-D4', color: AppColors.accentCyan),
      LearningCertificate(id: 'cert5', title: 'Git Expert', issuer: 'Snapshot Academy', issuedDate: DateTime(2024, 12, 20), expiryDate: DateTime(2025, 12, 20), credentialId: 'GH-EXP-2024-1220-E5', credentialUrl: 'https://snapshot.academy/verify/GH-EXP-2024-1220-E5', color: AppColors.accentOrange),
      LearningCertificate(id: 'cert6', title: 'System Design Pro', issuer: 'Tech Masters', issuedDate: DateTime(2025, 6, 1), expiryDate: DateTime(2027, 6, 1), credentialId: 'SD-PRO-2025-0601-F6', color: AppColors.accentPink),
    ];
  }

  List<LearningAchievement> getAchievements() {
    return [
      LearningAchievement(id: 'a1', title: 'First Steps', description: 'Complete your first lesson', icon: Icons.star, color: AppColors.accentYellow, rarity: AchievementRarity.common, isUnlocked: true, unlockedAt: DateTime(2025, 1, 10), progress: 1, totalRequired: 1),
      LearningAchievement(id: 'a2', title: 'Week Warrior', description: 'Study for 7 consecutive days', icon: Icons.local_fire_department, color: AppColors.tertiaryLight, rarity: AchievementRarity.common, isUnlocked: true, unlockedAt: DateTime(2025, 2, 5), progress: 7, totalRequired: 7),
      LearningAchievement(id: 'a3', title: 'Quiz Master', description: 'Score 90% or above on 5 quizzes', icon: Icons.emoji_events, color: AppColors.accentYellow, rarity: AchievementRarity.uncommon, isUnlocked: true, unlockedAt: DateTime(2025, 3, 15), progress: 5, totalRequired: 5),
      LearningAchievement(id: 'a4', title: 'Knowledge Collector', description: 'Save 10 lessons to your library', icon: Icons.bookmark, color: AppColors.primaryLight, rarity: AchievementRarity.uncommon, isUnlocked: false, progress: 6, totalRequired: 10),
      LearningAchievement(id: 'a5', title: 'Streak Champion', description: 'Maintain a 30-day learning streak', icon: Icons.bolt, color: AppColors.accentOrange, rarity: AchievementRarity.rare, isUnlocked: false, progress: 18, totalRequired: 30),
      LearningAchievement(id: 'a6', title: 'Category Explorer', description: 'Complete lessons in 5 different categories', icon: Icons.explore, color: AppColors.accentCyan, rarity: AchievementRarity.rare, isUnlocked: true, unlockedAt: DateTime(2025, 4, 20), progress: 5, totalRequired: 5),
      LearningAchievement(id: 'a7', title: 'Speed Learner', description: 'Complete 3 lessons in a single day', icon: Icons.speed, color: AppColors.successLight, rarity: AchievementRarity.common, isUnlocked: true, unlockedAt: DateTime(2025, 2, 28), progress: 3, totalRequired: 3),
      LearningAchievement(id: 'a8', title: 'Note Taker', description: 'Read 20 study notes', icon: Icons.note, color: AppColors.accentBlue, rarity: AchievementRarity.uncommon, isUnlocked: false, progress: 14, totalRequired: 20),
      LearningAchievement(id: 'a9', title: 'Video Binger', description: 'Watch 15 educational videos', icon: Icons.play_circle, color: AppColors.accentPink, rarity: AchievementRarity.rare, isUnlocked: false, progress: 9, totalRequired: 15),
      LearningAchievement(id: 'a10', title: 'Certificate Collector', description: 'Earn 10 certificates', icon: Icons.workspace_premium, color: AppColors.accentYellow, rarity: AchievementRarity.epic, isUnlocked: false, progress: 4, totalRequired: 10),
      LearningAchievement(id: 'a11', title: 'Full Stack Hero', description: 'Complete all Backend and Frontend roadmaps', icon: Icons.code, color: AppColors.primaryDark, rarity: AchievementRarity.epic, isUnlocked: false, progress: 1, totalRequired: 2),
      LearningAchievement(id: 'a12', title: 'Legend of Learning', description: 'Reach level 50 and earn all certificates', icon: Icons.diamond, color: AppColors.accentPink, rarity: AchievementRarity.legendary, isUnlocked: false, progress: 0, totalRequired: 1),
    ];
  }

  LearningStreak getStreakData() {
    final calendarDays = List.generate(30, (i) {
      final isActive = i < 5 || (i > 8 && i < 12) || (i > 15 && i < 20);
      return StreakDay(
        date: DateTime.now().subtract(Duration(days: i)),
        minutesStudied: isActive ? 15 + (i * 3) % 45 : 0,
        isActive: isActive,
      );
    });

    return LearningStreak(
      currentStreak: 12,
      longestStreak: 28,
      totalDaysStudied: 156,
      totalHoursStudied: 234,
      calendarDays: calendarDays,
      todayXP: 120,
      weeklyXP: 840,
      totalXP: 12450,
      level: 24,
      xpToNextLevel: 500,
    );
  }

  List<LearningLesson> searchLessons(String query) {
    final lessons = getLessons();
    if (query.isEmpty) return lessons;
    final lowerQuery = query.toLowerCase();
    return lessons.where((lesson) {
      return lesson.title.toLowerCase().contains(lowerQuery) ||
          lesson.description.toLowerCase().contains(lowerQuery) ||
          lesson.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
