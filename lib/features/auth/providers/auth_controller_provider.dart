import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/auth_user.dart';
import '../presentation/controllers/auth_controller.dart';

/// Single source of truth for the auth session state.
///
/// State is `AsyncValue<AuthUser?>`:
/// - `AsyncData(user)` — signed in
/// - `AsyncData(null)` — signed out
/// - `AsyncLoading()` / `AsyncError(...)` — in-flight or failed operations
///
/// Read the session from here when you need the controller's action flow;
/// read [currentUserProvider] from `auth_provider.dart` when you only need the
/// reactive current user.
final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthUser?>(AuthController.new);
