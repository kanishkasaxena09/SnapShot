import 'package:flutter/material.dart';

class NewsArticle {
  const NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.source,
    required this.timeAgo,
    this.imageUrl,
    this.category = 'Tech',
    this.isBreaking = false,
  });

  final String id;
  final String title;
  final String summary;
  final String source;
  final String timeAgo;
  final String? imageUrl;
  final String category;
  final bool isBreaking;
}

class TrendingTechnology {
  const TrendingTechnology({
    required this.name,
    required this.trendPercent,
    required this.icon,
    required this.color,
    this.description = '',
  });

  final String name;
  final double trendPercent;
  final IconData icon;
  final Color color;
  final String description;
}

class TrendingRepo {
  const TrendingRepo({
    required this.name,
    required this.fullName,
    required this.description,
    required this.language,
    required this.stars,
    required this.forks,
    required this.periodStars,
    required this.languageColor,
  });

  final String name;
  final String fullName;
  final String description;
  final String language;
  final int stars;
  final int forks;
  final int periodStars;
  final Color languageColor;
}

class AiTool {
  const AiTool({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.rating,
    required this.icon,
    required this.color,
    this.isNew = false,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final double rating;
  final IconData icon;
  final Color color;
  final bool isNew;
}

class ResearchPaper {
  const ResearchPaper({
    required this.id,
    required this.title,
    required this.authors,
    required this.abstract,
    required this.publishedDate,
    required this.category,
    this.citationCount = 0,
  });

  final String id;
  final String title;
  final String authors;
  final String abstract;
  final String publishedDate;
  final String category;
  final int citationCount;
}

class JobListing {
  const JobListing({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.postedAgo,
    this.type = 'Full-time',
    this.isRemote = false,
    this.isFeatured = false,
    required this.tags,
  });

  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String postedAgo;
  final String type;
  final bool isRemote;
  final bool isFeatured;
  final List<String> tags;
}

class Hackathon {
  const Hackathon({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.prizePool,
    required this.participants,
    required this.color,
    this.isOnline = true,
    this.registrationOpen = true,
  });

  final String id;
  final String name;
  final String description;
  final String startDate;
  final String prizePool;
  final int participants;
  final Color color;
  final bool isOnline;
  final bool registrationOpen;
}

class FeaturedProject {
  const FeaturedProject({
    required this.id,
    required this.title,
    required this.description,
    required this.stars,
    required this.forks,
    required this.techStack,
    required this.author,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final int stars;
  final int forks;
  final List<String> techStack;
  final String author;
  final String? imageUrl;
}

class LearningProgress {
  const LearningProgress({
    required this.id,
    required this.courseName,
    required this.category,
    required this.progress,
    required this.lastAccessed,
    required this.totalLessons,
    required this.completedLessons,
    required this.color,
  });

  final String id;
  final String courseName;
  final String category;
  final double progress;
  final String lastAccessed;
  final int totalLessons;
  final int completedLessons;
  final Color color;
}

class TechPulseStat {
  const TechPulseStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double? trend;
}

class QuickAction {
  const QuickAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String route;
}
