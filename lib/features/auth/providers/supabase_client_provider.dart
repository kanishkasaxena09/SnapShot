import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provides the initialized Supabase client.
///
/// `Supabase.instance` is configured in `main()` via `Supabase.initialize`.
/// This is the single place that touches the client; every auth data source
/// and service derives from it, so tests can `overrideProvider` with a mock.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});
