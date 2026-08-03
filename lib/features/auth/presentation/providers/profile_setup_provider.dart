import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';

class ProfileSetupNotifier extends StateNotifier<UserEntity?> {
  ProfileSetupNotifier() : super(null);

  void init(UserEntity user) {
    state = user;
  }

  void updateName(String name) {
    if (state != null) {
      state = state!.copyWith(displayName: name);
    }
  }

  void updateBio(String bio) {
    if (state != null) {
      state = state!.copyWith(bio: bio);
    }
  }

  void updateAvatar(String url) {
    if (state != null) {
      state = state!.copyWith(photoUrl: url);
    }
  }

  void updateLocation(String location) {
    if (state != null) {
      state = state!.copyWith(location: location);
    }
  }

  void updateUsername(String username) {
    if (state != null) {
      state = state!.copyWith(username: username);
    }
  }

  void toggleInterest(String interest) {
    if (state == null) return;
    final interests = List<String>.from(state!.interests);
    if (interests.contains(interest)) {
      interests.remove(interest);
    } else {
      interests.add(interest);
    }
    state = state!.copyWith(interests: interests);
  }

  void toggleTechnology(String tech) {
    if (state == null) return;
    final techs = List<String>.from(state!.technologies);
    if (techs.contains(tech)) {
      techs.remove(tech);
    } else {
      techs.add(tech);
    }
    state = state!.copyWith(technologies: techs);
  }

  void setCareerGoal(CareerGoal goal) {
    if (state != null) {
      state = state!.copyWith(careerGoal: goal);
    }
  }

  void setExperienceLevel(ExperienceLevel level) {
    if (state != null) {
      state = state!.copyWith(experienceLevel: level);
    }
  }

  void updateGithub(String username) {
    if (state != null) {
      state = state!.copyWith(
        githubUsername: username,
        isGithubConnected: username.isNotEmpty,
      );
    }
  }

  void updateResume(String url) {
    if (state != null) {
      state = state!.copyWith(
        resumeUrl: url,
        hasResume: url.isNotEmpty,
      );
    }
  }

  void markProfileComplete() {
    if (state != null) {
      state = state!.copyWith(isProfileComplete: true);
    }
  }

  void markOnboarded() {
    if (state != null) {
      state = state!.copyWith(
        isOnboarded: true,
        isProfileComplete: true,
      );
    }
  }

  UserEntity? get currentUser => state;
}

final profileSetupProvider =
    StateNotifierProvider<ProfileSetupNotifier, UserEntity?>((ref) {
  return ProfileSetupNotifier();
});
