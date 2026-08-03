import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum ExperienceLevel { student, fresher, junior, midLevel, senior, lead, executive }

enum CareerGoal { jobSeeker, freelancer, openSourceContributor, entrepreneur, student, researcher, educator }

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
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
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
