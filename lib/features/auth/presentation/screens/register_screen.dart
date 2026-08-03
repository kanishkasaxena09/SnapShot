import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/auth_state.dart';
import '../../providers/auth_provider.dart' as supabase_auth;
import '../providers/auth_provider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/social_login_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final response = await ref.read(supabase_auth.authServiceProvider).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            fullName: _nameController.text.trim(),
          );
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (response.session != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully'),
          ),
        );
        context.go(RouteNames.profileSetup);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account created — check your inbox to confirm your email before signing in',
            ),
          ),
        );
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_friendlyAuthMessage(e.message)),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    }
  }

  String _friendlyAuthMessage(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('already registered')) {
      return 'An account with this email already exists. Try signing in.';
    }
    if (lower.contains('invalid login credentials')) {
      return 'Invalid email or password.';
    }
    if (lower.contains('email not confirmed')) {
      return 'Please confirm your email before signing in.';
    }
    if (lower.contains('password')) {
      return 'Password does not meet the requirements.';
    }
    return message;
  }

  Future<void> _handleGoogleRegister() async {
    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).signInWithGoogle();
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _handleGithubRegister() async {
    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).signInWithGitHub();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        error: (msg) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg)),
            );
          }
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xxl),
                const AuthHeader(
                  title: 'Create Account',
                  subtitle: 'Join Snapshot and supercharge your tech journey',
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Full Name
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (v) => Validators.required(v, fieldName: 'Name'),
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.05),
                const SizedBox(height: AppSpacing.base),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),
                const SizedBox(height: AppSpacing.base),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),
                const SizedBox(height: AppSpacing.base),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  textInputAction: TextInputAction.done,
                  validator: (v) =>
                      Validators.confirmPassword(v, _passwordController.text),
                  onFieldSubmitted: (_) => signUp(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05),

                // Register Button
                const SizedBox(height: AppSpacing.xl),
                AuthBottomBar(
                  primaryLabel: 'Create Account',
                  onPrimaryPressed: signUp,
                  isLoading: _isLoading,
                ),

                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: AppSpacing.paddingHorizontalMd,
                        child: Text(
                          'or sign up with',
                          style: AppTypography.bodySmall(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                ),

                // Social Buttons
                SocialLoginButton(
                  type: SocialLoginType.google,
                  onPressed: _handleGoogleRegister,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: AppSpacing.sm),
                SocialLoginButton(
                  type: SocialLoginType.github,
                  onPressed: _handleGithubRegister,
                  isLoading: _isLoading,
                ),

                // Login Link
                const SizedBox(height: AppSpacing.xxl),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: AppTypography.bodyMedium(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: AppTypography.bodyMedium(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
