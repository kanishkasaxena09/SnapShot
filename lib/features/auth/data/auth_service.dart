import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Single entry point for all Supabase auth calls.
///
/// UI must never use `Supabase.instance.client.auth` directly.
/// Instead, inject [authServiceProvider] and call its methods.
class AuthService {
  const AuthService(this._client);

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? fullName,
    String? username,
  }) async {
    final response = await _auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user != null) {
      try {
        await _createProfileIfAbsent(
          userId: user.id,
          fullName: fullName,
          username: username,
        );
      } catch (error) {
        // Profile write failed after the account was created. Best-effort
        // rollback of the auth user so no orphan account is left behind; if
        // the client lacks the service role the delete is a no-op and the
        // account remains, which the caller must surface to the user.
        try {
          await _auth.admin.deleteUser(user.id);
        } catch (rollbackError) {
          debugPrint('Profile failed for ${user.id}; '
              'could not roll back auth user: $rollbackError');
        }
        rethrow;
      }
    }

    return response;
  }

  /// Creates the user's profile row only if none exists yet.
  ///
  /// Columns: id, full_name, username, avatar_url, bio, created_at.
  /// `ignoreDuplicates` + `onConflict: 'id'` make this atomic and idempotent,
  /// so a retry or re-run never produces a second row and never overwrites
  /// data the user may have already set on an existing profile.
  Future<void> _createProfileIfAbsent({
    required String userId,
    String? fullName,
    String? username,
  }) async {
    await _client.from('profiles').upsert(
          {
            'id': userId,
            'full_name': fullName,
            'username': username,
            'avatar_url': null,
            'bio': null,
            'created_at': DateTime.now().toUtc().toIso8601String(),
          },
          onConflict: 'id',
          ignoreDuplicates: true,
        );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> resetPassword({required String email}) {
    return _auth.resetPasswordForEmail(email);
  }

  User? get currentUser => _auth.currentUser;

  Session? get currentSession => _auth.currentSession;

  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;
}
