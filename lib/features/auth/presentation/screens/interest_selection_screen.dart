import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../presentation/providers/profile_setup_provider.dart';
import '../widgets/auth_header.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/selection_widgets.dart';
import '../widgets/step_indicator.dart';

class InterestSelectionScreen extends ConsumerStatefulWidget {
  const InterestSelectionScreen({super.key});

  @override
  ConsumerState<InterestSelectionScreen> createState() =>
      _InterestSelectionScreenState();
}

class _InterestSelectionScreenState
    extends ConsumerState<InterestSelectionScreen> {
  static const _interests = [
    'Artificial Intelligence',
    'Machine Learning',
    'Web Development',
    'Mobile Development',
    'Cloud Computing',
    'Cybersecurity',
    'DevOps',
    'Data Science',
    'Blockchain',
    'Game Development',
    'UI/UX Design',
    'Backend Development',
    'Frontend Development',
    'Full Stack Development',
    'Internet of Things',
    'AR/VR',
    'Robotics',
    'Open Source',
    'Technical Writing',
    'Product Management',
  ];

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(onboardingStepProvider);
    final profileNotifier = ref.read(profileSetupProvider.notifier);
    final profile = ref.watch(profileSetupProvider);
    final selected = profile?.interests.toSet() ?? {};

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              ref.read(onboardingStepProvider.notifier).nextStep();
              context.go(onboardingRouteForStep(ref.read(onboardingStepProvider)));
            },
            child: const Text('Skip'),
          ),
        ],
      ),
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
                      title: 'Your Interests',
                      subtitle:
                          'Select topics you are interested in to personalize your feed',
                      currentStep: currentStep,
                      totalSteps: 6,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    if (selected.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: Text(
                          '${selected.length} selected',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    SelectionGrid(
                      options: _interests,
                      selected: selected,
                      onToggle: (interest) {
                        profileNotifier.toggleInterest(interest);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child:               AuthBottomBar(
                primaryLabel: 'Continue',
                isPrimaryEnabled: selected.isNotEmpty,
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
