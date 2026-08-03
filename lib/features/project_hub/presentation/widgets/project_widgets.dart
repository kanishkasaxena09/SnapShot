import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/project_entities.dart';

class DifficultyBadge extends StatelessWidget {
  const DifficultyBadge({super.key, required this.difficulty});
  final ProjectDifficulty difficulty;

  Color get _color {
    switch (difficulty) {
      case ProjectDifficulty.easy: return Colors.green;
      case ProjectDifficulty.medium: return AppColors.accentOrange;
      case ProjectDifficulty.hard: return AppColors.accentPink;
      case ProjectDifficulty.advanced: return Colors.deepPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: AppSpacing.borderRadiusXs,
      ),
      child: Text(difficulty.name.toUpperCase(), style: AppTypography.labelSmall(color: _color)),
    );
  }
}

class TechnologyChip extends StatelessWidget {
  const TechnologyChip({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: AppSpacing.borderRadiusXs,
      ),
      child: Text(label, style: AppTypography.labelSmall(color: Theme.of(context).colorScheme.onSurfaceVariant)),
    );
  }
}

class PortfolioValueBar extends StatelessWidget {
  const PortfolioValueBar({super.key, required this.value});
  final int value;

  Color get _color {
    if (value >= 90) return Colors.green;
    if (value >= 75) return AppColors.accentBlue;
    if (value >= 60) return AppColors.accentOrange;
    return AppColors.textSecondaryLight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Portfolio Value', style: AppTypography.labelSmall(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            Text('$value/100', style: AppTypography.labelMedium(color: _color)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: AppSpacing.borderRadiusXs,
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 6,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation(_color),
          ),
        ),
      ],
    );
  }
}
