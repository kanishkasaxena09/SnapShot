import 'package:flutter/material.dart';

enum SkillLevel { beginner, intermediate, advanced, expert }

enum ImportSource { resume, github, linkedin, portfolio }

enum SkillCategoryType {
  frontend('Frontend', Icons.web_rounded, Color(0xFF6C5CE7)),
  backend('Backend', Icons.dns_rounded, Color(0xFF00B894)),
  mobile('Mobile', Icons.phone_android_rounded, Color(0xFF0984E3)),
  devops('DevOps', Icons.cloud_rounded, Color(0xFFE17055)),
  dataScience('Data Science', Icons.analytics_rounded, Color(0xFFFDCB6E)),
  design('Design', Icons.palette_rounded, Color(0xFFE84393)),
  softSkills('Soft Skills', Icons.people_rounded, Color(0xFF00CEC9));

  const SkillCategoryType(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class Skill {
  const Skill({
    required this.name,
    required this.category,
    required this.level,
    required this.proficiency,
    this.yearsOfExperience = 0,
    this.isHighlighted = false,
  });

  final String name;
  final SkillCategoryType category;
  final SkillLevel level;
  final double proficiency;
  final int yearsOfExperience;
  final bool isHighlighted;

  Skill copyWith({
    SkillLevel? level,
    double? proficiency,
    int? yearsOfExperience,
    bool? isHighlighted,
  }) {
    return Skill(
      name: name,
      category: category,
      level: level ?? this.level,
      proficiency: proficiency ?? this.proficiency,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }
}

class SkillCategory {
  const SkillCategory({
    required this.type,
    required this.skills,
    required this.averageProficiency,
  });

  final SkillCategoryType type;
  final List<Skill> skills;
  final double averageProficiency;
}

class ATSResult {
  const ATSResult({
    required this.score,
    required this.breakdown,
    required this.suggestions,
    required this.keywordsFound,
    required this.keywordsMissing,
  });

  final int score;
  final Map<String, int> breakdown;
  final List<String> suggestions;
  final List<String> keywordsFound;
  final List<String> keywordsMissing;
}

class MissingSkill {
  const MissingSkill({
    required this.name,
    required this.category,
    required this.importance,
    required this.reason,
  });

  final String name;
  final SkillCategoryType category;
  final String importance;
  final String reason;
}

class CourseRecommendation {
  const CourseRecommendation({
    required this.title,
    required this.provider,
    required this.skillTarget,
    required this.rating,
    required this.duration,
    required this.difficulty,
    required this.url,
  });

  final String title;
  final String provider;
  final String skillTarget;
  final double rating;
  final String duration;
  final String difficulty;
  final String url;
}

class CareerSuggestion {
  const CareerSuggestion({
    required this.title,
    required this.matchPercentage,
    required this.requiredSkills,
    required this.yourMatchingSkills,
    required this.salaryRange,
    required this.growthRate,
    required this.description,
  });

  final String title;
  final int matchPercentage;
  final List<String> requiredSkills;
  final List<String> yourMatchingSkills;
  final String salaryRange;
  final String growthRate;
  final String description;
}

class SalaryEstimate {
  const SalaryEstimate({
    required this.role,
    required this.minSalary,
    required this.maxSalary,
    required this.medianSalary,
    required this.location,
    required this.experienceLevel,
  });

  final String role;
  final int minSalary;
  final int maxSalary;
  final int medianSalary;
  final String location;
  final String experienceLevel;
}

class LearningStep {
  const LearningStep({
    required this.title,
    required this.description,
    required this.duration,
    required this.resources,
    required this.isCompleted,
    required this.skills,
  });

  final String title;
  final String description;
  final String duration;
  final List<String> resources;
  final bool isCompleted;
  final List<String> skills;
}

class LearningPlan {
  const LearningPlan({
    required this.title,
    required this.totalDuration,
    required this.steps,
    required this.targetRole,
  });

  final String title;
  final String totalDuration;
  final List<LearningStep> steps;
  final String targetRole;
}

class SkillAnalysis {
  const SkillAnalysis({
    required this.overallScore,
    required this.categories,
    required this.atsResult,
    required this.missingSkills,
    required this.courseRecommendations,
    required this.careerSuggestions,
    required this.salaryEstimate,
    required this.learningPlan,
    required this.sources,
  });

  final int overallScore;
  final List<SkillCategory> categories;
  final ATSResult atsResult;
  final List<MissingSkill> missingSkills;
  final List<CourseRecommendation> courseRecommendations;
  final List<CareerSuggestion> careerSuggestions;
  final SalaryEstimate salaryEstimate;
  final LearningPlan learningPlan;
  final List<ImportSource> sources;
}
