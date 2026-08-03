import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/job_providers.dart';
import '../widgets/job_card.dart';

class SavedJobsScreen extends ConsumerWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final savedIds = ref.watch(savedJobsProvider);
    final allJobs = ref.watch(allJobsProvider);
    final savedJobs = allJobs.where((j) => savedIds.contains(j.id)).toList();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Saved Jobs', style: AppTypography.titleLarge()),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: savedJobs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border_rounded, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                  AppSpacing.gapMd,
                  Text('No saved jobs yet', style: AppTypography.titleMedium(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                  AppSpacing.gapSm,
                  Text('Bookmark jobs you like to save them here', style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.4))),
                ],
              ),
            )
          : ListView.separated(
              padding: AppSpacing.paddingBase,
              itemCount: savedJobs.length,
              separatorBuilder: (_, __) => AppSpacing.gapMd,
              itemBuilder: (context, index) => JobCard(job: savedJobs[index])
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 40 * index), duration: 350.ms),
            ),
    );
  }
}
