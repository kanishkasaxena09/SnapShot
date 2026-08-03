import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onPressed,
    this.filledIcon = Icons.bookmark_rounded,
    this.outlinedIcon = Icons.bookmark_outline_rounded,
    this.activeColor,
    this.inactiveColor,
    this.size = 24,
  });

  final bool isBookmarked;
  final VoidCallback onPressed;
  final IconData filledIcon;
  final IconData outlinedIcon;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isBookmarked ? filledIcon : outlinedIcon,
        color: isBookmarked
            ? (activeColor ?? AppColors.primaryLight)
            : (inactiveColor ?? AppColors.textSecondaryLight),
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
