import 'package:flutter/material.dart';

enum ProjectDifficulty { easy, medium, hard, advanced }

enum ProjectCategory {
  webApp, mobileApp, apiBackend, fullStack, dataScience,
  machineLearning, devOps, gameDev, iot, blockchain
}

class BuildStep {
  const BuildStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    this.duration,
  });
  final int stepNumber;
  final String title;
  final String description;
  final String? duration;
}

class ProjectResource {
  const ProjectResource({
    required this.title,
    required this.url,
    required this.type,
  });
  final String title;
  final String url;
  final ResourceType type;
}

enum ResourceType { documentation, tutorial, video, article, github, tool }

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.difficulty,
    required this.category,
    required this.technologies,
    required this.githubLink,
    required this.portfolioValue,
    required this.estimatedTime,
    required this.buildSteps,
    required this.resources,
    required this.tags,
    required this.isFeatured,
    required this.isNew,
    required this.completionRate,
    required this.rating,
    required this.reviewCount,
    required this.heroColor,
    required this.icon,
  });
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final ProjectDifficulty difficulty;
  final ProjectCategory category;
  final List<String> technologies;
  final String githubLink;
  final int portfolioValue;
  final String estimatedTime;
  final List<BuildStep> buildSteps;
  final List<ProjectResource> resources;
  final List<String> tags;
  final bool isFeatured;
  final bool isNew;
  final int completionRate;
  final double rating;
  final int reviewCount;
  final Color heroColor;
  final IconData icon;
}

class ProjectRecommendation {
  const ProjectRecommendation({
    required this.project,
    required this.matchScore,
    required this.reasons,
  });
  final Project project;
  final int matchScore;
  final List<String> reasons;
}
