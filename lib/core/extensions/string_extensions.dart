extension StringExtensions on String {
  /// Check if string is a valid email.
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  /// Check if string is a valid URL.
  bool get isValidUrl {
    return Uri.tryParse(this)?.hasAbsolutePath ?? false;
  }

  /// Capitalize the first letter.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word.
  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Truncate string to [length] characters with ellipsis.
  String truncate(int length) {
    if (this.length <= length) return this;
    return '${substring(0, length)}...';
  }

  /// Truncate to nearest word boundary.
  String truncateAtWord(int maxLength) {
    if (length <= maxLength) return this;
    final truncated = substring(0, maxLength);
    final lastSpace = truncated.lastIndexOf(' ');
    return '${lastSpace > 0 ? truncated.substring(0, lastSpace) : truncated}...';
  }

  /// Remove all HTML tags.
  String get stripHtml {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// Check if string contains only digits.
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string is a strong password.
  bool get isStrongPassword {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(this);
  }

  /// Convert string to initials (e.g. "John Doe" -> "JD").
  String get initials {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words.last[0]}'.toUpperCase();
  }

  /// Check if string is blank (empty or only whitespace).
  bool get isBlank => trim().isEmpty;

  /// Check if string is not blank.
  bool get isNotBlank => !isBlank;

  /// Convert camelCase to snake_case.
  String get camelToSnake {
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      final char = this[i];
      if (char == char.toUpperCase() && char != char.toLowerCase()) {
        if (i > 0) buffer.write('_');
        buffer.write(char.toLowerCase());
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  /// Convert snake_case to camelCase.
  String get snakeToCamel {
    final words = split('_');
    final buffer = StringBuffer(words[0]);
    for (var i = 1; i < words.length; i++) {
      buffer.write(words[i].capitalize);
    }
    return buffer.toString();
  }

  /// Attempt to parse as int, returns null on failure.
  int? toIntOrNull() => int.tryParse(this);

  /// Attempt to parse as double, returns null on failure.
  double? toDoubleOrNull() => double.tryParse(this);
}
