import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_user.dart';

part 'sign_up_result.freezed.dart';

/// Outcome of a sign-up attempt.
///
/// [SignUpResult.confirmed] means the session is already active.
/// [SignUpResult.emailVerificationRequired] means the account was created but
/// the user must confirm their email before signing in (Supabase email
/// confirmation enabled).
@freezed
sealed class SignUpResult with _$SignUpResult {
  const factory SignUpResult.confirmed(AuthUser user) = SignUpConfirmed;

  const factory SignUpResult.emailVerificationRequired({
    required String email,
  }) = EmailVerificationRequired;
}
