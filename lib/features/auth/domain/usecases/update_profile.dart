import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

/// Updates the current user's public profile (name, username, avatar).
class UpdateProfile {
  const UpdateProfile(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({
    String? name,
    String? username,
    String? avatarUrl,
  }) {
    return _repository.updateProfile(
      name: name,
      username: username,
      avatarUrl: avatarUrl,
    );
  }
}
