import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/score_utils.dart';

class AIMatchScoreBadge extends StatelessWidget {

  const AIMatchScoreBadge({super.key, required this.score, this.size = 56});
  final double score;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = ScoreUtils.colorForScore(score);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_rounded, size: size * 0.22, color: color),
          Text(
            '${score.round()}%',
            style: AppTypography.labelSmall(color: color).copyWith(fontSize: size * 0.2),
          ),
        ],
      ),
    );
  }

  static Widget large(BuildContext context, double score) {
    final color = ScoreUtils.colorForScore(score);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 20, color: color),
          AppSpacing.hGapSm,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('AI Match Score', style: AppTypography.labelSmall(color: color)),
              Text(
                '${score.round()}% Match',
                style: AppTypography.titleMedium(color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
