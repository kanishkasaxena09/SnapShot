import 'package:flutter/material.dart';

enum ScreenSize { mobile, tablet, desktop }

class ResponsiveUtil {
  ResponsiveUtil._();

  // --- Breakpoints ---
  static const double mobileMax = 599;
  static const double tabletMin = 600;
  static const double tabletMax = 1023;
  static const double desktopMin = 1024;

  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < tabletMin) return ScreenSize.mobile;
    if (width < desktopMin) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  static bool isMobile(BuildContext context) =>
      getScreenSize(context) == ScreenSize.mobile;

  static bool isTablet(BuildContext context) =>
      getScreenSize(context) == ScreenSize.tablet;

  static bool isDesktop(BuildContext context) =>
      getScreenSize(context) == ScreenSize.desktop;

  static bool isMobileOrTablet(BuildContext context) {
    final size = getScreenSize(context);
    return size == ScreenSize.mobile || size == ScreenSize.tablet;
  }

  // --- Value based on screen size ---
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final size = getScreenSize(context);
    return switch (size) {
      ScreenSize.mobile => mobile,
      ScreenSize.tablet => tablet ?? mobile,
      ScreenSize.desktop => desktop ?? tablet ?? mobile,
    };
  }

  // --- Grid column count ---
  static int gridColumns(BuildContext context) {
    return responsive(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }

  static int gridColumnsCompact(BuildContext context) {
    return responsive(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );
  }

  // --- Content max width ---
  static double contentMaxWidth(BuildContext context) {
    return responsive(
      context,
      mobile: double.infinity,
      tablet: 720,
      desktop: 1024,
    );
  }

  // --- Horizontal padding ---
  static double horizontalPadding(BuildContext context) {
    return responsive(
      context,
      mobile: 16,
      tablet: 24,
      desktop: 32,
    );
  }
}

/// A widget that builds different layouts based on screen size.
class ResponsiveLayout extends StatelessWidget {

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveUtil.responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

/// A responsive grid view that adjusts columns based on screen size.
class ResponsiveGrid extends StatelessWidget {

  const ResponsiveGrid({
    super.key,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.spacing = 16,
    this.runSpacing = 16,
    required this.children,
    this.shrinkWrap = false,
    this.physics,
  });
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double spacing;
  final double runSpacing;
  final List<Widget> children;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtil.responsive(
      context,
      mobile: mobileColumns ?? 1,
      tablet: tabletColumns ?? 2,
      desktop: desktopColumns ?? 3,
    );

    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: spacing,
      mainAxisSpacing: runSpacing,
      shrinkWrap: shrinkWrap,
      physics: physics,
      childAspectRatio: 1.5,
      children: children,
    );
  }
}

/// A responsive container that constrains content width on larger screens.
class ResponsiveContainer extends StatelessWidget {

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveMaxWidth = maxWidth ?? ResponsiveUtil.contentMaxWidth(context);
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: ResponsiveUtil.horizontalPadding(context),
        );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );
  }
}
