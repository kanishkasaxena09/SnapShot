import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/github_entities.dart';
import '../providers/github_providers.dart';

class TrendingDevelopersScreen extends ConsumerWidget {
  const TrendingDevelopersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final developers = ref.watch(trendingDevelopersProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.base, AppSpacing.base, 0),
              child: Text('Trending Developers', style: AppTypography.headlineMedium()),
            ),
            Expanded(
              child: ListView.separated(
                padding: AppSpacing.paddingBase,
                itemCount: developers.length,
                separatorBuilder: (_, __) => AppSpacing.gapMd,
                itemBuilder: (context, index) => _DeveloperCard(dev: developers[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeveloperCard extends StatelessWidget {
  const _DeveloperCard({required this.dev});
  final GithubDeveloper dev;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push('/github/dev/${dev.id}'),
      child: Container(
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
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryLight.withValues(alpha: 0.1),
                  child: Text(dev.avatar, style: AppTypography.titleMedium(color: AppColors.primaryLight)),
                ),
                AppSpacing.hGapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(child: Text(dev.displayName, style: AppTypography.titleSmall(), overflow: TextOverflow.ellipsis)),
                          if (dev.isSponsored) ...[
                            AppSpacing.hGapXs,
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.accentOrange.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusFull),
                              child: Text('Sponsored', style: AppTypography.labelSmall(color: AppColors.accentOrange)),
                            ),
                          ],
                        ],
                      ),
                      Text('@${dev.username}', style: AppTypography.bodySmall(color: AppColors.primaryLight)),
                    ],
                  ),
                ),
              ],
            ),
            if (dev.bio != null) ...[
              AppSpacing.gapSm,
              Text(dev.bio!, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.7)), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
            AppSpacing.gapSm,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                _miniStat(Icons.people_rounded, '${_fmt(dev.followers)} followers'),
                _miniStat(Icons.code_rounded, '${dev.publicRepos} repos'),
                _miniStat(Icons.commit_rounded, '${_fmt(dev.contributions)} contributions'),
              ],
            ),
            AppSpacing.gapSm,
            Wrap(
              spacing: AppSpacing.xs,
              children: dev.topLanguages.map((l) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withValues(alpha: 0.1),
                  borderRadius: AppSpacing.borderRadiusFull,
                ),
                child: Text(l, style: AppTypography.labelSmall(color: AppColors.accentBlue)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondaryLight),
        AppSpacing.hGapXxs,
        Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryLight)),
      ],
    );
  }

  String _fmt(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}
