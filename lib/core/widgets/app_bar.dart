import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum AppBarVariant { standard, large, transparent }

class SnapAppBar extends StatelessWidget implements PreferredSizeWidget {

  const SnapAppBar({
    super.key,
    required this.title,
    this.variant = AppBarVariant.standard,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.backgroundColor,
    this.elevation,
    this.centerTitle = false,
  });
  final String title;
  final AppBarVariant variant;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final double? elevation;
  final bool centerTitle;

  @override
  Size get preferredSize => Size.fromHeight(
        variant == AppBarVariant.large
            ? AppSpacing.appBarHeightLg + 20
            : AppSpacing.appBarHeight,
      );

  @override
  Widget build(BuildContext context) {
    if (variant == AppBarVariant.large) {
      return _buildLargeAppBar(context);
    }
    return _buildStandardAppBar(context);
  }

  AppBar _buildStandardAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation ?? 0,
    );
  }

  AppBar _buildLargeAppBar(BuildContext context) {
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      centerTitle: false,
      backgroundColor: backgroundColor,
      elevation: elevation ?? 0,
      flexibleSpace: flexibleSpace ??
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.base,
                bottom: AppSpacing.md,
              ),
              child: Text(
                title,
                style: AppTypography.headlineLarge(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
    );
  }
}
