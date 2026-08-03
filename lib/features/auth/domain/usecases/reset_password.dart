import '../repositories/auth_repository.dart';

/// Sends a password reset email.
class ResetPassword {
  const ResetPassword(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String email}) {
    return _repository.resetPassword(email: email);
  }
}
