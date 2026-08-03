import '../models/user_model.dart';
import '../models/user_model.dart' as model;
import '../../domain/entities/user_entity.dart' as entity;

extension UserModelMapper on UserModel {
  entity.UserEntity toEntity() {
    return entity.UserEntity(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      bio: bio,
      phoneNumber: phoneNumber,
      username: username,
      location: location,
      website: website,
      githubUsername: githubUsername,
      resumeUrl: resumeUrl,
      interests: interests,
      technologies: technologies,
      socialLinks: socialLinks,
      careerGoal: careerGoal?.toEntity(),
      experienceLevel: experienceLevel?.toEntity(),
      isEmailVerified: isEmailVerified,
      isProfileComplete: isProfileComplete,
      isOnboarded: isOnboarded,
      isGithubConnected: isGithubConnected,
      hasResume: hasResume,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastLoginAt: lastLoginAt,
    );
  }
}

extension UserEntityMapper on entity.UserEntity {
  UserModel toModel() {
    return UserModel(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      bio: bio,
      phoneNumber: phoneNumber,
      username: username,
      location: location,
      website: website,
      githubUsername: githubUsername,
      resumeUrl: resumeUrl,
      interests: interests,
      technologies: technologies,
      socialLinks: socialLinks,
      careerGoal: careerGoal?.toModel(),
      experienceLevel: experienceLevel?.toModel(),
      isEmailVerified: isEmailVerified,
      isProfileComplete: isProfileComplete,
      isOnboarded: isOnboarded,
      isGithubConnected: isGithubConnected,
      hasResume: hasResume,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastLoginAt: lastLoginAt,
    );
  }
}

extension _CareerGoalModel on model.CareerGoal {
  entity.CareerGoal toEntity() {
    return entity.CareerGoal.values.firstWhere((e) => e.name == name);
  }
}

extension _ExperienceLevelModel on model.ExperienceLevel {
  entity.ExperienceLevel toEntity() {
    return entity.ExperienceLevel.values.firstWhere((e) => e.name == name);
  }
}

extension _CareerGoalEntity on entity.CareerGoal {
  model.CareerGoal toModel() {
    return model.CareerGoal.values.firstWhere((e) => e.name == name);
  }
}

extension _ExperienceLevelEntity on entity.ExperienceLevel {
  model.ExperienceLevel toModel() {
    return model.ExperienceLevel.values.firstWhere((e) => e.name == name);
  }
}
