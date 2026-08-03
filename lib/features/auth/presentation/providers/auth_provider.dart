import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_local_datasource_impl.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/user_model.dart';
import '../../data/models/user_model_mapper.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/entities/user_entity.dart';

final authDataSourceProvider = Provider<AuthLocalDataSourceImpl>((ref) {
  return AuthLocalDataSourceImpl();
});

class AuthNotifier extends StateNotifier<AuthState> {

  AuthNotifier(this._authDataSource)
      : super(const AuthState.initial()) {
    _checkAuthStatus();
  }
  final AuthRemoteDataSource _authDataSource;

  Future<void> _checkAuthStatus() async {
    state = const AuthState.loading();
    try {
      final user = await _authDataSource.getCurrentUser();
      if (user == null) {
        state = const AuthState.unauthenticated();
      } else if (!user.isProfileComplete || !user.isOnboarded) {
        state = AuthState.onboardingRequired(user.toEntity());
      } else {
        state = AuthState.authenticated(user.toEntity());
      }
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _authDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      _handleAuthResult(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    state = const AuthState.loading();
    try {
      final user = await _authDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      state = AuthState.onboardingRequired(user.toEntity());
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _authDataSource.signInWithGoogle();
      _handleAuthResult(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithGitHub() async {
    state = const AuthState.loading();
    try {
      final user = await _authDataSource.signInWithGitHub();
      _handleAuthResult(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendPasswordReset(String email) async {
    state = const AuthState.loading();
    try {
      await _authDataSource.sendPasswordResetEmail(email: email);
      state = const AuthState.passwordResetSent();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendOtp(String email) async {
    state = const AuthState.loading();
    try {
      await _authDataSource.sendOtp(email: email);
      state = const AuthState.otpSent();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const AuthState.loading();
    try {
      await _authDataSource.verifyOtp(email: email, otp: otp);
      state = const AuthState.otpVerified();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> updateProfile(UserEntity user) async {
    try {
      final model = user.toModel();
      final updated = await _authDataSource.updateProfile(model);
      state = AuthState.authenticated(updated.toEntity());
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> updateOnboardingStep(UserEntity user) async {
    try {
      final model = user.toModel();
      final updated = await _authDataSource.updateProfile(model);
      if (updated.isOnboarded) {
        state = AuthState.authenticated(updated.toEntity());
      } else {
        state = AuthState.onboardingRequired(updated.toEntity());
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> completeOnboarding(UserEntity user) async {
    try {
      final completedUser = user.copyWith(
        isOnboarded: true,
        isProfileComplete: true,
        updatedAt: DateTime.now(),
      );
      final model = completedUser.toModel();
      final updated = await _authDataSource.updateProfile(model);
      state = AuthState.authenticated(updated.toEntity());
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _authDataSource.signOut();
      state = const AuthState.signedOut();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void _handleAuthResult(UserModel user) {
    final entity = user.toEntity();
    if (!entity.isProfileComplete || !entity.isOnboarded) {
      state = AuthState.onboardingRequired(entity);
    } else {
      state = AuthState.authenticated(entity);
    }
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(authDataSourceProvider),
  );
});

final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.whenOrNull(
    authenticated: (user) => user,
    onboardingRequired: (user) => user,
  );
});
