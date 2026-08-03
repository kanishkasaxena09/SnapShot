import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../domain/entities/auth_user.dart';

/// Maps a Supabase [User] (optionally merged with a `profiles` row) to the
/// domain [AuthUser].
///
/// Profile columns take precedence over `user_metadata`; metadata is used as a
/// fallback so the user model stays populated even before a profile row exists.
AuthUser authUserFromSupabase(User user, Map<String, dynamic>? profile) {
  final metadata = user.userMetadata ?? const <String, dynamic>{};
  return AuthUser(
    id: user.id,
    email: user.email ?? '',
    name: _pick(profile?['full_name'], metadata['full_name']),
    username: _pick(profile?['username'], metadata['username']),
    avatarUrl: _pick(profile?['avatar_url'], metadata['avatar_url']),
    isEmailVerified: user.emailConfirmedAt != null,
    createdAt: DateTime.tryParse(user.createdAt),
  );
}

String _pick(Object? profileValue, Object? metadataValue) {
  if (profileValue is String && profileValue.isNotEmpty) return profileValue;
  if (metadataValue is String && metadataValue.isNotEmpty) return metadataValue;
  return '';
}
