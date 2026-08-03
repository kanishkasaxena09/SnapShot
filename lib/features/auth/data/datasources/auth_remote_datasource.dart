import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithGitHub();

  Future<void> signOut();

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> verifyOtp({required String email, required String otp});

  Future<void> sendOtp({required String email});

  Future<UserModel?> getCurrentUser();

  Future<UserModel> updateProfile(UserModel user);

  Future<String> uploadAvatar({required String filePath});

  Future<void> deleteAccount();
}
