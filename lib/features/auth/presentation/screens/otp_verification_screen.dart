import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/auth_state.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_header.dart';
import '../widgets/otp_field.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {

  const OtpVerificationScreen({super.key, required this.email});
  final String email;

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends ConsumerState<OtpVerificationScreen> {
  String _otp = '';
  bool _hasError = false;
  bool _isLoading = false;
  int _resendSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    // Auto-send OTP
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).sendOtp(widget.email);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_resendSeconds > 0) {
            _resendSeconds--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  Future<void> _handleVerify() async {
    if (_otp.length < 6) {
      setState(() => _hasError = true);
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    await ref.read(authProvider.notifier).verifyOtp(widget.email, _otp);
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        otpVerified: () => context.go(RouteNames.onboarding),
        error: (msg) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              AuthHeader(
                title: 'Verify Email',
                subtitle: 'Enter the 6-digit code sent to ${widget.email}',
              ),
              const SizedBox(height: AppSpacing.xxxl),

              OtpField(
                length: 6,
                hasError: _hasError,
                onChanged: (value) {
                  setState(() {
                    _otp = value;
                    _hasError = false;
                  });
                },
                onCompleted: (_) => _handleVerify(),
              ),
              const SizedBox(height: AppSpacing.xl),

              FilledButton(
                onPressed: _otp.length == 6 && !_isLoading
                    ? _handleVerify
                    : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Verify'),
              ),
              const SizedBox(height: AppSpacing.xl),

              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Didn't receive the code? ",
                    style: AppTypography.bodyMedium(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(
                        text: _resendSeconds > 0
                            ? 'Resend in ${_resendSeconds}s'
                            : 'Resend Code',
                        style: AppTypography.bodyMedium(
                          color: _resendSeconds > 0
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
