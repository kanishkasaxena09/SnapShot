import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';

class ApplicationStatusChip extends StatelessWidget {

  const ApplicationStatusChip({super.key, required this.status, this.compact = false});
  final ApplicationStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final label = _getStatusLabel();
    final color = _getStatusColor();

    return Container(
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(), size: compact ? 12 : 14, color: color),
          if (!compact) AppSpacing.hGapXs,
          if (!compact) Text(label, style: AppTypography.labelSmall(color: color)),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case ApplicationStatus.submitted:
        return const Color(0xFF2196F3);
      case ApplicationStatus.reviewing:
        return const Color(0xFFFF9800);
      case ApplicationStatus.shortlisted:
        return const Color(0xFF9C27B0);
      case ApplicationStatus.interviewScheduled:
        return const Color(0xFF00BCD4);
      case ApplicationStatus.offered:
        return const Color(0xFF4CAF50);
      case ApplicationStatus.rejected:
        return const Color(0xFFF44336);
      case ApplicationStatus.withdrawn:
        return const Color(0xFF9E9E9E);
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case ApplicationStatus.submitted:
        return 'Submitted';
      case ApplicationStatus.reviewing:
        return 'Under Review';
      case ApplicationStatus.shortlisted:
        return 'Shortlisted';
      case ApplicationStatus.interviewScheduled:
        return 'Interview';
      case ApplicationStatus.offered:
        return 'Offered';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.withdrawn:
        return 'Withdrawn';
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case ApplicationStatus.submitted:
        return Icons.send_rounded;
      case ApplicationStatus.reviewing:
        return Icons.rate_review_rounded;
      case ApplicationStatus.shortlisted:
        return Icons.star_rounded;
      case ApplicationStatus.interviewScheduled:
        return Icons.event_rounded;
      case ApplicationStatus.offered:
        return Icons.check_circle_rounded;
      case ApplicationStatus.rejected:
        return Icons.cancel_rounded;
      case ApplicationStatus.withdrawn:
        return Icons.undo_rounded;
    }
  }
}
