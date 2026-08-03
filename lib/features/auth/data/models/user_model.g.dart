// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String? ?? '',
  photoUrl: json['photoUrl'] as String? ?? '',
  bio: json['bio'] as String? ?? '',
  phoneNumber: json['phoneNumber'] as String?,
  username: json['username'] as String? ?? '',
  location: json['location'] as String? ?? '',
  website: json['website'] as String? ?? '',
  githubUsername: json['githubUsername'] as String?,
  resumeUrl: json['resumeUrl'] as String?,
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  socialLinks:
      (json['socialLinks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  careerGoal: $enumDecodeNullable(_$CareerGoalEnumMap, json['careerGoal']),
  experienceLevel: $enumDecodeNullable(
    _$ExperienceLevelEnumMap,
    json['experienceLevel'],
  ),
  isEmailVerified: json['isEmailVerified'] as bool? ?? false,
  isProfileComplete: json['isProfileComplete'] as bool? ?? false,
  isOnboarded: json['isOnboarded'] as bool? ?? false,
  isGithubConnected: json['isGithubConnected'] as bool? ?? false,
  hasResume: json['hasResume'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  lastLoginAt: json['last_login_at'] == null
      ? null
      : DateTime.parse(json['last_login_at'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'bio': instance.bio,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'location': instance.location,
      'website': instance.website,
      'githubUsername': instance.githubUsername,
      'resumeUrl': instance.resumeUrl,
      'interests': instance.interests,
      'technologies': instance.technologies,
      'socialLinks': instance.socialLinks,
      'careerGoal': _$CareerGoalEnumMap[instance.careerGoal],
      'experienceLevel': _$ExperienceLevelEnumMap[instance.experienceLevel],
      'isEmailVerified': instance.isEmailVerified,
      'isProfileComplete': instance.isProfileComplete,
      'isOnboarded': instance.isOnboarded,
      'isGithubConnected': instance.isGithubConnected,
      'hasResume': instance.hasResume,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
    };

const _$CareerGoalEnumMap = {
  CareerGoal.jobSeeker: 'jobSeeker',
  CareerGoal.freelancer: 'freelancer',
  CareerGoal.openSourceContributor: 'openSourceContributor',
  CareerGoal.entrepreneur: 'entrepreneur',
  CareerGoal.student: 'student',
  CareerGoal.researcher: 'researcher',
  CareerGoal.educator: 'educator',
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.student: 'student',
  ExperienceLevel.fresher: 'fresher',
  ExperienceLevel.junior: 'junior',
  ExperienceLevel.midLevel: 'midLevel',
  ExperienceLevel.senior: 'senior',
  ExperienceLevel.lead: 'lead',
  ExperienceLevel.executive: 'executive',
};
