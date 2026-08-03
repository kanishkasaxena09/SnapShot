import 'package:flutter/material.dart';

enum ExploreCategory {
  ai('AI', Icons.smart_toy_rounded, Color(0xFF6C5CE7)),
  programming('Programming', Icons.code_rounded, Color(0xFF00B894)),
  cloud('Cloud', Icons.cloud_rounded, Color(0xFF0984E3)),
  cybersecurity('Cybersecurity', Icons.shield_rounded, Color(0xFFE17055)),
  devops('DevOps', Icons.settings_rounded, Color(0xFF00CEC9)),
  startups('Startups', Icons.rocket_launch_rounded, Color(0xFFFD79A8)),
  research('Research', Icons.science_rounded, Color(0xFFFDCB6E)),
  github('GitHub', Icons.code_rounded, Color(0xFF2D3436)),
  events('Events', Icons.event_rounded, Color(0xFFA29BFE));

  const ExploreCategory(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

enum ArticleSortBy { latest, popular, trending }

class ExploreArticle {
  const ExploreArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.author,
    required this.source,
    required this.publishedAt,
    required this.readTime,
    required this.category,
    this.tags = const [],
    this.imageUrl,
    this.isBookmarked = false,
    this.readingProgress = 0.0,
  });

  final String id;
  final String title;
  final String summary;
  final String content;
  final String author;
  final String source;
  final String publishedAt;
  final int readTime;
  final ExploreCategory category;
  final List<String> tags;
  final String? imageUrl;
  final bool isBookmarked;
  final double readingProgress;

  ExploreArticle copyWith({
    String? id,
    String? title,
    String? summary,
    String? content,
    String? author,
    String? source,
    String? publishedAt,
    int? readTime,
    ExploreCategory? category,
    List<String>? tags,
    String? imageUrl,
    bool? isBookmarked,
    double? readingProgress,
  }) {
    return ExploreArticle(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      author: author ?? this.author,
      source: source ?? this.source,
      publishedAt: publishedAt ?? this.publishedAt,
      readTime: readTime ?? this.readTime,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      readingProgress: readingProgress ?? this.readingProgress,
    );
  }
}
