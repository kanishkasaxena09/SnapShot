import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_widgets.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).sendPasswordReset(
          _emailController.text.trim(),
        );
    if (mounted) {
      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: _emailSent
              ? _buildSuccessView(context)
              : _buildFormView(context),
        ),
      ),
    );
  }

  Widget _buildFormView(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxl),
          const AuthHeader(
            title: 'Forgot Password?',
            subtitle:
                "No worries! Enter your email and we'll send you a reset link.",
          ),
          const SizedBox(height: AppSpacing.xxl),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: Validators.email,
            onFieldSubmitted: (_) => _handleResetPassword(),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          AuthBottomBar(
            primaryLabel: 'Send Reset Link',
            onPrimaryPressed: _handleResetPassword,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxxl * 2),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.mark_email_read_rounded,
            size: 40,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Check Your Email',
          style: AppTypography.headlineMedium(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          "We've sent a password reset link to",
          style: AppTypography.bodyMedium(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _emailController.text.trim(),
          style: AppTypography.bodyLarge(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxl),
        FilledButton(
          onPressed: () => context.pop(),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          child: const Text('Back to Sign In'),
        ),
        const SizedBox(height: AppSpacing.base),
        TextButton(
          onPressed: () {
            setState(() => _emailSent = false);
          },
          child: const Text('Try a different email'),
        ),
      ],
    );
  }
}
