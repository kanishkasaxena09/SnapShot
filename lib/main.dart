import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;

import 'app.dart';
import 'config/env.dart';
import 'core/storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment
  Env.init(Environment.dev);

  final supabaseUrl = Env.instance.supabaseUrl;

  // Initialize Supabase with a persistent local storage so the session
  // (and its refresh token) survives app restarts. SharedPreferences is the
  // same durable backend supabase_flutter uses by default; declaring it here
  // guarantees the behavior and keeps the session key stable across versions.
  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: Env.instance.supabaseAnonKey,
    authOptions: FlutterAuthClientOptions(
      localStorage: SharedPreferencesLocalStorage(
        persistSessionKey:
            'sb-${Uri.parse(supabaseUrl).host.split('.').first}-auth-token',
      ),
    ),
  );

  // Initialize local storage
  await LocalStorage.init();

  runApp(
    const ProviderScope(
      child: SnapshotApp(),
    ),
  );
}
