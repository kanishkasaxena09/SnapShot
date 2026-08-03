import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

enum AuthStatus { unauthenticated, authenticated, onboarded, profileIncomplete }

enum ExperienceLevel { student, fresher, junior, midLevel, senior, lead, executive }

enum CareerGoal { jobSeeker, freelancer, openSourceContributor, entrepreneur, student, researcher, educator }

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    required String email,
    @Default('') String displayName,
    @Default('') String photoUrl,
    @Default('') String bio,
    String? phoneNumber,
    @Default('') String username,
    @Default('') String location,
    @Default('') String website,
    String? githubUsername,
    String? resumeUrl,
    @Default([]) List<String> interests,
    @Default([]) List<String> technologies,
    @Default([]) List<String> socialLinks,
    CareerGoal? careerGoal,
    ExperienceLevel? experienceLevel,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isProfileComplete,
    @Default(false) bool isOnboarded,
    @Default(false) bool isGithubConnected,
    @Default(false) bool hasResume,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
  }) = _UserEntity;

  const UserEntity._();

  bool get isFullyOnboarded =>
      isProfileComplete &&
      isOnboarded &&
      interests.isNotEmpty &&
      technologies.isNotEmpty &&
      careerGoal != null &&
      experienceLevel != null;

  int get onboardingStep {
    if (isOnboarded) return -1;
    if (!isProfileComplete) return 0;
    if (interests.isEmpty) return 1;
    if (technologies.isEmpty) return 2;
    if (careerGoal == null) return 3;
    if (experienceLevel == null) return 4;
    return 5;
  }

  String get initials {
    final words = displayName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '?';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words.last[0]}'.toUpperCase();
  }
}
