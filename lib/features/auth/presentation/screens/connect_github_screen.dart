import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../presentation/providers/profile_setup_provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/step_indicator.dart';

class ConnectGithubScreen extends ConsumerStatefulWidget {
  const ConnectGithubScreen({super.key});

  @override
  ConsumerState<ConnectGithubScreen> createState() =>
      _ConnectGithubScreenState();
}

class _ConnectGithubScreenState extends ConsumerState<ConnectGithubScreen> {
  final _controller = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileSetupProvider);
    if (profile?.githubUsername != null) {
      _controller.text = profile!.githubUsername!;
      _isValid = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateUsername(String value) {
    setState(() {
      _isValid = value.trim().isNotEmpty &&
          RegExp(r'^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$')
              .hasMatch(value.trim());
    });
  }

  void _handleContinue() {
    ref
        .read(profileSetupProvider.notifier)
        .updateGithub(_controller.text.trim());
    ref.read(onboardingStepProvider.notifier).nextStep();
  }

  void _handleSkip() {
    ref.read(onboardingStepProvider.notifier).nextStep();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentStep = ref.watch(onboardingStepProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _handleSkip,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
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
                title: 'Connect GitHub',
                subtitle:
                    'Showcase your projects and contributions on your profile',
                currentStep: currentStep,
                totalSteps: 6,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // GitHub Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.code_rounded,
                    size: 40,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Username Field
              TextFormField(
                controller: _controller,
                onChanged: _validateUsername,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'GitHub Username',
                  hintText: 'e.g. octocat',
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                  prefixText: '@ ',
                  suffixIcon: _isValid
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: colorScheme.primary,
                        )
                      : null,
                  helperText: 'Letters, numbers, and hyphens only',
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Benefits
              _buildBenefits(context),
              const SizedBox(height: AppSpacing.xl),

              AuthBottomBar(
                primaryLabel: _isValid ? 'Connect & Continue' : 'Continue',
                isPrimaryEnabled: true,
                onPrimaryPressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefits(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final benefits = [
      'Display pinned repositories on your profile',
      'Show your contribution activity',
      'Let recruiters see your open source work',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits:',
          style: AppTypography.titleSmall(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...benefits.map((benefit) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      benefit,
                      style: AppTypography.bodySmall(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
