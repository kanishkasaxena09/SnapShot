import 'package:flutter/material.dart';

class GithubRepository {

  const GithubRepository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.owner,
    required this.ownerAvatar,
    required this.language,
    required this.languageColor,
    required this.stars,
    required this.forks,
    required this.openIssues,
    required this.watchers,
    required this.createdAt,
    required this.updatedAt,
    required this.license,
    required this.isFork,
    required this.isArchived,
    required this.topics,
    this.homepage,
    required this.commitActivity,
    required this.goodFirstIssues,
    required this.languageDistribution,
  });
  final String id;
  final String name;
  final String fullName;
  final String description;
  final String owner;
  final String ownerAvatar;
  final String language;
  final Color languageColor;
  final int stars;
  final int forks;
  final int openIssues;
  final int watchers;
  final String createdAt;
  final String updatedAt;
  final String license;
  final bool isFork;
  final bool isArchived;
  final List<String> topics;
  final String? homepage;
  final List<CommitActivity> commitActivity;
  final List<Issue> goodFirstIssues;
  final LanguageDistribution languageDistribution;

  String get starsFormatted => _formatNumber(stars);
  String get forksFormatted => _formatNumber(forks);

  static String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}

class GithubDeveloper {

  const GithubDeveloper({
    required this.id,
    required this.username,
    required this.displayName,
    required this.avatar,
    this.bio,
    this.company,
    this.location,
    this.website,
    required this.followers,
    required this.following,
    required this.publicRepos,
    required this.contributions,
    required this.contributionGraph,
    required this.popularRepos,
    required this.topLanguages,
    required this.isSponsored,
  });
  final String id;
  final String username;
  final String displayName;
  final String avatar;
  final String? bio;
  final String? company;
  final String? location;
  final String? website;
  final int followers;
  final int following;
  final int publicRepos;
  final int contributions;
  final List<ContributionDay> contributionGraph;
  final List<GithubRepository> popularRepos;
  final List<String> topLanguages;
  final bool isSponsored;
}

class ContributionDay {

  const ContributionDay({required this.date, required this.count});
  final String date;
  final int count;
}

class CommitActivity {

  const CommitActivity({required this.week, required this.total, required this.daily});
  final String week;
  final int total;
  final List<int> daily;
}

class Issue {

  const Issue({
    required this.id,
    required this.title,
    required this.number,
    required this.body,
    required this.state,
    required this.createdAt,
    required this.labels,
    required this.author,
    required this.comments,
  });
  final String id;
  final String title;
  final String number;
  final String body;
  final String state;
  final String createdAt;
  final List<String> labels;
  final String author;
  final int comments;
}

class LanguageDistribution {

  const LanguageDistribution({required this.languages});
  final List<LanguagePercent> languages;
}

class LanguagePercent {

  const LanguagePercent({required this.name, required this.percent, required this.color});
  final String name;
  final double percent;
  final Color color;
}
