import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/github_entities.dart';
import '../providers/github_providers.dart';

class TrendingReposScreen extends ConsumerWidget {
  const TrendingReposScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final repos = ref.watch(trendingReposProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.base, AppSpacing.base, 0),
              child: Row(
                children: [
                  Expanded(child: Text('Trending Repos', style: AppTypography.headlineMedium())),
                  IconButton(
                    onPressed: () => context.push('/github/search'),
                    icon: Icon(Icons.search_rounded, color: colorScheme.onSurface),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.sm, AppSpacing.base, 0),
              child: TextField(
                onChanged: (v) => ref.read(githubSearchQueryProvider.notifier).state = v,
                decoration: InputDecoration(
                  hintText: 'Search repositories...',
                  prefixIcon: Icon(Icons.search_rounded, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd, borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.md),
                ),
                style: AppTypography.bodyMedium(),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: AppSpacing.paddingBase,
                itemCount: repos.length,
                separatorBuilder: (_, __) => AppSpacing.gapMd,
                itemBuilder: (context, index) => _RepoCard(repo: repos[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RepoCard extends ConsumerWidget {
  const _RepoCard({required this.repo});
  final GithubRepository repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final starred = ref.watch(starredReposProvider);

    return GestureDetector(
      onTap: () => context.push('/github/repo/${repo.id}'),
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
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm),
                  child: Center(child: Text(repo.ownerAvatar, style: AppTypography.titleMedium(color: AppColors.primaryLight))),
                ),
                AppSpacing.hGapSm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(repo.fullName, style: AppTypography.titleSmall(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(repo.owner, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => ref.read(starredReposProvider.notifier).toggle(repo.id),
                  child: Icon(
                    starred.contains(repo.id) ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: starred.contains(repo.id) ? AppColors.accentOrange : colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
            AppSpacing.gapSm,
            Text(repo.description, style: AppTypography.bodySmall(color: colorScheme.onSurface.withValues(alpha: 0.7)), maxLines: 2, overflow: TextOverflow.ellipsis),
            AppSpacing.gapSm,
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                _tagStr(repo.language, repo.languageColor),
                _tagStr(repo.starsFormatted, null, icon: Icons.star_rounded, iconColor: AppColors.accentOrange),
                _tagStr(repo.forksFormatted, null, icon: Icons.fork_right_rounded),
                _tagStr('${repo.openIssues} issues', null, dotColor: AppColors.successLight),
              ],
            ),
            if (repo.topics.isNotEmpty) ...[
              AppSpacing.gapSm,
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: repo.topics.take(4).map((t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.08),
                    borderRadius: AppSpacing.borderRadiusFull,
                  ),
                  child: Text(t, style: AppTypography.labelSmall(color: AppColors.primaryLight)),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _tagStr(String label, Color? color, {IconData? icon, Color? iconColor, Color? dotColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1) ?? AppColors.surfaceVariantLight.withValues(alpha: 0.5),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 12, color: iconColor ?? color),
          if (icon == null && dotColor != null)
            Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          if (icon == null && dotColor == null && color != null)
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          AppSpacing.hGapXxs,
          Text(label, style: AppTypography.labelSmall(color: color)),
        ],
      ),
    );
  }
}
