import 'package:supabase_flutter/supabase_flutter.dart';

/// Raw Supabase auth operations.
///
/// This interface isolates everything Supabase-specific behind one seam so
/// [AuthRepositoryImpl] (and the domain layer above it) never touches
/// `Supabase.instance.client` directly.
abstract class SupabaseAuthDataSource {
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? name,
    String? username,
  });

  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<User?> getCurrentUser();

  Stream<AuthState> get authStateChanges;

  Future<Map<String, dynamic>?> fetchProfile(String userId);

  Future<void> upsertProfile({
    required String userId,
    String? name,
    String? username,
    String? avatarUrl,
  });
}
