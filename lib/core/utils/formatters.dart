import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  // --- Currency ---
  static String currency(num amount, {String symbol = '\$', int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(amount);
  }

  static String compactCurrency(num amount, {String symbol = '\$'}) {
    return NumberFormat.compactCurrency(
      symbol: symbol,
      decimalDigits: 1,
    ).format(amount);
  }

  // --- Number ---
  static String number(num value) {
    return NumberFormat('#,##0').format(value);
  }

  static String compactNumber(num value) {
    return NumberFormat.compact().format(value);
  }

  static String decimal(num value, {int digits = 2}) {
    return NumberFormat('#,##0.${'0' * digits}').format(value);
  }

  static String percent(num value, {int digits = 1}) {
    return NumberFormat.percentPattern().format(value / 100);
  }

  // --- Duration ---
  static String duration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  static String durationShort(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) return '${hours}h';
    if (minutes > 0) return '${minutes}m';
    return '${seconds}s';
  }

  // --- File Size ---
  static String fileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // --- Phone ---
  static String phone(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    if (digits.length == 12 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    return raw;
  }

  // --- Credit Card ---
  static String creditCard(String number) {
    final clean = number.replaceAll(RegExp(r'[^\d]'), '');
    final buffer = StringBuffer();
    for (var i = 0; i < clean.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(clean[i]);
    }
    return buffer.toString();
  }

  // --- Truncate ---
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$suffix';
  }

  // --- Pluralize ---
  static String plural(int count, String singular, {String? plural}) {
    return count == 1 ? '$count $singular' : '$count ${plural ?? '${singular}s'}';
  }

  // --- Read Time ---
  static String readTime(int wordCount, {int wordsPerMinute = 200}) {
    final minutes = (wordCount / wordsPerMinute).ceil();
    return '$minutes min read';
  }
}
