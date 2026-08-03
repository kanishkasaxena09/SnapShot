import 'package:flutter/material.dart';

enum PricingTier { free, freemium, paid, enterprise, contact }

enum AiToolCategory {
  llm, imageGeneration, codeAssist, productivity, video,
  audio, design, dataScience, writing, automation, research, translation
}

class AiTool {

  const AiTool({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.company,
    required this.website,
    required this.icon,
    required this.color,
    required this.category,
    required this.pricing,
    required this.priceDisplay,
    required this.rating,
    required this.reviewCount,
    required this.usageCount,
    required this.features,
    required this.useCases,
    required this.pros,
    required this.cons,
    required this.lastUpdated,
    required this.isVerified,
    required this.isNew,
    required this.isTrending,
    required this.alternatives,
    required this.pricingTiers,
  });
  final String id;
  final String name;
  final String tagline;
  final String description;
  final String company;
  final String website;
  final IconData icon;
  final Color color;
  final AiToolCategory category;
  final PricingTier pricing;
  final String priceDisplay;
  final double rating;
  final int reviewCount;
  final int usageCount;
  final List<String> features;
  final List<String> useCases;
  final List<String> pros;
  final List<String> cons;
  final String lastUpdated;
  final bool isVerified;
  final bool isNew;
  final bool isTrending;
  final List<String> alternatives;
  final Map<String, String> pricingTiers;
}

class AiToolReview {

  const AiToolReview({
    required this.id,
    required this.toolId,
    required this.userName,
    required this.userAvatar,
    required this.title,
    required this.content,
    required this.rating,
    required this.date,
    required this.helpfulCount,
    required this.isVerified,
  });
  final String id;
  final String toolId;
  final String userName;
  final String userAvatar;
  final String title;
  final String content;
  final double rating;
  final DateTime date;
  final int helpfulCount;
  final bool isVerified;
}

class AiToolCategoryInfo {

  const AiToolCategoryInfo({
    required this.category,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.toolCount,
  });
  final AiToolCategory category;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int toolCount;
}

class AiToolComparison {

  const AiToolComparison({
    required this.tools,
    required this.featureComparison,
    required this.ratingsByTool,
  });
  final List<AiTool> tools;
  final Map<String, List<String>> featureComparison;
  final Map<String, double> ratingsByTool;
}
