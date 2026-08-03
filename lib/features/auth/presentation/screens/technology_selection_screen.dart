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

class TechnologySelectionScreen extends ConsumerStatefulWidget {
  const TechnologySelectionScreen({super.key});

  @override
  ConsumerState<TechnologySelectionScreen> createState() =>
      _TechnologySelectionScreenState();
}

class _TechnologySelectionScreenState
    extends ConsumerState<TechnologySelectionScreen> {
  static const _technologies = [
    'Python',
    'JavaScript',
    'TypeScript',
    'Dart',
    'Flutter',
    'React',
    'React Native',
    'Angular',
    'Vue.js',
    'Node.js',
    'Django',
    'FastAPI',
    'Spring Boot',
    'Express.js',
    'Next.js',
    'AWS',
    'Azure',
    'GCP',
    'Docker',
    'Kubernetes',
    'Firebase',
    'Supabase',
    'PostgreSQL',
    'MongoDB',
    'Redis',
    'GraphQL',
    'REST APIs',
    'Git',
    'Linux',
    'TensorFlow',
    'PyTorch',
    'OpenCV',
    'Rust',
    'Go',
    'Java',
    'C++',
    'Swift',
    'Kotlin',
    'HTML/CSS',
    'Tailwind CSS',
  ];

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(onboardingStepProvider);
    final profileNotifier = ref.read(profileSetupProvider.notifier);
    final profile = ref.watch(profileSetupProvider);
    final selected = profile?.technologies.toSet() ?? {};

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
                      title: 'Tech Stack',
                      subtitle:
                          'Select technologies you work with or want to learn',
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
                      options: _technologies,
                      selected: selected,
                      onToggle: (tech) {
                        profileNotifier.toggleTechnology(tech);
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
