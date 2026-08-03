import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../data/auth_service.dart';
import '../domain/entities/auth_user.dart';
import '../domain/errors/auth_failure.dart';
import 'auth_usecase_providers.dart';
import 'supabase_client_provider.dart';

export 'supabase_client_provider.dart';

/// Provides the raw Supabase auth facade.
///
/// This is the low-level seam over the GoTrue client (sign-up, sign-in,
/// sessions, the auth event stream). Screens that need direct auth operations
/// (e.g. the register screen) inject this instead of touching
/// `Supabase.instance.client` themselves.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(supabaseClientProvider));
});

/// Authentication State — raw stream of Supabase auth events.
///
/// Emits every event (INITIAL_SESSION, SIGNED_IN, SIGNED_OUT,
/// TOKEN_REFRESHED, USER_UPDATED, ...) plus the session attached to it.
/// Useful for coarse reactions (e.g. route guards); finer signals derive
/// from this provider below.
final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

/// Current Session — live `Session?`, null while signed out.
///
/// Carries the access/refresh tokens for authenticated API calls. Seeded with
/// the persisted session so it resolves immediately instead of waiting for the
/// first stream emission, then follows [authStateProvider].
final currentSessionProvider = StreamProvider<Session?>((ref) async* {
  yield ref.read(authServiceProvider).currentSession;
  yield* ref.watch(authStateProvider.stream).map((state) => state.session);
});

/// Current User — live domain [AuthUser]?, null while signed out.
///
/// This is the provider UI should watch to render the signed-in experience.
/// It merges profile data via the repository (domain types, no Supabase types
/// leak here). Seeded from the persisted session, then mirrors auth changes.
final currentUserProvider = StreamProvider<AuthUser?>((ref) async* {
  try {
    yield await ref.read(getCurrentUserProvider)();
  } on AuthFailure {
    yield null;
  }
  yield* ref.read(watchAuthStateProvider)();
});

/// Whether a session is currently active.
///
/// Convenience derived from [currentUserProvider] for quick checks
/// (e.g. disabling an action while signed out).
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider).valueOrNull != null;
});
