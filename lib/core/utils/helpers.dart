import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  Helpers._();

  // --- Launch URL ---
  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': ?subject,
        'body': ?body,
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // --- Debounce ---
  static Timer? _debounceTimer;

  static VoidCallback debounce(
    VoidCallback callback, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    return () {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(delay, callback);
    };
  }

  // --- Global Navigator Key ---
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  // --- Platform Check ---
  static bool get isAndroid =>
      Theme.of(context!).platform == TargetPlatform.android;

  static bool get isIOS =>
      Theme.of(context!).platform == TargetPlatform.iOS;

  // --- Show Confirmation Dialog ---
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: confirmColor != null
                ? TextButton.styleFrom(foregroundColor: confirmColor)
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // --- Show Bottom Sheet ---
  static Future<T?> showAppBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      builder: (_) => child,
    );
  }
}
