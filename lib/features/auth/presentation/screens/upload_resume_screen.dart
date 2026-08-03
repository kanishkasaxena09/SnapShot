import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/profile_setup_provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/step_indicator.dart';

class UploadResumeScreen extends ConsumerStatefulWidget {
  const UploadResumeScreen({super.key});

  @override
  ConsumerState<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends ConsumerState<UploadResumeScreen> {
  XFile? _resumeFile;
  bool _isUploading = false;

  Future<void> _pickResume() async {
    final picker = ImagePicker();
    final file = await picker.pickMedia();
    if (file != null) {
      setState(() {
        _resumeFile = file;
        _isUploading = true;
      });

      // TODO: Upload to Firebase Storage
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() => _isUploading = false);
        ref.read(profileSetupProvider.notifier).updateResume(file.path);
      }
    }
  }

  void _handleContinue() {
    if (_resumeFile != null) {
      ref
          .read(profileSetupProvider.notifier)
          .updateResume(_resumeFile!.path);
    }
    ref.read(onboardingStepProvider.notifier).nextStep();
    context.go(onboardingRouteForStep(ref.read(onboardingStepProvider)));
  }

  void _handleSkip() {
    ref.read(onboardingStepProvider.notifier).nextStep();
    context.go(onboardingRouteForStep(ref.read(onboardingStepProvider)));
  }

  void _handleFinishOnboarding() async {
    final profile = ref.read(profileSetupProvider);
    if (profile != null) {
      ref.read(profileSetupProvider.notifier).markOnboarded();
      await ref.read(authProvider.notifier).completeOnboarding(profile);
      if (mounted) context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentStep = ref.watch(onboardingStepProvider);
    final isLastStep = currentStep == 5;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!isLastStep)
            TextButton(
              onPressed: _handleSkip,
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
                      title: isLastStep ? 'All Set!' : 'Upload Resume',
                      subtitle: isLastStep
                          ? 'Your profile is ready. Let us supercharge your tech journey!'
                          : 'Upload your resume to apply for jobs with one tap',
                      currentStep: currentStep,
                      totalSteps: 6,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    if (isLastStep) ...[
                      // Completion view
                      _buildCompletionView(context, colorScheme),
                    ] else ...[
                      // Resume upload
                      _buildUploadView(context, colorScheme),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: AuthBottomBar(
                primaryLabel: isLastStep ? 'Start Exploring' : 'Continue',
                onPrimaryPressed:
                    isLastStep ? _handleFinishOnboarding : _handleContinue,
                isLoading: _isUploading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadView(BuildContext context, ColorScheme colorScheme) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickResume,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.xxl),
            decoration: BoxDecoration(
              color: _resumeFile != null
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: AppSpacing.borderRadiusLg,
              border: Border.all(
                color: _resumeFile != null
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: 0.5),
                width: _resumeFile != null ? 2 : 1,
                style: _resumeFile == null ? BorderStyle.solid : BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  _resumeFile != null
                      ? Icons.description_rounded
                      : Icons.cloud_upload_rounded,
                  size: 48,
                  color: _resumeFile != null
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _resumeFile != null
                      ? _resumeFile!.name
                      : 'Tap to upload resume',
                  style: AppTypography.titleSmall(
                    color: _resumeFile != null
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'PDF, DOC, or DOCX (Max 5MB)',
                  style: AppTypography.bodySmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (_resumeFile != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  TextButton.icon(
                    onPressed: _pickResume,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Choose different file'),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        // Tip
        Container(
          padding: const EdgeInsets.all(AppSpacing.base),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'You can upload your resume later from your profile settings.',
                  style: AppTypography.bodySmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionView(BuildContext context, ColorScheme colorScheme) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              size: 64,
              color: colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Welcome to Snapshot!',
          style: AppTypography.headlineMedium(
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Your profile is all set up. Get ready to explore the best of tech!',
          style: AppTypography.bodyLarge(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
