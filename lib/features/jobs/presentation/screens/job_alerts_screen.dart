import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';

class JobAlertsScreen extends ConsumerWidget {
  const JobAlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final alerts = ref.watch(jobAlertsProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Job Alerts', style: AppTypography.titleLarge()),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateAlertSheet(context, ref),
        backgroundColor: AppColors.primaryLight,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: alerts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                  AppSpacing.gapMd,
                  Text('No job alerts', style: AppTypography.titleMedium(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                  AppSpacing.gapSm,
                  Text('Create alerts to get notified about matching jobs', style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.4))),
                ],
              ),
            )
          : ListView.separated(
              padding: AppSpacing.paddingBase,
              itemCount: alerts.length,
              separatorBuilder: (_, __) => AppSpacing.gapMd,
              itemBuilder: (context, index) => _buildAlertCard(alerts[index], ref, context)
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 40 * index), duration: 350.ms),
            ),
    );
  }

  Widget _buildAlertCard(JobAlert alert, WidgetRef ref, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
        boxShadow: [BoxShadow(color: AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                alert.isActive ? Icons.notifications_active_rounded : Icons.notifications_off_rounded,
                color: alert.isActive ? AppColors.primaryLight : colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              AppSpacing.hGapSm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.title, style: AppTypography.titleSmall()),
                    Text(alert.keywords, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.6))),
                  ],
                ),
              ),
              Switch(
                value: alert.isActive,
                onChanged: (_) => ref.read(jobAlertsProvider.notifier).toggle(alert.id),
                activeColor: AppColors.primaryLight,
              ),
            ],
          ),
          AppSpacing.gapSm,
          Row(
            children: [
              if (alert.location != null) ...[
                Icon(Icons.location_on_outlined, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                AppSpacing.hGapXs,
                Text(alert.location!, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                AppSpacing.hGapMd,
              ],
              Icon(Icons.work_outline_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.4)),
              AppSpacing.hGapXs,
              Text('${alert.matchCount} matches', style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.5))),
              const Spacer(),
              GestureDetector(
                onTap: () => ref.read(jobAlertsProvider.notifier).remove(alert.id),
                child: Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.errorLight.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateAlertSheet(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final keywordsCtrl = TextEditingController();
    final locationCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(ctx).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Job Alert', style: AppTypography.titleLarge()),
            AppSpacing.gapMd,
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: 'Alert Name', border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd))),
            AppSpacing.gapMd,
            TextField(controller: keywordsCtrl, decoration: InputDecoration(labelText: 'Keywords', border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd))),
            AppSpacing.gapMd,
            TextField(controller: locationCtrl, decoration: InputDecoration(labelText: 'Location (optional)', border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd))),
            AppSpacing.gapLg,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleCtrl.text.isNotEmpty && keywordsCtrl.text.isNotEmpty) {
                    ref.read(jobAlertsProvider.notifier).add(JobAlert(
                      id: 'al${DateTime.now().millisecondsSinceEpoch}',
                      title: titleCtrl.text,
                      keywords: keywordsCtrl.text,
                      location: locationCtrl.text.isEmpty ? null : locationCtrl.text,
                      isActive: true,
                      createdAt: DateTime.now().toIso8601String().substring(0, 10),
                      matchCount: 0,
                    ));
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLight, foregroundColor: Colors.white),
                child: Text('Create Alert', style: AppTypography.labelLarge(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
