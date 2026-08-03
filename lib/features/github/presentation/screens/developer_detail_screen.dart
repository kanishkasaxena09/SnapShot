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

class DeveloperDetailScreen extends ConsumerWidget {
  const DeveloperDetailScreen({super.key, required this.devId});
  final String devId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final dev = ref.watch(developerDetailProvider(devId));

    if (dev == null) return const DetailNotFoundScreen(title: 'Developer');

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('@${dev.username}', style: AppTypography.titleMedium(color: Colors.white)),
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: Text(dev.avatar, style: AppTypography.displaySmall(color: Colors.white)),
                      ),
                      AppSpacing.gapSm,
                      Text(dev.displayName, style: AppTypography.titleMedium(color: Colors.white)),
                    ],
                  ),
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
                  if (dev.bio != null) Text(dev.bio!, style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.7))),
                  AppSpacing.gapLg,
                  _buildInfoRow(dev),
                  AppSpacing.gapLg,
                  _buildStats(context, dev),
                  AppSpacing.gapLg,
                  _buildContributionGraph(context, dev),
                  AppSpacing.gapLg,
                  Text('Popular Repositories', style: AppTypography.titleMedium()),
                  AppSpacing.gapSm,
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.xs),
                child: _miniRepoCard(dev.popularRepos[index], context),
              ),
              childCount: dev.popularRepos.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(GithubDeveloper dev) {
    final items = <MapEntry<IconData, String>>[];
    if (dev.company != null) items.add(MapEntry(Icons.business_rounded, dev.company!));
    if (dev.location != null) items.add(MapEntry(Icons.location_on_outlined, dev.location!));
    if (dev.website != null) items.add(MapEntry(Icons.link_rounded, dev.website!));

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: items.map((e) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(e.key, size: 16, color: AppColors.textSecondaryLight),
          AppSpacing.hGapXs,
          Text(e.value, style: AppTypography.bodySmall(color: AppColors.textSecondaryLight)),
        ],
      )).toList(),
    );
  }

  Widget _buildStats(BuildContext context, GithubDeveloper dev) {
    return Row(
      children: [
        _stat(Icons.people_rounded, 'Followers', _fmt(dev.followers), AppColors.primaryLight),
        _stat(Icons.person_add_rounded, 'Following', _fmt(dev.following), AppColors.accentBlue),
        _stat(Icons.code_rounded, 'Repos', dev.publicRepos.toString(), AppColors.secondaryLight),
        _stat(Icons.commit_rounded, 'Contributions', _fmt(dev.contributions), AppColors.accentOrange),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _stat(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: AppSpacing.borderRadiusMd),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            AppSpacing.gapXs,
            Text(value, style: AppTypography.titleSmall(color: color)),
            Text(label, style: AppTypography.labelSmall(color: AppColors.textSecondaryLight)),
          ],
        ),
      ),
    );
  }

  Widget _buildContributionGraph(BuildContext context, GithubDeveloper dev) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(child: Text('Contribution Graph', style: AppTypography.titleMedium())),
            AppSpacing.hGapSm,
            Flexible(child: Text('${_fmt(dev.contributions)} contributions in the last year',
                style: AppTypography.bodySmall(color: AppColors.textSecondaryLight), overflow: TextOverflow.ellipsis)),
          ],
        ),
        AppSpacing.gapSm,
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          child: _ContributionGraphWidget(contributions: dev.contributionGraph),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 300.ms);
  }

  Widget _miniRepoCard(GithubRepository repo, BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/github/repo/${repo.id}'),
      child: Container(
        padding: AppSpacing.paddingMd,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Icon(Icons.book_outlined, color: AppColors.primaryLight, size: 20),
            AppSpacing.hGapSm,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(repo.name, style: AppTypography.titleSmall()),
                  Text(repo.description, style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, size: 14, color: AppColors.accentOrange),
                AppSpacing.hGapXxs,
                Text(repo.starsFormatted, style: AppTypography.labelSmall(color: AppColors.accentOrange)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }

  ColorScheme get colorScheme => const ColorScheme.light();
}

class _ContributionGraphWidget extends StatelessWidget {
  const _ContributionGraphWidget({required this.contributions});
  final List<ContributionDay> contributions;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 112),
      painter: _ContributionPainter(contributions),
    );
  }
}

class _ContributionPainter extends CustomPainter {
  _ContributionPainter(this.contributions);
  final List<ContributionDay> contributions;

  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 10.0;
    const gap = 2.0;
    const weeks = 52;
    final maxCount = contributions.map((c) => c.count).reduce((a, b) => a > b ? a : b);

    for (var i = 0; i < contributions.length && i < weeks * 7; i++) {
      final week = i ~/ 7;
      final day = i % 7;
      final x = week * (cellSize + gap);
      final y = day * (cellSize + gap);

      final intensity = contributions[i].count / (maxCount > 0 ? maxCount : 1);
      final color = _getColor(intensity);

      final paint = Paint()..color = color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, y, cellSize, cellSize), const Radius.circular(2)),
        paint,
      );
    }
  }

  Color _getColor(double intensity) {
    if (intensity == 0) return const Color(0xFF161B22);
    if (intensity < 0.25) return const Color(0xFF0E4429);
    if (intensity < 0.5) return const Color(0xFF006D32);
    if (intensity < 0.75) return const Color(0xFF26A641);
    return const Color(0xFF39D353);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
