import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import 'auth_data_source_provider.dart';

/// Provides the [AuthRepository] the domain and presentation layers use.
/// Swap the implementation here to replace Supabase without touching UI code.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(supabaseAuthDataSourceProvider));
});
