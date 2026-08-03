import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/entities/sign_up_result.dart';
import '../../domain/errors/auth_failure.dart';
import '../../providers/auth_provider.dart';
import '../../providers/auth_usecase_providers.dart';

/// Orchestrates auth flows for the UI.
///
/// Exposes a single [AsyncNotifier] whose state is the current [AuthUser] (or
/// null when signed out). UI stays in the presentation layer and simply calls
/// these methods, then renders [AsyncValue.when] on [authControllerProvider].
class AuthController extends AsyncNotifier<AuthUser?> {
  @override
  Future<AuthUser?> build() async {
    // Mirror the real session stream into our state so sign-out, token
    // refresh and multi-tab changes stay in sync automatically.
    ref.listen<AsyncValue<AuthUser?>>(
      currentUserProvider,
      (previous, next) {
        if (next.hasError) {
          state = AsyncValue.error(next.error!, next.stackTrace ?? StackTrace.empty);
          return;
        }
        state = AsyncData(next.valueOrNull);
      },
    );

    // Seed state from the persisted session. Transient failures (e.g. no
    // network on cold start) resolve to a signed-out state instead of
    // surfacing as a startup error.
    try {
      return await ref.read(getCurrentUserProvider)();
    } on AuthFailure {
      return null;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<AuthUser?>();
    state = await AsyncValue.guard<AuthUser?>(() async {
      return ref.read(signInProvider)(email: email, password: password);
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
    String? username,
  }) async {
    state = const AsyncLoading<AuthUser?>();
    state = await AsyncValue.guard<AuthUser?>(() async {
      final result = await ref.read(signUpProvider)(
        email: email,
        password: password,
        name: name,
        username: username,
      );
      return switch (result) {
        SignUpConfirmed(:final user) => user,
        EmailVerificationRequired(:final email) =>
          throw AuthFailure.emailNotConfirmed(email: email),
      };
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading<AuthUser?>();
    state = await AsyncValue.guard<AuthUser?>(() async {
      await ref.read(signOutProvider)();
      return null;
    });
  }

  /// Sends a password reset email. Throws [AuthFailure] to the caller and
  /// leaves the session state untouched.
  Future<void> resetPassword({required String email}) {
    return ref.read(resetPasswordProvider)(email: email);
  }

  Future<void> updateProfile({
    String? name,
    String? username,
    String? avatarUrl,
  }) async {
    state = const AsyncLoading<AuthUser?>();
    state = await AsyncValue.guard<AuthUser?>(() async {
      return ref.read(updateProfileProvider)(
        name: name,
        username: username,
        avatarUrl: avatarUrl,
      );
    });
  }

  /// Re-reads the current user from the data layer (session restore / pull).
  Future<void> refreshSession() async {
    state = const AsyncLoading<AuthUser?>();
    state = await AsyncValue.guard<AuthUser?>(() async {
      return ref.read(getCurrentUserProvider)();
    });
  }
}
