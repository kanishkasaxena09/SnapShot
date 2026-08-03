import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';
import '../widgets/job_card.dart';

class CompanyDetailScreen extends ConsumerWidget {

  const CompanyDetailScreen({super.key, required this.companyId});
  final String companyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final company = ref.watch(companyProvider(companyId));
    final companyJobs = ref.watch(companyJobsProvider(companyId));

    if (company == null) {
      return Scaffold(appBar: AppBar(title: const Text('Company')), body: const Center(child: Text('Not found')));
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(company.name, style: AppTypography.titleLarge(color: Colors.white)),
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                child: Center(
                  child: Text(company.logo, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.paddingBase,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickInfo(context, company),
                  AppSpacing.gapLg,
                  _buildSection('About', company.description),
                  AppSpacing.gapLg,
                  _buildSection('Tech Stack', null, tags: company.techStack),
                  AppSpacing.gapLg,
                  _buildStats(context, company),
                  AppSpacing.gapLg,
                  Text('Open Positions (${companyJobs.length})', style: AppTypography.titleMedium()),
                  AppSpacing.gapSm,
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.xs),
                child: JobCard(job: companyJobs[index]),
              ),
              childCount: companyJobs.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(BuildContext context, Company company) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _chip(Icons.business_rounded, company.industry),
        _chip(Icons.people_rounded, company.size),
        _chip(Icons.calendar_today_rounded, 'Est. ${company.founded}'),
        _chip(Icons.location_on_outlined, company.headquarters),
        _chip(Icons.star_rounded, '${company.rating} (${company.reviewCount})'),
      ],
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryLight),
          AppSpacing.hGapXs,
          Text(label, style: AppTypography.bodySmall(color: AppColors.primaryLight)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String? text, {List<String>? tags}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        if (text != null) Text(text, style: AppTypography.bodyMedium(color: Colors.grey[600])),
        if (tags != null)
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusFull,
              ),
              child: Text(t, style: AppTypography.labelSmall(color: AppColors.accentBlue)),
            )).toList(),
          ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, Company company) {
    return Row(
      children: [
        _statItem('Rating', '${company.rating}', Icons.star_rounded, AppColors.accentOrange),
        _statItem('Reviews', '${company.reviewCount}', Icons.reviews_rounded, AppColors.accentBlue),
        _statItem('Size', company.size, Icons.people_rounded, AppColors.secondaryLight),
      ],
    );
  }

  Widget _statItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            AppSpacing.gapXs,
            Text(value, style: AppTypography.titleSmall(color: color)),
            Text(label, style: AppTypography.bodySmall(color: Colors.grey[500])),
          ],
        ),
      ),
    );
  }
}
