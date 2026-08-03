import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/errors/auth_failure.dart';

/// Maps any error raised by the Supabase layer to a domain [AuthFailure].
///
/// [email] is needed to build the `emailNotConfirmed` failure (the underlying
/// error does not carry the address back).
AuthFailure authFailureFrom(Object error, {String? email}) {
  if (error is AuthFailure) return error;

  if (error is AuthException) {
    switch (error.code) {
      case 'invalid_email':
        return const AuthFailure.invalidEmail();
      case 'invalid_credentials':
        return const AuthFailure.invalidCredentials();
      case 'email_exists':
      case 'user_already_exists':
        return const AuthFailure.emailAlreadyInUse();
      case 'weak_password':
        return const AuthFailure.weakPassword();
      case 'email_not_confirmed':
        return AuthFailure.emailNotConfirmed(email: email ?? '');
      case 'user_not_found':
        return const AuthFailure.userNotFound();
      case 'session_expired':
      case 'refresh_token_not_found':
      case 'invalid_refresh_token':
        return const AuthFailure.sessionExpired();
      case 'network_error':
        return const AuthFailure.network();
      default:
        return AuthFailure.unknown(message: error.message);
    }
  }

  if (error is TimeoutException) {
    return const AuthFailure.network();
  }

  return AuthFailure.unknown(message: error.toString());
}
