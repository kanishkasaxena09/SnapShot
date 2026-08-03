import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/profile_setup_provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/step_indicator.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  XFile? _avatarFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(currentUserProvider);
      if (user != null) {
        _nameController.text = user.displayName;
        _bioController.text = user.bio;
        _locationController.text = user.location;
        ref.read(profileSetupProvider.notifier).init(user);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() => _avatarFile = image);
      // TODO: Upload to Firebase Storage and update profile
    }
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(profileSetupProvider.notifier);
    notifier.updateName(_nameController.text.trim());
    notifier.updateBio(_bioController.text.trim());
    notifier.updateLocation(_locationController.text.trim());
    ref.read(onboardingStepProvider.notifier).nextStep();
    final nextStep = ref.read(onboardingStepProvider);
    context.go(onboardingRouteForStep(nextStep));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentStep = ref.watch(onboardingStepProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _handleNext,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
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
                  title: 'Set Up Profile',
                  subtitle: 'Tell us about yourself so we can personalize your experience',
                  currentStep: currentStep,
                  totalSteps: 6,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Avatar
                Center(
                  child: GestureDetector(
                    onTap: _pickAvatar,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: colorScheme.primaryContainer,
                          child: _avatarFile == null
                              ? Icon(
                                  Icons.person_rounded,
                                  size: 50,
                                  color: colorScheme.primary,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 16,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Name
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Name is required' : null,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(height: AppSpacing.base),

                // Bio
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Bio (optional)',
                    prefixIcon: Icon(Icons.info_outline_rounded),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: AppSpacing.base),

                // Location
                TextFormField(
                  controller: _locationController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Location (optional)',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                AuthBottomBar(
                  primaryLabel: 'Continue',
                  onPrimaryPressed: _handleNext,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
