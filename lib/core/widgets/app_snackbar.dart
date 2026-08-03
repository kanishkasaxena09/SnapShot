import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration,
        behavior: behavior,
        margin: const EdgeInsets.all(AppSpacing.base),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    show(
      context,
      message: message,
      duration: const Duration(seconds: 3),
    );
  }

  static void error(BuildContext context, String message) {
    show(
      context,
      message: message,
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  static void warning(BuildContext context, String message) {
    show(
      context,
      message: message,
      duration: const Duration(seconds: 4),
    );
  }
}
