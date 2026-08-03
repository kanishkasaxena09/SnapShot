import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

/// Returns the currently signed-in user, or null when signed out.
class GetCurrentUser {
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  Future<AuthUser?> call() => _repository.getCurrentUser();
}
