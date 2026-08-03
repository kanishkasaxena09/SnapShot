import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

/// Typed failures for the auth domain.
///
/// Every failure carries a human-readable [message] so the presentation
/// layer can display it without coupling to Supabase exceptions.
@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidEmail({
    @Default('Please enter a valid email address.') String message,
  }) = InvalidEmailFailure;

  const factory AuthFailure.invalidCredentials({
    @Default('The email or password you entered is incorrect.') String message,
  }) = InvalidCredentialsFailure;

  const factory AuthFailure.emailAlreadyInUse({
    @Default('An account with this email already exists.') String message,
  }) = EmailAlreadyInUseFailure;

  const factory AuthFailure.weakPassword({
    @Default('The password is too weak.') String message,
  }) = WeakPasswordFailure;

  const factory AuthFailure.emailNotConfirmed({
    required String email,
    @Default('Please verify your email address to continue.') String message,
  }) = EmailNotConfirmedFailure;

  const factory AuthFailure.userNotFound({
    @Default('No account found with this email address.') String message,
  }) = UserNotFoundFailure;

  const factory AuthFailure.network({
    @Default('A network error occurred. Please try again.') String message,
  }) = NetworkFailure;

  const factory AuthFailure.sessionExpired({
    @Default('Your session has expired. Please sign in again.') String message,
  }) = SessionExpiredFailure;

  const factory AuthFailure.unknown({
    @Default('An unexpected error occurred.') String message,
  }) = UnknownAuthFailure;

  String get message;
}
