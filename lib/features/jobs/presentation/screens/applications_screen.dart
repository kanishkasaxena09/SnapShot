import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';
import '../widgets/application_status_chip.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final applications = ref.watch(applicationsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: Text('My Applications', style: AppTypography.titleLarge()),
          leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
          bottom: TabBar(
            labelColor: AppColors.primaryLight,
            unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.5),
            indicatorColor: AppColors.primaryLight,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Interviews'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(applications.where((a) =>
                a.status != ApplicationStatus.rejected &&
                a.status != ApplicationStatus.withdrawn &&
                a.status != ApplicationStatus.offered).toList(), context, ref),
            _buildList(applications.where((a) => a.status == ApplicationStatus.interviewScheduled).toList(), context, ref),
            _buildList(applications.where((a) =>
                a.status == ApplicationStatus.rejected ||
                a.status == ApplicationStatus.withdrawn ||
                a.status == ApplicationStatus.offered).toList(), context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<JobApplication> apps, BuildContext context, WidgetRef ref) {
    if (apps.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
            AppSpacing.gapMd,
            Text('No applications here', style: AppTypography.titleMedium(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: AppSpacing.paddingBase,
      itemCount: apps.length,
      separatorBuilder: (_, __) => AppSpacing.gapMd,
        itemBuilder: (context, index) => _buildApplicationCard(apps[index], context, ref)
          .animate()
          .fadeIn(delay: Duration(milliseconds: 40 * index), duration: 350.ms),
    );
  }

  Widget _buildApplicationCard(JobApplication app, BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push('/jobs/${app.job.id}'),
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(color: AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Center(child: Text(app.job.company.logo, style: AppTypography.titleMedium(color: AppColors.primaryLight))),
                ),
                AppSpacing.hGapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(app.job.title, style: AppTypography.titleSmall(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(app.job.company.name, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
                ApplicationStatusChip(status: app.status),
              ],
            ),
            AppSpacing.gapSm,
            Row(
              children: [
                Icon(Icons.calendar_today_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                AppSpacing.hGapXs,
                Text('Applied: ${app.appliedDate}', style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                if (app.lastUpdated != null) ...[
                  AppSpacing.hGapSm,
                  Icon(Icons.update_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  AppSpacing.hGapXs,
                  Text('Updated: ${app.lastUpdated}', style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                ],
              ],
            ),
            if (app.interviewDate != null) ...[
              AppSpacing.gapSm,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentCyan.withValues(alpha: 0.1),
                  borderRadius: AppSpacing.borderRadiusFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.event_rounded, size: 14, color: AppColors.accentCyan),
                    AppSpacing.hGapXs,
                    Text('Interview: ${app.interviewDate}', style: AppTypography.labelSmall(color: AppColors.accentCyan)),
                  ],
                ),
              ),
            ],
            if (app.status != ApplicationStatus.withdrawn && app.status != ApplicationStatus.rejected && app.status != ApplicationStatus.offered) ...[
              AppSpacing.gapSm,
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _confirmWithdraw(context, app, ref),
                  child: Text('Withdraw', style: AppTypography.bodySmall(color: AppColors.errorLight)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _confirmWithdraw(BuildContext context, JobApplication app, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Withdraw Application?'),
        content: Text('Are you sure you want to withdraw your application for ${app.job.title}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(applicationsProvider.notifier).withdraw(app.id);
              Navigator.pop(ctx);
            },
            child: Text('Withdraw', style: TextStyle(color: AppColors.errorLight)),
          ),
        ],
      ),
    );
  }
}
