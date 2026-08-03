import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Format: "Jan 1, 2026"
  String get shortDate => DateFormat('MMM d, y').format(this);

  /// Format: "January 1, 2026"
  String get longDate => DateFormat('MMMM d, y').format(this);

  /// Format: "Jan 1, 2026 3:30 PM"
  String get dateTime => DateFormat('MMM d, y h:mm a').format(this);

  /// Format: "3:30 PM"
  String get time => DateFormat('h:mm a').format(this);

  /// Format: "3:30 PM"
  String get time24 => DateFormat('HH:mm').format(this);

  /// Format: "Jan 1"
  String get shortMonthDay => DateFormat('MMM d').format(this);

  /// Format: "Monday, Jan 1"
  String get dayOfWeek => DateFormat('EEEE, MMM d').format(this);

  /// "2 hours ago", "just now", "3 days ago", etc.
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) return 'just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30) return '${(difference.inDays / 7).floor()}w ago';
    if (difference.inDays < 365) return '${(difference.inDays / 30).floor()}mo ago';
    return '${(difference.inDays / 365).floor()}y ago';
  }

  /// Check if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if the date is yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if the date is this week.
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        isBefore(now.add(const Duration(days: 1)));
  }

  /// Check if the date is this month.
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Check if the date is this year.
  bool get isThisYear {
    return year == DateTime.now().year;
  }

  /// Start of the day (00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// End of the day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Start of the week (Monday).
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1)).startOfDay;

  /// Start of the month.
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Check if the date is in the past.
  bool get isPast => isBefore(DateTime.now());

  /// Check if the date is in the future.
  bool get isFuture => isAfter(DateTime.now());

  /// Add business days (skipping weekends).
  DateTime addBusinessDays(int days) {
    var result = this;
    var added = 0;
    while (added < days) {
      result = result.add(const Duration(days: 1));
      if (result.weekday != DateTime.saturday &&
          result.weekday != DateTime.sunday) {
        added++;
      }
    }
    return result;
  }
}

extension DurationExtensions on Duration {
  /// Format as "HH:mm:ss" or "mm:ss".
  String get formatted {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Human-readable duration string (e.g. "2h 30m").
  String get humanReadable {
    if (inDays > 0) return '${inDays}d ${inHours.remainder(24)}h';
    if (inHours > 0) return '${inHours}h ${inMinutes.remainder(60)}m';
    if (inMinutes > 0) return '${inMinutes}m ${inSeconds.remainder(60)}s';
    return '${inSeconds}s';
  }
}
