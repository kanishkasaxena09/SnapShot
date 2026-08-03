import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_auth_data_source.dart';

/// Supabase-backed implementation of [SupabaseAuthDataSource].
class SupabaseAuthDataSourceImpl implements SupabaseAuthDataSource {
  SupabaseAuthDataSourceImpl(this._client);

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? name,
    String? username,
  }) async {
    final metadata = <String, dynamic>{
      if (name != null) 'full_name': name,
      if (username != null) 'username': username,
    };
    return _auth.signUp(
      email: email,
      password: password,
      data: metadata.isEmpty ? null : metadata,
    );
  }

  @override
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) {
    return _auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> resetPassword({required String email}) {
    return _auth.resetPasswordForEmail(email);
  }

  @override
  Future<User?> getCurrentUser() async => _auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;

  @override
  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    return _client.from('profiles').select().eq('id', userId).maybeSingle();
  }

  @override
  Future<void> upsertProfile({
    required String userId,
    String? name,
    String? username,
    String? avatarUrl,
  }) async {
    await _client.from('profiles').upsert({
      'id': userId,
      if (name != null) 'full_name': name,
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    });
  }
}
