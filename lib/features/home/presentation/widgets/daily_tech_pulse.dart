import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class DailyTechPulse extends StatelessWidget {
  const DailyTechPulse({super.key, required this.stats});

  final List<TechPulseStat> stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Daily Tech Pulse'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: stats.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return _PulseStatCard(stat: stats[index])
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 80 * index),
                    duration: 350.ms,
                  )
                  .slideX(begin: 0.1);
            },
          ),
        ),
      ],
    );
  }
}

class _PulseStatCard extends StatelessWidget {
  const _PulseStatCard({required this.stat});

  final TechPulseStat stat;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 140,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.12),
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(stat.icon, color: stat.color, size: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.value,
                style: AppTypography.titleMedium(
                  color: colorScheme.onSurface,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      stat.label,
                      style: AppTypography.bodySmall(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (stat.trend != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      stat.trend! >= 0
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 12,
                      color: stat.trend! >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
