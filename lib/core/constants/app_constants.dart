class AppConstants {
  AppConstants._();

  static const String appName = 'Snapshot';
  static const String appTagline = 'Your Tech Super App';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';
  static const String bookmarksBox = 'bookmarks_box';
  static const String draftsBox = 'drafts_box';
  static const String searchHistoryBox = 'search_history_box';

  // Hive Type Adapters (start from 0, increment per model)
  static const int userAdapterId = 0;
  static const int settingsAdapterId = 1;
  static const int bookmarkAdapterId = 2;
  static const int searchHistoryAdapterId = 3;
  static const int cacheEntryAdapterId = 4;
  static const int draftAdapterId = 5;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache
  static const Duration cacheDuration = Duration(hours: 1);
  static const Duration longCacheDuration = Duration(days: 7);
  static const Duration shortCacheDuration = Duration(minutes: 15);

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Retry
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  // AI Assistant
  static const int maxChatHistory = 50;
  static const int maxMessageLength = 4000;

  // Resume
  static const int maxResumes = 5;
  static const int maxResumeSections = 12;

  // Search
  static const int maxRecentSearches = 20;
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Bookmarks
  static const int maxCollections = 20;
  static const int maxBookmarksPerCollection = 500;

  // Notifications
  static const int maxNotifications = 100;

  // Images
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1080;
  static const int imageQuality = 85;
}
