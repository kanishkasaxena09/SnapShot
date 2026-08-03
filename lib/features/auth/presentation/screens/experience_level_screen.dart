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

class ExperienceLevelScreen extends ConsumerWidget {
  const ExperienceLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(onboardingStepProvider);
    final profile = ref.watch(profileSetupProvider);
    final selectedLevel = profile?.experienceLevel;

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
                      title: 'Experience Level',
                      subtitle:
                          'This helps us recommend the right opportunities for you',
                      currentStep: currentStep,
                      totalSteps: 6,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SingleSelectionList(
                      options: const [
                        SelectionOption(
                          id: 'student',
                          title: 'Student',
                          subtitle: 'Currently studying',
                          icon: Icons.school_rounded,
                        ),
                        SelectionOption(
                          id: 'fresher',
                          title: 'Fresher / Graduate',
                          subtitle: '0-1 years of experience',
                          icon: Icons.waving_hand_rounded,
                        ),
                        SelectionOption(
                          id: 'junior',
                          title: 'Junior Developer',
                          subtitle: '1-3 years of experience',
                          icon: Icons.code_rounded,
                        ),
                        SelectionOption(
                          id: 'midLevel',
                          title: 'Mid-Level Developer',
                          subtitle: '3-5 years of experience',
                          icon: Icons.developer_board_rounded,
                        ),
                        SelectionOption(
                          id: 'senior',
                          title: 'Senior Developer',
                          subtitle: '5-10 years of experience',
                          icon: Icons.engineering_rounded,
                        ),
                        SelectionOption(
                          id: 'lead',
                          title: 'Tech Lead',
                          subtitle: '10+ years, leading teams',
                          icon: Icons.groups_rounded,
                        ),
                        SelectionOption(
                          id: 'executive',
                          title: 'Executive / CTO',
                          subtitle: 'C-level or VP of Engineering',
                          icon: Icons.business_center_rounded,
                        ),
                      ],
                      selectedId: selectedLevel?.name,
                      onSelected: (id) {
                        final level = ExperienceLevel.values.firstWhere(
                          (l) => l.name == id,
                        );
                        ref
                            .read(profileSetupProvider.notifier)
                            .setExperienceLevel(level);
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
                isPrimaryEnabled: selectedLevel != null,
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
