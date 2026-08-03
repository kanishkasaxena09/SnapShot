import '../entities/sign_up_result.dart';
import '../repositories/auth_repository.dart';

/// Signs a new user up with email + password.
class SignUp {
  const SignUp(this._repository);

  final AuthRepository _repository;

  Future<SignUpResult> call({
    required String email,
    required String password,
    String? name,
    String? username,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      name: name,
      username: username,
    );
  }
}
