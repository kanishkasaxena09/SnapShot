class Validators {
  Validators._();

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain a number';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain a special character';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digits = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length < 10 || digits.length > 15) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // URLs are optional
    }
    final uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasAbsolutePath) {
      return 'Enter a valid URL';
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.length < min) {
      return '${fieldName ?? 'This field'} must be at least $min characters';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) {
      return '${fieldName ?? 'This field'} must be at most $max characters';
    }
    return null;
  }

  static String? range(String? value, int min, int max, {String? fieldName}) {
    final numVal = num.tryParse(value ?? '');
    if (numVal == null || numVal < min || numVal > max) {
      return '${fieldName ?? 'Value'} must be between $min and $max';
    }
    return null;
  }

  static String? noWhitespace(String? value, {String? fieldName}) {
    if (value != null && value.contains(' ')) {
      return '${fieldName ?? 'This field'} cannot contain spaces';
    }
    return null;
  }

  /// Compose multiple validators.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
