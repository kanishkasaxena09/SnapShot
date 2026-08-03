import '../entities/auth_user.dart';
import '../entities/sign_up_result.dart';

/// Contract for the auth feature's data access.
///
/// The domain layer depends on this interface; the data layer provides
/// [AuthRepositoryImpl]. All operations return domain types and throw
/// [AuthFailure] on error — Supabase specifics never cross this boundary.
abstract class AuthRepository {
  Future<SignUpResult> signUp({
    required String email,
    required String password,
    String? name,
    String? username,
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<AuthUser?> getCurrentUser();

  Stream<AuthUser?> authStateChanges();

  Future<AuthUser> updateProfile({
    String? name,
    String? username,
    String? avatarUrl,
  });
}
