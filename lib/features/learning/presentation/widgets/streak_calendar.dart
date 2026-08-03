import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';

class StreakCalendar extends StatelessWidget {
  final List<StreakDay> days;
  final double size;

  const StreakCalendar({
    super.key,
    required this.days,
    this.size = 16,
  });

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _monthLabels = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  Color _getIntensityColor(int minutesStudied) {
    if (minutesStudied <= 0) return AppColors.surfaceVariantLight;
    if (minutesStudied <= 15) return AppColors.successLight.withValues(alpha: 0.3);
    if (minutesStudied <= 30) return AppColors.successLight.withValues(alpha: 0.5);
    if (minutesStudied <= 60) return AppColors.successLight.withValues(alpha: 0.7);
    return AppColors.successLight;
  }

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) return const SizedBox.shrink();

    final sortedDays = List<StreakDay>.from(days)
      ..sort((a, b) => a.date.compareTo(b.date));

    final dayMap = <DateTime, StreakDay>{};
    for (final day in sortedDays) {
      final key = DateTime(day.date.year, day.date.month, day.date.day);
      dayMap[key] = day;
    }

    final monthWidgets = <Widget>[];
    final uniqueMonths = <String>[];
    for (final day in sortedDays) {
      final key = '${day.date.year}-${day.date.month}';
      if (!uniqueMonths.contains(key)) {
        uniqueMonths.add(key);
      }
    }

    for (final monthKey in uniqueMonths) {
      final parts = monthKey.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);

      final monthDays = sortedDays.where(
        (d) => d.date.year == year && d.date.month == month,
      ).toList();

      if (monthDays.isEmpty) continue;

      final firstOfMonth = monthDays.first.date;
      final lastOfMonth = monthDays.last.date;
      final startPadding = firstOfMonth.weekday - 1;
      final daysInMonth = lastOfMonth.day;

      final cells = <Widget>[];
      for (var i = 0; i < startPadding; i++) {
        cells.add(SizedBox(width: size, height: size));
      }

      for (var day = 1; day <= daysInMonth; day++) {
        final date = DateTime(year, month, day);
        final streakDay = dayMap[date];
        final isActive = streakDay?.isActive ?? false;
        final minutes = streakDay?.minutesStudied ?? 0;

        cells.add(
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isActive
                  ? _getIntensityColor(minutes)
                  : AppColors.surfaceVariantLight,
              borderRadius: BorderRadius.circular(size * 0.25),
            ),
          ),
        );
      }

      monthWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                '${_monthLabels[month - 1]} $year',
                style: AppTypography.labelSmall(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),
            Row(
              children: _dayLabels
                  .map(
                    (label) => SizedBox(
                      width: size,
                      child: Center(
                        child: Text(
                          label,
                          style: AppTypography.labelSmall(
                            color: AppColors.textTertiaryLight,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: cells,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...monthWidgets,
      ].expand((widget) => [widget, const SizedBox(height: AppSpacing.md)]).toList()
        ..removeLast(),
    );
  }
}
