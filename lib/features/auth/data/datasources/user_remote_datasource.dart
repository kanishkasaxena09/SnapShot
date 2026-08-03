// ignore_for_file: uri_does_not_exist, depend_on_referenced_packages, undefined_class, undefined_identifier
// This file requires Firebase packages. Re-enable when Firebase is configured.

import '../models/user_model.dart';

class UserRemoteDataSource {
  Future<UserModel?> getUser(String uid) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  Future<UserModel?> getCurrentUser() async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  Future<UserModel> updateUser(UserModel user) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  Future<void> updateField(String uid, Map<String, dynamic> data) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  Future<bool> isUsernameAvailable(String username) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  Future<bool> isEmailTaken(String email) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }

  Future<void> deleteUser(String uid) async {
    throw UnimplementedError('Firebase not configured. Use local datasource.');
  }
}
