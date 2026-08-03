import 'package:flutter/material.dart';

enum JobType { fullTime, partTime, contract, internship, remote }

enum JobExperience { entry, mid, senior, lead, executive }

enum ApplicationStatus { submitted, reviewing, shortlisted, interviewScheduled, offered, rejected, withdrawn }

enum JobCategory {
  softwareEngineering,
  dataScience,
  design,
  product,
  marketing,
  finance,
  devops,
  cybersecurity,
  aiMl,
  mobile,
}

class Company {

  const Company({
    required this.id,
    required this.name,
    required this.logo,
    required this.industry,
    required this.size,
    required this.founded,
    required this.headquarters,
    required this.website,
    required this.description,
    required this.techStack,
    required this.rating,
    required this.reviewCount,
    required this.isVerified,
  });
  final String id;
  final String name;
  final String logo;
  final String industry;
  final String size;
  final String founded;
  final String headquarters;
  final String website;
  final String description;
  final List<String> techStack;
  final double rating;
  final int reviewCount;
  final bool isVerified;
}

class Job {

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.requirements,
    required this.responsibilities,
    required this.benefits,
    required this.skills,
    required this.type,
    required this.experience,
    required this.category,
    required this.salaryMin,
    required this.salaryMax,
    required this.salaryCurrency,
    required this.postedDate,
    required this.deadline,
    required this.isRemote,
    required this.isUrgent,
    required this.applicants,
    required this.aiMatchScore,
    required this.isSaved,
  });
  final String id;
  final String title;
  final Company company;
  final String location;
  final String description;
  final List<String> requirements;
  final List<String> responsibilities;
  final List<String> benefits;
  final List<String> skills;
  final JobType type;
  final JobExperience experience;
  final JobCategory category;
  final double salaryMin;
  final double salaryMax;
  final String salaryCurrency;
  final String postedDate;
  final String deadline;
  final bool isRemote;
  final bool isUrgent;
  final int applicants;
  final double aiMatchScore;
  final bool isSaved;

  Job copyWith({bool? isSaved}) {
    return Job(
      id: id,
      title: title,
      company: company,
      location: location,
      description: description,
      requirements: requirements,
      responsibilities: responsibilities,
      benefits: benefits,
      skills: skills,
      type: type,
      experience: experience,
      category: category,
      salaryMin: salaryMin,
      salaryMax: salaryMax,
      salaryCurrency: salaryCurrency,
      postedDate: postedDate,
      deadline: deadline,
      isRemote: isRemote,
      isUrgent: isUrgent,
      applicants: applicants,
      aiMatchScore: aiMatchScore,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  String get salaryRange => '\$${(salaryMin / 1000).toStringAsFixed(0)}k - \$${(salaryMax / 1000).toStringAsFixed(0)}k';

  IconData get typeIcon {
    switch (type) {
      case JobType.fullTime:
        return Icons.work_rounded;
      case JobType.partTime:
        return Icons.schedule_rounded;
      case JobType.contract:
        return Icons.assignment_rounded;
      case JobType.internship:
        return Icons.school_rounded;
      case JobType.remote:
        return Icons.language_rounded;
    }
  }

  String get typeLabel {
    switch (type) {
      case JobType.fullTime:
        return 'Full Time';
      case JobType.partTime:
        return 'Part Time';
      case JobType.contract:
        return 'Contract';
      case JobType.internship:
        return 'Internship';
      case JobType.remote:
        return 'Remote';
    }
  }

  String get experienceLabel {
    switch (experience) {
      case JobExperience.entry:
        return 'Entry Level';
      case JobExperience.mid:
        return 'Mid Level';
      case JobExperience.senior:
        return 'Senior Level';
      case JobExperience.lead:
        return 'Lead';
      case JobExperience.executive:
        return 'Executive';
    }
  }
}

class JobApplication {

  const JobApplication({
    required this.id,
    required this.job,
    required this.status,
    required this.appliedDate,
    this.lastUpdated,
    this.interviewDate,
    this.notes,
  });
  final String id;
  final Job job;
  final ApplicationStatus status;
  final String appliedDate;
  final String? lastUpdated;
  final String? interviewDate;
  final String? notes;

  JobApplication copyWith({ApplicationStatus? status}) {
    return JobApplication(
      id: id,
      job: job,
      status: status ?? this.status,
      appliedDate: appliedDate,
      lastUpdated: lastUpdated,
      interviewDate: interviewDate,
      notes: notes,
    );
  }

  Color get statusColor {
    switch (status) {
      case ApplicationStatus.submitted:
        return const Color(0xFF2196F3);
      case ApplicationStatus.reviewing:
        return const Color(0xFFFF9800);
      case ApplicationStatus.shortlisted:
        return const Color(0xFF9C27B0);
      case ApplicationStatus.interviewScheduled:
        return const Color(0xFF00BCD4);
      case ApplicationStatus.offered:
        return const Color(0xFF4CAF50);
      case ApplicationStatus.rejected:
        return const Color(0xFFF44336);
      case ApplicationStatus.withdrawn:
        return const Color(0xFF9E9E9E);
    }
  }

  String get statusLabel {
    switch (status) {
      case ApplicationStatus.submitted:
        return 'Submitted';
      case ApplicationStatus.reviewing:
        return 'Under Review';
      case ApplicationStatus.shortlisted:
        return 'Shortlisted';
      case ApplicationStatus.interviewScheduled:
        return 'Interview Scheduled';
      case ApplicationStatus.offered:
        return 'Offered';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.withdrawn:
        return 'Withdrawn';
    }
  }

  IconData get statusIcon {
    switch (status) {
      case ApplicationStatus.submitted:
        return Icons.send_rounded;
      case ApplicationStatus.reviewing:
        return Icons.rate_review_rounded;
      case ApplicationStatus.shortlisted:
        return Icons.star_rounded;
      case ApplicationStatus.interviewScheduled:
        return Icons.event_rounded;
      case ApplicationStatus.offered:
        return Icons.check_circle_rounded;
      case ApplicationStatus.rejected:
        return Icons.cancel_rounded;
      case ApplicationStatus.withdrawn:
        return Icons.undo_rounded;
    }
  }
}

class JobAlert {

  const JobAlert({
    required this.id,
    required this.title,
    required this.keywords,
    this.category,
    this.location,
    this.type,
    this.minSalary,
    required this.isActive,
    required this.createdAt,
    required this.matchCount,
  });
  final String id;
  final String title;
  final String keywords;
  final JobCategory? category;
  final String? location;
  final JobType? type;
  final double? minSalary;
  final bool isActive;
  final String createdAt;
  final int matchCount;

  JobAlert copyWith({bool? isActive}) {
    return JobAlert(
      id: id,
      title: title,
      keywords: keywords,
      category: category,
      location: location,
      type: type,
      minSalary: minSalary,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      matchCount: matchCount,
    );
  }
}

class SalaryInsight {

  const SalaryInsight({
    required this.title,
    required this.average,
    required this.min,
    required this.max,
    required this.p25,
    required this.p75,
    required this.byExperience,
    required this.byLocation,
  });
  final String title;
  final double average;
  final double min;
  final double max;
  final double p25;
  final double p75;
  final List<SalaryByExperience> byExperience;
  final List<SalaryByLocation> byLocation;
}

class SalaryByExperience {

  const SalaryByExperience({required this.experience, required this.salary});
  final String experience;
  final double salary;
}

class SalaryByLocation {

  const SalaryByLocation({required this.location, required this.salary});
  final String location;
  final double salary;
}

class JobFilter {

  const JobFilter({
    this.types = const [],
    this.experiences = const [],
    this.categories = const [],
    this.minSalary,
    this.maxSalary,
    this.remoteOnly = false,
    this.location,
    this.sortBy,
  });
  final List<JobType> types;
  final List<JobExperience> experiences;
  final List<JobCategory> categories;
  final double? minSalary;
  final double? maxSalary;
  final bool remoteOnly;
  final String? location;
  final String? sortBy;

  JobFilter copyWith({
    List<JobType>? types,
    List<JobExperience>? experiences,
    List<JobCategory>? categories,
    double? minSalary,
    double? maxSalary,
    bool? remoteOnly,
    String? location,
    String? sortBy,
    bool clearMinSalary = false,
    bool clearMaxSalary = false,
    bool clearLocation = false,
    bool clearSortBy = false,
  }) {
    return JobFilter(
      types: types ?? this.types,
      experiences: experiences ?? this.experiences,
      categories: categories ?? this.categories,
      minSalary: clearMinSalary ? null : (minSalary ?? this.minSalary),
      maxSalary: clearMaxSalary ? null : (maxSalary ?? this.maxSalary),
      remoteOnly: remoteOnly ?? this.remoteOnly,
      location: clearLocation ? null : (location ?? this.location),
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
    );
  }

  bool get isEmpty =>
      types.isEmpty &&
      experiences.isEmpty &&
      categories.isEmpty &&
      minSalary == null &&
      maxSalary == null &&
      !remoteOnly &&
      location == null &&
      sortBy == null;

  int get activeCount {
    int count = 0;
    if (types.isNotEmpty) count++;
    if (experiences.isNotEmpty) count++;
    if (categories.isNotEmpty) count++;
    if (minSalary != null) count++;
    if (maxSalary != null) count++;
    if (remoteOnly) count++;
    if (location != null) count++;
    if (sortBy != null) count++;
    return count;
  }
}
