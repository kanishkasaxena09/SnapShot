import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/detail_not_found_screen.dart';
import '../../domain/entities/github_entities.dart';
import '../providers/github_providers.dart';

class RepositoryDetailScreen extends ConsumerWidget {
  const RepositoryDetailScreen({super.key, required this.repoId});
  final String repoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final repo = ref.watch(repoDetailProvider(repoId));

    if (repo == null) return const DetailNotFoundScreen(title: 'Repository');

    final starred = ref.watch(starredReposProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
            actions: [
              IconButton(
                onPressed: () => ref.read(starredReposProvider.notifier).toggle(repo.id),
                icon: Icon(starred.contains(repo.id) ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: starred.contains(repo.id) ? AppColors.accentOrange : null),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded)),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(repo.name, style: AppTypography.titleMedium(color: colorScheme.onSurface)),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16, right: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.paddingBase,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, repo),
                  AppSpacing.gapLg,
                  Text(repo.description, style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.7))),
                  AppSpacing.gapLg,
                  _buildTopics(context, repo),
                  AppSpacing.gapLg,
                  _buildStatsRow(context, repo),
                  AppSpacing.gapLg,
                  _buildCommitActivity(context, repo),
                  AppSpacing.gapLg,
                  _buildLanguageChart(context, repo),
                  AppSpacing.gapLg,
                  _buildGoodFirstIssues(context, repo),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GithubRepository repo) {
    return Row(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm),
          child: Center(child: Text(repo.ownerAvatar, style: AppTypography.titleMedium(color: AppColors.primaryLight))),
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.fullName, style: AppTypography.titleMedium()),
              Text('${repo.owner} • ${repo.license}', style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildTopics(BuildContext context, GithubRepository repo) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: repo.languageColor.withValues(alpha: 0.15), borderRadius: AppSpacing.borderRadiusFull),
          child: Text(repo.language, style: AppTypography.labelMedium(color: repo.languageColor)),
        ),
        ...repo.topics.map((t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.08), borderRadius: AppSpacing.borderRadiusFull),
          child: Text(t, style: AppTypography.labelSmall(color: AppColors.primaryLight)),
        )),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, GithubRepository repo) {
    return Row(
      children: [
        _statCard(Icons.star_rounded, 'Stars', repo.starsFormatted, AppColors.accentOrange),
        _statCard(Icons.fork_right_rounded, 'Forks', repo.forksFormatted, AppColors.accentBlue),
        _statCard(Icons.remove_red_eye_rounded, 'Watchers', repo.watchers.toString(), AppColors.secondaryLight),
        _statCard(Icons.error_outline_rounded, 'Issues', repo.openIssues.toString(), AppColors.errorLight),
      ],
    ).animate().fadeIn(delay: 100.ms, duration: 300.ms);
  }

  Widget _statCard(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: AppSpacing.borderRadiusMd),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            AppSpacing.gapXs,
            Text(value, style: AppTypography.titleSmall(color: color)),
            Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryLight)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitActivity(BuildContext context, GithubRepository repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Commit Activity', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        Container(
          height: 120,
          padding: AppSpacing.paddingBase,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: CustomPaint(
            size: const Size(double.infinity, 90),
            painter: _CommitChartPainter(repo.commitActivity),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 300.ms);
  }

  Widget _buildLanguageChart(BuildContext context, GithubRepository repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Languages', style: AppTypography.titleMedium()),
        AppSpacing.gapSm,
        ClipRRect(
          borderRadius: AppSpacing.borderRadiusFull,
          child: SizedBox(
            height: 12,
            child: Row(
              children: repo.languageDistribution.languages.map((l) =>
                Expanded(flex: (l.percent * 100).toInt(), child: Container(color: l.color))
              ).toList(),
            ),
          ),
        ),
        AppSpacing.gapSm,
        ...repo.languageDistribution.languages.map((l) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: l.color, borderRadius: AppSpacing.borderRadiusXs)),
              AppSpacing.hGapSm,
              Text(l.name, style: AppTypography.bodySmall()),
              const Spacer(),
              Text('${l.percent.toStringAsFixed(1)}%', style: AppTypography.labelSmall(color: AppColors.textSecondaryLight)),
            ],
          ),
        )),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 300.ms);
  }

  Widget _buildGoodFirstIssues(BuildContext context, GithubRepository repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(child: Text('Good First Issues', style: AppTypography.titleMedium())),
            AppSpacing.hGapSm,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppColors.successLight.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusFull),
              child: Text('${repo.goodFirstIssues.length}', style: AppTypography.labelSmall(color: AppColors.successLight)),
            ),
          ],
        ),
        AppSpacing.gapSm,
        ...repo.goodFirstIssues.map((issue) => Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: AppSpacing.paddingMd,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.label_important_outline_rounded, size: 16, color: AppColors.successLight),
                  AppSpacing.hGapXs,
                  Text(issue.number, style: AppTypography.labelSmall(color: AppColors.successLight)),
                ],
              ),
              AppSpacing.gapXs,
              Text(issue.title, style: AppTypography.bodyMedium(), maxLines: 2, overflow: TextOverflow.ellipsis),
              AppSpacing.gapXs,
              Row(
                children: [
                  ...issue.labels.map((l) => Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.accentBlue.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusFull),
                    child: Text(l, style: AppTypography.labelSmall(color: AppColors.accentBlue)),
                  )),
                  const Spacer(),
                  Icon(Icons.chat_bubble_outline_rounded, size: 12, color: AppColors.textSecondaryLight),
                  AppSpacing.hGapXxs,
                  Text('${issue.comments}', style: AppTypography.bodySmall(color: AppColors.textSecondaryLight)),
                ],
              ),
            ],
          ),
        )),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 300.ms);
  }
}

class _CommitChartPainter extends CustomPainter {
  _CommitChartPainter(this.activity);
  final List<CommitActivity> activity;

  @override
  void paint(Canvas canvas, Size size) {
    if (activity.isEmpty) return;
    final maxVal = activity.map((a) => a.total).reduce((a, b) => a > b ? a : b).toDouble();
    final barWidth = size.width / (activity.length * 1.5);

    for (var i = 0; i < activity.length; i++) {
      final barHeight = (activity[i].total / maxVal) * size.height;
      final x = (i * 1.5 + 0.25) * barWidth;
      final y = size.height - barHeight;

      final paint = Paint()..color = AppColors.primaryLight.withValues(alpha: 0.7 + (i / activity.length) * 0.3);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, y, barWidth, barHeight), const Radius.circular(3)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
