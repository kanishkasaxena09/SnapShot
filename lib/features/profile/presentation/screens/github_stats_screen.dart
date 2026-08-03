import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class GitHubStatsScreen extends ConsumerWidget {
  const GitHubStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(gitHubStatsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('GitHub Stats', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Grid
            Row(
              children: [
                _GitHubStatCard(value: '${stats.totalRepos}', label: 'Repos', icon: Icons.folder_outlined, color: AppColors.primaryLight),
                _GitHubStatCard(value: '${stats.totalStars}', label: 'Stars', icon: Icons.star_outline, color: AppColors.accentYellow),
                _GitHubStatCard(value: '${stats.totalCommits}', label: 'Commits', icon: Icons.commit, color: AppColors.accentCyan),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _GitHubStatCard(value: '${stats.totalPRs}', label: 'PRs', icon: Icons.merge_type, color: Colors.green),
                _GitHubStatCard(value: '${stats.totalIssues}', label: 'Issues', icon: Icons.circle_outlined, color: AppColors.accentOrange),
                _GitHubStatCard(value: '${stats.contributionStreak}d', label: 'Streak', icon: Icons.local_fire_department, color: AppColors.accentPink),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Language Breakdown
            Text('Top Languages', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusLg,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: stats.topLanguages.map((lang) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(color: lang.color, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: Text(lang.name, style: AppTypography.labelMedium(color: colorScheme.onSurface))),
                      Text('${lang.percentage.round()}%', style: AppTypography.labelMedium(color: colorScheme.onSurfaceVariant)),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: AppSpacing.borderRadiusXs,
                          child: LinearProgressIndicator(
                            value: lang.percentage / 100,
                            minHeight: 6,
                            backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                            valueColor: AlwaysStoppedAnimation(lang.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Recent Activity
            Text('Recent Activity', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            ...stats.recentActivity.map((activity) => Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.xs),
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: AppColors.accentCyan),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(activity, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _GitHubStatCard extends StatelessWidget {
  const _GitHubStatCard({required this.value, required this.label, required this.icon, required this.color});
  final String value, label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(value, style: AppTypography.titleMedium(color: color)),
            Text(label, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
