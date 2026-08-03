import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/job_providers.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/job_card.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final jobs = ref.watch(jobListProvider);
    final filter = ref.watch(jobFilterProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, colorScheme, filter),
            _buildSearchBar(context, colorScheme),
            _buildQuickFilters(context, colorScheme, filter),
            Expanded(
              child: jobs.isEmpty
                  ? _buildEmptyState(context)
                  : _buildJobList(jobs),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme, dynamic filter) {
    return Semantics(
      label: 'Jobs section',
      child: Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.base, AppSpacing.base, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jobs', style: AppTypography.headlineMedium()),
                AppSpacing.gapXxs,
                Text(
                  'Find your dream opportunity',
                  style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
          if (filter.activeCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderRadiusFull,
              ),
              child: Text('${filter.activeCount} active', style: AppTypography.labelSmall(color: AppColors.primaryLight)),
            ),
          AppSpacing.hGapSm,
          IconButton(
            onPressed: () => _openFilters(context),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.tune_rounded, color: colorScheme.onSurface),
                if (filter.activeCount > 0)
                  Positioned(
                    top: -2, right: -2,
                    child: Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push('/jobs/alerts'),
            icon: Icon(Icons.notifications_outlined, color: colorScheme.onSurface),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.md, AppSpacing.base, 0),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => ref.read(jobSearchQueryProvider.notifier).state = v,
        decoration: InputDecoration(
          hintText: 'Search jobs, companies, skills...',
          hintStyle: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.4)),
          prefixIcon: Icon(Icons.search_rounded, color: colorScheme.onSurface.withValues(alpha: 0.4)),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    ref.read(jobSearchQueryProvider.notifier).state = '';
                  },
                  icon: Icon(Icons.clear_rounded, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                )
              : null,
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          border: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.md),
        ),
        style: AppTypography.bodyMedium(),
      ),
    );
  }

  Widget _buildQuickFilters(BuildContext context, ColorScheme colorScheme, dynamic filter) {
    final chips = [
      ('Remote', Icons.language_rounded, filter.remoteOnly),
      ('Full Time', Icons.work_rounded, filter.types.contains('fullTime')),
    ];

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.sm),
        children: [
          ...chips.map((c) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: Text(c.$1),
              avatar: Icon(c.$2, size: 16),
              selected: c.$3,
              onSelected: (_) {},
              selectedColor: AppColors.primaryLight.withValues(alpha: 0.15),
              labelStyle: AppTypography.labelMedium(color: c.$3 ? AppColors.primaryLight : colorScheme.onSurface),
              side: BorderSide(color: c.$3 ? AppColors.primaryLight : colorScheme.outline.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusFull),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ActionChip(
              avatar: Icon(Icons.tune_rounded, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.6)),
              label: Text('Filters', style: AppTypography.labelMedium(color: colorScheme.onSurface)),
              onPressed: () => _openFilters(context),
              shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusFull),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildJobList(List jobs) {
    return RefreshIndicator(
      color: AppColors.primaryLight,
      onRefresh: () async => ref.invalidate(jobListProvider),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.base),
        itemCount: jobs.length,
        separatorBuilder: (_, __) => AppSpacing.gapMd,
        itemBuilder: (context, index) {
          return RepaintBoundary(
            child: JobCard(job: jobs[index])
                .animate()
                .fadeIn(delay: Duration(milliseconds: 40 * index), duration: 350.ms)
                .slideY(begin: 0.05, end: 0),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_off_rounded, size: 64, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
          AppSpacing.gapMd,
          Text('No jobs found', style: AppTypography.titleMedium(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
          AppSpacing.gapSm,
          Text('Try adjusting your search or filters', style: AppTypography.bodyMedium(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4))),
        ],
      ),
    );
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const FilterSheet(),
    );
  }
}
