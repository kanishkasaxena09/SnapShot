import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/env.dart';
import 'core/storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment
  Env.init(Environment.dev);

  // Initialize local storage
  await LocalStorage.init();

  runApp(
    const ProviderScope(
      child: SnapshotApp(),
    ),
  );
}
