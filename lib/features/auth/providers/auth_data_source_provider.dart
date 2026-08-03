import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/supabase_auth_data_source.dart';
import '../data/datasources/supabase_auth_data_source_impl.dart';
import 'supabase_client_provider.dart';

/// Provides the Supabase-backed auth data source.
///
/// Built on [supabaseClientProvider] so the client is created in exactly one
/// place. Swap this provider to replace Supabase without touching the
/// repository, domain or presentation layers.
final supabaseAuthDataSourceProvider = Provider<SupabaseAuthDataSource>((ref) {
  return SupabaseAuthDataSourceImpl(ref.watch(supabaseClientProvider));
});
