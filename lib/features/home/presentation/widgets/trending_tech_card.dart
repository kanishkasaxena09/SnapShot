import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class TrendingTechSection extends StatelessWidget {
  const TrendingTechSection({super.key, required this.technologies});

  final List<TrendingTechnology> technologies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Trending Technologies'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: technologies.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              return _TechChip(tech: technologies[index])
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 60 * index),
                    duration: 300.ms,
                  );
            },
          ),
        ),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip({required this.tech});

  final TrendingTechnology tech;

  @override
  Widget build(BuildContext context) {
    final isUp = tech.trendPercent >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: tech.color.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusFull,
        border: Border.all(
          color: tech.color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tech.icon, size: 16, color: tech.color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            tech.name,
            style: AppTypography.labelMedium(
              color: tech.color,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Icon(
            isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            size: 12,
            color: isUp ? Colors.green : Colors.red,
          ),
          Text(
            '${tech.trendPercent.abs().toStringAsFixed(1)}%',
            style: AppTypography.labelSmall(
              color: isUp ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
