import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // --- Primitive Values ---
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double xxxxl = 48;
  static const double huge = 64;
  static const double massive = 80;

  // --- Named Scale (for padding/margin shortcuts) ---
  static const EdgeInsetsGeometry paddingXxs = EdgeInsets.all(xxs);
  static const EdgeInsetsGeometry paddingXs = EdgeInsets.all(xs);
  static const EdgeInsetsGeometry paddingSm = EdgeInsets.all(sm);
  static const EdgeInsetsGeometry paddingMd = EdgeInsets.all(md);
  static const EdgeInsetsGeometry paddingBase = EdgeInsets.all(base);
  static const EdgeInsetsGeometry paddingLg = EdgeInsets.all(lg);
  static const EdgeInsetsGeometry paddingXl = EdgeInsets.all(xl);
  static const EdgeInsetsGeometry paddingXxl = EdgeInsets.all(xxl);

  // --- Horizontal ---
  static const EdgeInsetsGeometry paddingHorizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsetsGeometry paddingHorizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsetsGeometry paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsetsGeometry paddingHorizontalBase = EdgeInsets.symmetric(horizontal: base);
  static const EdgeInsetsGeometry paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsetsGeometry paddingHorizontalXl = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsetsGeometry paddingHorizontalXxl = EdgeInsets.symmetric(horizontal: xxl);

  // --- Vertical ---
  static const EdgeInsetsGeometry paddingVerticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsetsGeometry paddingVerticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsetsGeometry paddingVerticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsetsGeometry paddingVerticalBase = EdgeInsets.symmetric(vertical: base);
  static const EdgeInsetsGeometry paddingVerticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsetsGeometry paddingVerticalXl = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsetsGeometry paddingVerticalXxl = EdgeInsets.symmetric(vertical: xxl);

  // --- Specific Screen Paddings ---
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: base,
    vertical: lg,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(base);

  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: base,
    vertical: md,
  );

  // --- Gaps (SizedBox shortcuts) ---
  static const SizedBox gapXxs = SizedBox(height: xxs);
  static const SizedBox gapXs = SizedBox(height: xs);
  static const SizedBox gapSm = SizedBox(height: sm);
  static const SizedBox gapMd = SizedBox(height: md);
  static const SizedBox gapBase = SizedBox(height: base);
  static const SizedBox gapLg = SizedBox(height: lg);
  static const SizedBox gapXl = SizedBox(height: xl);
  static const SizedBox gapXxl = SizedBox(height: xxl);
  static const SizedBox gapXxxl = SizedBox(height: xxxl);

  // --- Horizontal Gaps ---
  static const SizedBox hGapXxs = SizedBox(width: xxs);
  static const SizedBox hGapXs = SizedBox(width: xs);
  static const SizedBox hGapSm = SizedBox(width: sm);
  static const SizedBox hGapMd = SizedBox(width: md);
  static const SizedBox hGapBase = SizedBox(width: base);
  static const SizedBox hGapLg = SizedBox(width: lg);
  static const SizedBox hGapXl = SizedBox(width: xl);
  static const SizedBox hGapXxl = SizedBox(width: xxl);

  // --- Border Radius ---
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusXxl = 24;
  static const double radiusFull = 999;

  static BorderRadius borderRadiusXs = BorderRadius.circular(radiusXs);
  static BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static BorderRadius borderRadiusXxl = BorderRadius.circular(radiusXxl);
  static BorderRadius borderRadiusFull = BorderRadius.circular(radiusFull);

  // --- Icon Sizes ---
  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconBase = 24;
  static const double iconLg = 32;
  static const double iconXl = 40;
  static const double iconXxl = 48;

  // --- Button Heights ---
  static const double buttonHeightSm = 32;
  static const double buttonHeightMd = 40;
  static const double buttonHeightLg = 48;
  static const double buttonHeightXl = 56;

  // --- App Bar ---
  static const double appBarHeight = 56;
  static const double appBarHeightLg = 64;

  // --- Bottom Nav ---
  static const double bottomNavHeight = 64;

  // --- Card ---
  static const double cardElevation = 0;
  static const double cardElevationHover = 4;

  // --- Divider ---
  static const double dividerThickness = 1;
  static const double dividerHeight = 1;

  // --- Misc ---
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;
  static const double avatarXl = 80;
  static const double avatarXxl = 120;

  static const double chipHeight = 32;
  static const double chipHeightLg = 40;

  static const double tabBarHeight = 48;
  static const double bottomSheetHandleWidth = 40;
  static const double bottomSheetHandleHeight = 4;
}
