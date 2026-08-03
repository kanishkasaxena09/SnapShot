import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Domain model for an authenticated user.
///
/// This is the only user shape the presentation layer should consume.
/// It is intentionally free of Supabase, JSON and persistence concerns.
@freezed
sealed class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    @Default('') String name,
    @Default('') String username,
    @Default('') String avatarUrl,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
  }) = _AuthUser;
}
