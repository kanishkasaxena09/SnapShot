import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/route_names.dart';

enum OnboardingStep {
  profileSetup,
  interests,
  technologies,
  careerGoal,
  experienceLevel,
  uploadResume,
}

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  static const totalSteps = 6;

  int get currentStep => state;
  int get progress => ((state + 1) / totalSteps * 100).round();
  bool get isFirstStep => state == 0;
  bool get isLastStep => state == totalSteps - 1;

  void nextStep() {
    if (state < totalSteps - 1) {
      state++;
    }
  }

  void previousStep() {
    if (state > 0) {
      state--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      state = step;
    }
  }

  void reset() {
    state = 0;
  }
}

final onboardingStepProvider =
    StateNotifierProvider<OnboardingNotifier, int>((ref) {
  return OnboardingNotifier();
});

String onboardingRouteForStep(int step) {
  switch (step) {
    case 0:
      return RouteNames.profileSetup;
    case 1:
      return RouteNames.interestSelection;
    case 2:
      return RouteNames.technologySelection;
    case 3:
      return RouteNames.careerGoal;
    case 4:
      return RouteNames.experienceLevel;
    case 5:
      return RouteNames.uploadResume;
    default:
      return RouteNames.profileSetup;
  }
}
