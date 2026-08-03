import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/detail_not_found_screen.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';
import '../widgets/ai_match_score_badge.dart';
import '../widgets/application_status_chip.dart';

class JobDetailScreen extends ConsumerWidget {

  const JobDetailScreen({super.key, required this.jobId});
  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final job = ref.watch(jobDetailProvider(jobId));

    if (job == null) return const DetailNotFoundScreen(title: 'Job');

    final savedJobs = ref.watch(savedJobsProvider);
    final isSaved = savedJobs.contains(job.id);
    final applications = ref.watch(applicationsProvider);
    final hasApplied = applications.any((a) => a.job.id == job.id);
    final appliedApp = hasApplied ? applications.firstWhere((a) => a.job.id == job.id) : null;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () => ref.read(savedJobsProvider.notifier).toggle(job.id),
                icon: Icon(isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(job.title, style: AppTypography.titleMedium(color: colorScheme.onSurface)),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16, right: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.paddingBase,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompanyHeader(context, job),
                  AppSpacing.gapLg,
                  _buildQuickInfo(context, job),
                  AppSpacing.gapLg,
                  AIMatchScoreBadge.large(context, job.aiMatchScore),
                  AppSpacing.gapLg,
                  if (hasApplied && appliedApp != null) ...[
                    _buildApplicationStatus(context, appliedApp),
                    AppSpacing.gapLg,
                  ],
                  _buildSection('About the Role', job.description),
                  AppSpacing.gapLg,
                  _buildSection('Requirements', null, items: job.requirements),
                  AppSpacing.gapLg,
                  _buildSection('Responsibilities', null, items: job.responsibilities),
                  AppSpacing.gapLg,
                  _buildSection('Benefits', null, items: job.benefits),
                  AppSpacing.gapLg,
                  _buildSkillsSection(context, job.skills),
                  AppSpacing.gapLg,
                  _buildSalarySection(context, job),
                  AppSpacing.gapXl,
                  _buildRelatedSection(context, job, ref),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(context, ref, job, hasApplied),
    );
  }

  Widget _buildCompanyHeader(BuildContext context, Job job) {
    return GestureDetector(
      onTap: () => context.push('/jobs/company/${job.company.id}'),
      child: Row(
        children: [
          Hero(
            tag: 'job_logo_${job.id}',
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: Center(
                child: Text(job.company.logo, style: AppTypography.headlineSmall(color: AppColors.primaryLight)),
              ),
            ),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(job.company.name, style: AppTypography.titleMedium()),
                    if (job.company.isVerified) ...[
                      AppSpacing.hGapXs,
                      Icon(Icons.verified_rounded, size: 16, color: AppColors.accentBlue),
                    ],
                  ],
                ),
                AppSpacing.gapXxs,
                Text('${job.company.industry} • ${job.company.size}', style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
                AppSpacing.gapXxs,
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: AppColors.accentOrange),
                    AppSpacing.hGapXxs,
                    Text('${job.company.rating}', style: AppTypography.labelSmall(color: AppColors.accentOrange)),
                    AppSpacing.hGapXs,
                    Text('(${job.company.reviewCount} reviews)', style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildQuickInfo(BuildContext context, Job job) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _infoChip(Icons.location_on_outlined, job.location, colorScheme),
        _infoChip(job.typeIcon, job.typeLabel, colorScheme),
        _infoChip(Icons.work_outline_rounded, job.experienceLabel, colorScheme),
        if (job.isRemote) _infoChip(Icons.language_rounded, 'Remote', colorScheme),
        _infoChip(Icons.schedule_rounded, job.postedDate, colorScheme),
        _infoChip(Icons.people_outline_rounded, '${job.applicants} applicants', colorScheme),
      ],
    );
  }

  Widget _infoChip(IconData icon, String label, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.6)),
          AppSpacing.hGapXs,
          Text(label, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.7))),
        ],
      ),
    );
  }

  Widget _buildApplicationStatus(BuildContext context, JobApplication app) {
    return Container(
      padding: AppSpacing.paddingBase,
      decoration: BoxDecoration(
        color: app.statusColor.withValues(alpha: 0.05),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: app.statusColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          ApplicationStatusChip(status: app.status),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Application ${app.statusLabel}', style: AppTypography.titleSmall()),
                if (app.interviewDate != null)
                  Text('Interview: ${app.interviewDate}', style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildSection(String title, String? description, {List<String>? items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        if (description != null)
          Text(description, style: AppTypography.bodyMedium(color: Colors.grey[600]), textAlign: TextAlign.justify),
        if (items != null)
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                ),
                AppSpacing.hGapSm,
                Expanded(child: Text(item, style: AppTypography.bodyMedium(color: Colors.grey[600]))),
              ],
            ),
          )),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildSkillsSection(BuildContext context, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills & Technologies', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: skills.map((s) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusFull,
            ),
            child: Text(s, style: AppTypography.labelMedium(color: AppColors.primaryLight)),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildSalarySection(BuildContext context, Job job) {
    return Container(
      padding: AppSpacing.paddingBase,
      decoration: BoxDecoration(
        color: AppColors.secondaryLight.withValues(alpha: 0.05),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.secondaryLight.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_money_rounded, color: AppColors.secondaryLight),
          AppSpacing.hGapSm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Salary Range', style: AppTypography.labelMedium(color: AppColors.secondaryLight)),
                Text(job.salaryRange, style: AppTypography.titleMedium()),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/jobs/salary-insights/${job.title}'),
            child: Text('Insights', style: AppTypography.labelMedium(color: AppColors.secondaryLight)),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedSection(BuildContext context, Job job, WidgetRef ref) {
    final allJobs = ref.read(allJobsProvider);
    final related = allJobs.where((j) => j.id != job.id && j.company.id == job.company.id).toList();

    if (related.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('More at ${job.company.name}', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        ...related.take(3).map((j) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Center(child: Text(j.company.logo, style: AppTypography.titleSmall(color: AppColors.primaryLight))),
            ),
            title: Text(j.title, style: AppTypography.titleSmall()),
            subtitle: Text(j.salaryRange, style: AppTypography.bodySmall()),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push('/jobs/${j.id}'),
          ),
        )),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, Job job, bool hasApplied) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => ref.read(savedJobsProvider.notifier).toggle(job.id),
                icon: Icon(
                  ref.watch(savedJobsProvider).contains(job.id) ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  size: 18,
                ),
                label: Text(ref.watch(savedJobsProvider).contains(job.id) ? 'Saved' : 'Save'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.primaryLight),
                  foregroundColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                ),
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: hasApplied ? null : () => context.push('/jobs/apply/${job.id}'),
                icon: Icon(hasApplied ? Icons.check_rounded : Icons.send_rounded, size: 18),
                label: Text(hasApplied ? 'Applied' : 'Apply Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.successLight.withValues(alpha: 0.2),
                  disabledForegroundColor: AppColors.successLight,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
