import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

class LocalStorage {
  LocalStorage._();

  static bool _initialized = false;

  /// Initialize Hive and register type adapters.
  /// Call this once at app startup before any Hive operations.
  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    // TODO: Register Freezed-generated TypeAdapters here when models are created.
    // Example:
    // Hive.registerAdapter(UserAdapter());
    // Hive.registerAdapter(SettingsAdapter());

    // Open all boxes
    await Future.wait([
      Hive.openBox(AppConstants.userBox),
      Hive.openBox(AppConstants.settingsBox),
      Hive.openBox(AppConstants.cacheBox),
      Hive.openBox(AppConstants.bookmarksBox),
      Hive.openBox(AppConstants.draftsBox),
      Hive.openBox(AppConstants.searchHistoryBox),
    ]);

    _initialized = true;
  }

  // ==================== GENERIC OPERATIONS ====================

  static Box _box(String name) => Hive.box(name);

  /// Get a value from a box.
  static T? get<T>(String boxName, String key) {
    return _box(boxName).get(key) as T?;
  }

  /// Put a value into a box.
  static Future<void> put<T>(String boxName, String key, T value) async {
    await _box(boxName).put(key, value);
  }

  /// Delete a value from a box.
  static Future<void> delete(String boxName, String key) async {
    await _box(boxName).delete(key);
  }

  /// Check if a key exists in a box.
  static bool has(String boxName, String key) {
    return _box(boxName).containsKey(key);
  }

  /// Get all values from a box.
  static Map<String, dynamic> getAll(String boxName) {
    return Map<String, dynamic>.from(_box(boxName).toMap());
  }

  /// Clear all values from a box.
  static Future<void> clearBox(String boxName) async {
    await _box(boxName).clear();
  }

  /// Delete an entire box.
  static Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  // ==================== CACHE OPERATIONS ====================

  static Future<void> setCache(
    String key,
    dynamic value, {
    Duration? ttl,
  }) async {
    final cacheData = {
      'value': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'ttl': ttl?.inMilliseconds,
    };
    await put(AppConstants.cacheBox, key, cacheData);
  }

  static T? getCache<T>(String key) {
    final data = get<Map>(AppConstants.cacheBox, key);
    if (data == null) return null;

    final ttl = data['ttl'] as int?;
    if (ttl != null) {
      final timestamp = data['timestamp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > ttl) {
        delete(AppConstants.cacheBox, key);
        return null;
      }
    }

    return data['value'] as T;
  }

  static Future<void> clearCache() async {
    await clearBox(AppConstants.cacheBox);
  }

  // ==================== SETTINGS ====================

  static Future<void> setThemeMode(String mode) async {
    await put(AppConstants.settingsBox, 'theme_mode', mode);
  }

  static String getThemeMode() {
    return get<String>(AppConstants.settingsBox, 'theme_mode') ?? 'system';
  }

  static Future<void> setLocale(String locale) async {
    await put(AppConstants.settingsBox, 'locale', locale);
  }

  static String getLocale() {
    return get<String>(AppConstants.settingsBox, 'locale') ?? 'en';
  }

  static Future<void> setOnboardingComplete(bool value) async {
    await put(AppConstants.settingsBox, 'onboarding_complete', value);
  }

  static bool isOnboardingComplete() {
    return get<bool>(AppConstants.settingsBox, 'onboarding_complete') ?? false;
  }

  // ==================== USER ====================

  static Future<void> setUserId(String userId) async {
    await put(AppConstants.userBox, 'user_id', userId);
  }

  static String? getUserId() {
    return get<String>(AppConstants.userBox, 'user_id');
  }

  static Future<void> clearUser() async {
    await clearBox(AppConstants.userBox);
  }

  // ==================== SEARCH HISTORY ====================

  static Future<void> addSearchQuery(String query) async {
    final box = _box(AppConstants.searchHistoryBox);
    final queries = box.get('queries', defaultValue: <String>[]) as List;
    final list = List<String>.from(queries);

    list.remove(query);
    list.insert(0, query);

    if (list.length > AppConstants.maxRecentSearches) {
      list.removeRange(AppConstants.maxRecentSearches, list.length);
    }

    await box.put('queries', list);
  }

  static List<String> getSearchHistory() {
    final box = _box(AppConstants.searchHistoryBox);
    return List<String>.from(
      box.get('queries', defaultValue: <String>[]),
    );
  }

  static Future<void> clearSearchHistory() async {
    await _box(AppConstants.searchHistoryBox).put('queries', <String>[]);
  }

  // ==================== UTILITY ====================

  /// Clear all local data (for logout / reset).
  static Future<void> clearAll() async {
    await clearBox(AppConstants.userBox);
    await clearBox(AppConstants.cacheBox);
    await clearBox(AppConstants.bookmarksBox);
    await clearBox(AppConstants.draftsBox);
    await clearBox(AppConstants.searchHistoryBox);
    // Keep settings (theme, locale, onboarding)
  }

  /// Close all boxes. Call before app termination.
  static Future<void> close() async {
    await Hive.close();
  }
}
