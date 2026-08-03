import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

extension BuildContextExtensions on BuildContext {
  // --- Theme ---
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // --- Brightness ---
  Brightness get brightness => theme.brightness;
  bool get isDarkMode => brightness == Brightness.dark;

  // --- MediaQuery ---
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get topPadding => mediaQuery.padding.top;
  double get bottomPadding => mediaQuery.padding.bottom;
  double get viewInsets => mediaQuery.viewInsets.bottom;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  // --- Screen Size Checks ---
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
  bool get isSmallScreen => screenWidth < 360;

  // --- Navigation ---
  NavigatorState get navigator => Navigator.of(this);
  void pop<T>([T? result]) => navigator.pop<T>(result);
  Future<T?> pushNamed<T>(String name, {Object? arguments}) =>
      navigator.pushNamed<T>(name, arguments: arguments);

  // --- SnackBar ---
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            AppSpacing.hGapSm,
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.errorLight,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            AppSpacing.hGapSm,
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.successLight,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // --- Focus ---
  void unfocus() => FocusScope.of(this).unfocus();

  // --- Text Scale ---
  TextScaler get textScaler => mediaQuery.textScaler;
}
