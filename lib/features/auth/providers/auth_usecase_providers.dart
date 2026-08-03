import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/usecases/get_current_user.dart';
import '../domain/usecases/reset_password.dart';
import '../domain/usecases/sign_in.dart';
import '../domain/usecases/sign_out.dart';
import '../domain/usecases/sign_up.dart';
import '../domain/usecases/update_profile.dart';
import '../domain/usecases/watch_auth_state.dart';
import 'auth_repository_provider.dart';

final signUpProvider = Provider<SignUp>((ref) {
  return SignUp(ref.watch(authRepositoryProvider));
});

final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.watch(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});

final resetPasswordProvider = Provider<ResetPassword>((ref) {
  return ResetPassword(ref.watch(authRepositoryProvider));
});

final getCurrentUserProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.watch(authRepositoryProvider));
});

final watchAuthStateProvider = Provider<WatchAuthState>((ref) {
  return WatchAuthState(ref.watch(authRepositoryProvider));
});

final updateProfileProvider = Provider<UpdateProfile>((ref) {
  return UpdateProfile(ref.watch(authRepositoryProvider));
});
