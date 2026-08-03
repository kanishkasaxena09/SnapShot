import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(UserEntity user) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.onboardingRequired(UserEntity user) = AuthOnboardingRequired;
  const factory AuthState.error(String message) = AuthError;
  const factory AuthState.passwordResetSent() = AuthPasswordResetSent;
  const factory AuthState.otpSent() = AuthOtpSent;
  const factory AuthState.otpVerified() = AuthOtpVerified;
  const factory AuthState.signedOut() = AuthSignedOut;
}
