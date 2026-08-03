import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';

class SalaryInsightsScreen extends ConsumerWidget {

  const SalaryInsightsScreen({super.key, required this.jobTitle});
  final String jobTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final insight = ref.watch(salaryInsightProvider(jobTitle));

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Salary Insights', style: AppTypography.titleLarge()),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingBase,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverview(context, insight),
            AppSpacing.gapLg,
            _buildDistributionChart(context, insight),
            AppSpacing.gapLg,
            _buildByExperience(context, insight),
            AppSpacing.gapLg,
            _buildByLocation(context, insight),
          ],
        ),
      ),
    );
  }

  Widget _buildOverview(BuildContext context, SalaryInsight insight) {
    return Container(
      padding: AppSpacing.paddingBase,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Column(
        children: [
          Text(insight.title, style: AppTypography.titleMedium(color: Colors.white)),
          AppSpacing.gapMd,
          Text('\$${(insight.average / 1000).toStringAsFixed(0)}k', style: AppTypography.displaySmall(color: Colors.white)),
          Text('Average Salary', style: AppTypography.bodyMedium(color: Colors.white.withValues(alpha: 0.8))),
          AppSpacing.gapMd,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _salaryItem('Low', '\$${(insight.min / 1000).toStringAsFixed(0)}k', Colors.white),
              _salaryItem('25th', '\$${(insight.p25 / 1000).toStringAsFixed(0)}k', Colors.white),
              _salaryItem('75th', '\$${(insight.p75 / 1000).toStringAsFixed(0)}k', Colors.white),
              _salaryItem('High', '\$${(insight.max / 1000).toStringAsFixed(0)}k', Colors.white),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _salaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: AppTypography.titleSmall(color: color)),
        Text(label, style: AppTypography.bodySmall(color: color.withValues(alpha: 0.7))),
      ],
    );
  }

  Widget _buildDistributionChart(BuildContext context, SalaryInsight insight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Salary Distribution', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        Container(
          height: 200,
          padding: AppSpacing.paddingBase,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: CustomPaint(
            size: const Size(double.infinity, 170),
            painter: _BarChartPainter(insight),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildByExperience(BuildContext context, SalaryInsight insight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('By Experience Level', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        ...insight.byExperience.map((s) {
          final fraction = s.salary / insight.max;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s.experience, style: AppTypography.bodyMedium()),
                    Text('\$${(s.salary / 1000).toStringAsFixed(0)}k', style: AppTypography.labelMedium(color: AppColors.primaryLight)),
                  ],
                ),
                AppSpacing.gapXs,
                ClipRRect(
                  borderRadius: AppSpacing.borderRadiusFull,
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 8,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryLight),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildByLocation(BuildContext context, SalaryInsight insight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('By Location', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        ...insight.byLocation.map((s) {
          final fraction = s.salary / insight.max;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s.location, style: AppTypography.bodyMedium()),
                    Text('\$${(s.salary / 1000).toStringAsFixed(0)}k', style: AppTypography.labelMedium(color: AppColors.secondaryLight)),
                  ],
                ),
                AppSpacing.gapXs,
                ClipRRect(
                  borderRadius: AppSpacing.borderRadiusFull,
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 8,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    valueColor: const AlwaysStoppedAnimation(AppColors.secondaryLight),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter(this.insight);
  final SalaryInsight insight;

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (insight.byExperience.length * 2);
    final maxSalary = insight.max;

    for (var i = 0; i < insight.byExperience.length; i++) {
      final barHeight = (insight.byExperience[i].salary / maxSalary) * size.height;
      final x = (i * 2 + 0.5) * barWidth;
      final y = size.height - barHeight;

      final paint = Paint()
        ..color = AppColors.primaryLight.withValues(alpha: 0.8);

      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, y, barWidth, barHeight), const Radius.circular(4)),
        paint,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: '\$${(insight.byExperience[i].salary / 1000).toStringAsFixed(0)}k',
          style: const TextStyle(color: AppColors.primaryLight, fontSize: 10, fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(x + (barWidth - textPainter.width) / 2, y - 16));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
