import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(supabase_auth.authServiceProvider).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.go(RouteNames.home);
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
    if (lower.contains('invalid login credentials')) {
      return 'Invalid email or password.';
    }
    if (lower.contains('email not confirmed')) {
      return 'Please confirm your email before signing in.';
    }
    if (lower.contains('user not found')) {
      return 'No account found with this email.';
    }
    return message;
  }

  Future<void> _handleGoogleLogin() async {
    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).signInWithGoogle();
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _handleGithubLogin() async {
    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).signInWithGitHub();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        authenticated: (_) {
          if (mounted) context.go(RouteNames.home);
        },
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
                  title: 'Welcome Back',
                  subtitle: 'Sign in to continue to Snapshot',
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Email Field
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

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: (v) => Validators.required(v, fieldName: 'Password'),
                  onFieldSubmitted: (_) => _handleLogin(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(RouteNames.forgotPassword),
                    child: Text(
                      'Forgot Password?',
                      style: AppTypography.bodySmall(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                // Login Button
                const SizedBox(height: AppSpacing.sm),
                AuthBottomBar(
                  primaryLabel: 'Sign In',
                  onPrimaryPressed: _handleLogin,
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
                          'or continue with',
                          style: AppTypography.bodySmall(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                ),

                // Social Login Buttons
                SocialLoginButton(
                  type: SocialLoginType.google,
                  onPressed: _handleGoogleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: AppSpacing.sm),
                SocialLoginButton(
                  type: SocialLoginType.github,
                  onPressed: _handleGithubLogin,
                  isLoading: _isLoading,
                ),

                // Register Link
                const SizedBox(height: AppSpacing.xxl),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppTypography.bodyMedium(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: AppTypography.bodyMedium(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.push(RouteNames.register),
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
