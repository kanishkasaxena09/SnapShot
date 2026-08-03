import 'dart:math';

import '../../data/datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthRemoteDataSource {
  AuthLocalDataSourceImpl() : _users = {}, _currentUid = null;

  final Map<String, UserModel> _users;
  String? _currentUid;

  String _generateUid() => DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(9999).toString();

  @override
  Future<UserModel> signInWithEmail({required String email, required String password}) async {
    final existing = _users.values.where((u) => u.email == email);
    if (existing.isNotEmpty) {
      final user = existing.first;
      _currentUid = user.uid;
      return user;
    }
    final uid = _generateUid();
    final user = UserModel(
      uid: uid,
      email: email,
      displayName: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
    _users[uid] = user;
    _currentUid = uid;
    return user;
  }

  @override
  Future<UserModel> signUpWithEmail({required String email, required String password, required String displayName}) async {
    final uid = _generateUid();
    final user = UserModel(
      uid: uid,
      email: email,
      displayName: displayName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      isProfileComplete: false,
      isOnboarded: false,
    );
    _users[uid] = user;
    _currentUid = uid;
    return user;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final uid = _generateUid();
    final user = UserModel(
      uid: uid,
      email: 'google_user\@local.dev',
      displayName: 'Local Google User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
    _users[uid] = user;
    _currentUid = uid;
    return user;
  }

  @override
  Future<UserModel> signInWithGitHub() async {
    final uid = _generateUid();
    final user = UserModel(
      uid: uid,
      email: 'github_user\@local.dev',
      displayName: 'Local GitHub User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
    _users[uid] = user;
    _currentUid = uid;
    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUid = null;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    // No-op for local
  }

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    // No-op for local
  }

  @override
  Future<void> sendOtp({required String email}) async {
    // No-op for local
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    if (_currentUid == null) return null;
    return _users[_currentUid!];
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    final updated = user.copyWith(updatedAt: DateTime.now());
    _users[user.uid] = updated;
    return updated;
  }

  @override
  Future<String> uploadAvatar({required String filePath}) async {
    return '';
  }

  @override
  Future<void> deleteAccount() async {
    if (_currentUid != null) {
      _users.remove(_currentUid);
      _currentUid = null;
    }
  }
}
