// ignore_for_file: uri_does_not_exist, depend_on_referenced_packages, undefined_class, undefined_identifier
// This file requires Firebase packages. Re-enable when Firebase is configured.

import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<UserModel> signInWithGitHub() async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<void> sendOtp({required String email}) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<String> uploadAvatar({required String filePath}) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  @override
  Future<void> deleteAccount() async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }
}
