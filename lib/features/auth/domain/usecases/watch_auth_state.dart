import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

/// Streams auth state changes (sign-in, sign-out, token refresh, user update).
class WatchAuthState {
  const WatchAuthState(this._repository);

  final AuthRepository _repository;

  Stream<AuthUser?> call() => _repository.authStateChanges();
}
