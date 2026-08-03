import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class LearningCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final Color? accentColor;
  final double? progress;
  final List<Widget>? chips;
  final List<Widget>? actions;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const LearningCard({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.icon,
    this.iconColor,
    this.accentColor,
    this.progress,
    this.chips,
    this.actions,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        elevation: 0,
        color: AppColors.cardLight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (accentColor != null)
              Container(
                width: 4,
                height: null,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.radiusMd),
                    bottomLeft: Radius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: padding ?? AppSpacing.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (icon != null) ...[
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: (iconColor ?? AppColors.primaryLight)
                                  .withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              icon,
                              size: AppSpacing.iconSm,
                              color: iconColor ?? AppColors.primaryLight,
                            ),
                          ),
                          AppSpacing.hGapSm,
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTypography.titleSmall(
                                  color: AppColors.textPrimaryLight,
                                ),
                              ),
                              if (subtitle != null) ...[
                                AppSpacing.gapXxs,
                                Text(
                                  subtitle!,
                                  style: AppTypography.bodySmall(
                                    color: AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (description != null) ...[
                      AppSpacing.gapSm,
                      Text(
                        description!,
                        style: AppTypography.bodyMedium(
                          color: AppColors.textSecondaryLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (chips != null && chips!.isNotEmpty) ...[
                      AppSpacing.gapSm,
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: chips!,
                      ),
                    ],
                    if (progress != null) ...[
                      AppSpacing.gapSm,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        child: LinearProgressIndicator(
                          value: progress!.clamp(0.0, 1.0),
                          minHeight: 4,
                          backgroundColor: AppColors.surfaceVariantLight,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accentColor ?? AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ],
                    if (actions != null && actions!.isNotEmpty) ...[
                      AppSpacing.gapMd,
                      Row(
                        children: actions!,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
