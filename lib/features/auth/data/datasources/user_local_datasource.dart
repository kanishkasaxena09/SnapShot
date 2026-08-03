import '../../data/models/user_model.dart';

class UserLocalDataSource {
  UserLocalDataSource() : _users = {};

  final Map<String, UserModel> _users;

  Future<UserModel?> getUser(String uid) async {
    return _users[uid];
  }

  Future<UserModel?> getCurrentUser(String? uid) async {
    if (uid == null) return null;
    return getUser(uid);
  }

  Future<UserModel> updateUser(UserModel user) async {
    _users[user.uid] = user;
    return user;
  }

  Future<void> updateField(String uid, Map<String, dynamic> data) async {
    final existing = _users[uid];
    if (existing == null) return;
    final json = existing.toJson();
    json.addAll(data);
    _users[uid] = UserModel.fromJson(json);
  }

  Future<bool> isUsernameAvailable(String username) async {
    return _users.values.every((u) => u.username != username);
  }

  Future<bool> isEmailTaken(String email) async {
    return _users.values.any((u) => u.email == email);
  }

  Future<void> deleteUser(String uid) async {
    _users.remove(uid);
  }
}
