import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/user_entity.dart';
import '../../presentation/providers/profile_setup_provider.dart';
import '../widgets/auth_header.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/selection_widgets.dart';
import '../widgets/step_indicator.dart';

class CareerGoalScreen extends ConsumerWidget {
  const CareerGoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(onboardingStepProvider);
    final profile = ref.watch(profileSetupProvider);
    final selectedGoal = profile?.careerGoal;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StepIndicator(
                      currentStep: currentStep,
                      totalSteps: 6,
                      constLabels: const [
                        'Profile',
                        'Interests',
                        'Tech',
                        'Goal',
                        'Level',
                        'Finish',
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    AuthHeader(
                      title: 'Career Goal',
                      subtitle:
                          'What are you primarily looking to achieve?',
                      currentStep: currentStep,
                      totalSteps: 6,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SingleSelectionList(
                      options: const [
                        SelectionOption(
                          id: 'jobSeeker',
                          title: 'Looking for a Job',
                          subtitle: 'Find full-time positions at companies',
                          icon: Icons.work_outline_rounded,
                        ),
                        SelectionOption(
                          id: 'freelancer',
                          title: 'Freelancing',
                          subtitle: 'Work independently with clients',
                          icon: Icons.laptop_mac_rounded,
                        ),
                        SelectionOption(
                          id: 'openSourceContributor',
                          title: 'Open Source Contributor',
                          subtitle: 'Contribute to open source projects',
                          icon: Icons.code_rounded,
                        ),
                        SelectionOption(
                          id: 'entrepreneur',
                          title: 'Building a Startup',
                          subtitle: 'Launch your own product or company',
                          icon: Icons.rocket_launch_rounded,
                        ),
                        SelectionOption(
                          id: 'student',
                          title: 'Learning & Student',
                          subtitle: 'Still studying and exploring tech',
                          icon: Icons.school_rounded,
                        ),
                        SelectionOption(
                          id: 'researcher',
                          title: 'Research',
                          subtitle: 'Academic or industry research',
                          icon: Icons.science_rounded,
                        ),
                        SelectionOption(
                          id: 'educator',
                          title: 'Teaching / Mentoring',
                          subtitle: 'Share knowledge and mentor others',
                          icon: Icons.menu_book_rounded,
                        ),
                      ],
                      selectedId: selectedGoal?.name,
                      onSelected: (id) {
                        final goal = CareerGoal.values.firstWhere(
                          (g) => g.name == id,
                        );
                        ref
                            .read(profileSetupProvider.notifier)
                            .setCareerGoal(goal);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: AuthBottomBar(
                primaryLabel: 'Continue',
                isPrimaryEnabled: selectedGoal != null,
                onPrimaryPressed: () {
                  ref.read(onboardingStepProvider.notifier).nextStep();
                  context.go(onboardingRouteForStep(ref.read(onboardingStepProvider)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
