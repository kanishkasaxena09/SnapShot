import '../constants/app_constants.dart';

/// Centralized Hive box name constants.
/// Use these instead of raw strings everywhere.
class HiveBoxes {
  HiveBoxes._();

  static String get user => AppConstants.userBox;
  static String get settings => AppConstants.settingsBox;
  static String get cache => AppConstants.cacheBox;
  static String get bookmarks => AppConstants.bookmarksBox;
  static String get drafts => AppConstants.draftsBox;
  static String get searchHistory => AppConstants.searchHistoryBox;
}
