import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../domain/entities/auth_user.dart';
import '../../domain/entities/sign_up_result.dart';
import '../../domain/errors/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_data_source.dart';
import '../mappers/auth_failure_mapper.dart';
import '../mappers/auth_user_mapper.dart';

/// Bridges [SupabaseAuthDataSource] and the [AuthRepository] contract.
///
/// This is the only place that knows both sides: it maps Supabase responses
/// to domain types and translates Supabase errors into [AuthFailure].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final SupabaseAuthDataSource _dataSource;

  @override
  Future<SignUpResult> signUp({
    required String email,
    required String password,
    String? name,
    String? username,
  }) async {
    try {
      final response = await _dataSource.signUp(
        email: email,
        password: password,
        name: name,
        username: username,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthFailure.unknown(
          message: 'Sign up failed. Please try again.',
        );
      }

      await _dataSource.upsertProfile(
        userId: user.id,
        name: name,
        username: username,
      );

      final authUser = authUserFromSupabase(user, null);
      if (response.session != null) {
        return SignUpResult.confirmed(authUser);
      }
      return SignUpResult.emailVerificationRequired(
        email: user.email ?? email,
      );
    } catch (error) {
      throw authFailureFrom(error, email: email);
    }
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dataSource.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthFailure.unknown(
          message: 'Sign in failed. Please try again.',
        );
      }
      return _withProfile(user);
    } catch (error) {
      throw authFailureFrom(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } catch (error) {
      throw authFailureFrom(error);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _dataSource.resetPassword(email: email);
    } catch (error) {
      throw authFailureFrom(error, email: email);
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      if (user == null) return null;
      return _withProfile(user);
    } catch (error) {
      throw authFailureFrom(error);
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _dataSource.authStateChanges.asyncMap((authState) async {
      final user = authState.session?.user;
      if (user == null) return null;
      return _withProfile(user);
    });
  }

  @override
  Future<AuthUser> updateProfile({
    String? name,
    String? username,
    String? avatarUrl,
  }) async {
    try {
      final current = await _dataSource.getCurrentUser();
      if (current == null) {
        throw const AuthFailure.sessionExpired();
      }
      await _dataSource.upsertProfile(
        userId: current.id,
        name: name,
        username: username,
        avatarUrl: avatarUrl,
      );
      return _withProfile(current);
    } catch (error) {
      throw authFailureFrom(error);
    }
  }

  Future<AuthUser> _withProfile(User user) async {
    try {
      final profile = await _dataSource.fetchProfile(user.id);
      return authUserFromSupabase(user, profile);
    } catch (_) {
      return authUserFromSupabase(user, null);
    }
  }
}
