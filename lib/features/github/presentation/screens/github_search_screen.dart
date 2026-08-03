import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/github_entities.dart';
import '../providers/github_providers.dart';

class GitHubSearchScreen extends ConsumerStatefulWidget {
  const GitHubSearchScreen({super.key});

  @override
  ConsumerState<GitHubSearchScreen> createState() => _GitHubSearchScreenState();
}

class _GitHubSearchScreenState extends ConsumerState<GitHubSearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final repos = ref.watch(trendingReposProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (v) => ref.read(githubSearchQueryProvider.notifier).state = v,
          decoration: InputDecoration(
            hintText: 'Search repos, languages, topics...',
            hintStyle: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.4)),
            border: InputBorder.none,
          ),
          style: AppTypography.bodyMedium(),
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _controller.clear();
                ref.read(githubSearchQueryProvider.notifier).state = '';
              },
              icon: Icon(Icons.clear_rounded, color: colorScheme.onSurface.withValues(alpha: 0.5)),
            ),
        ],
      ),
      body: repos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off_rounded, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                  AppSpacing.gapMd,
                  Text('No results found', style: AppTypography.titleMedium(color: colorScheme.onSurface.withValues(alpha: 0.5))),
                ],
              ),
            )
          : ListView.separated(
              padding: AppSpacing.paddingBase,
              itemCount: repos.length,
              separatorBuilder: (_, __) => AppSpacing.gapMd,
              itemBuilder: (context, index) => _searchResultCard(repos[index], context),
            ),
    );
  }

  Widget _searchResultCard(GithubRepository repo, BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/github/repo/${repo.id}'),
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1)),
          boxShadow: [BoxShadow(color: AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm),
              child: Center(child: Text(repo.ownerAvatar, style: AppTypography.titleMedium(color: AppColors.primaryLight))),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(repo.fullName, style: AppTypography.titleSmall(), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(repo.description, style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)), maxLines: 1, overflow: TextOverflow.ellipsis),
                  AppSpacing.gapXs,
                  Row(
                    children: [
                      Container(width: 8, height: 8, decoration: BoxDecoration(color: repo.languageColor, shape: BoxShape.circle)),
                      AppSpacing.hGapXs,
                      Text(repo.language, style: AppTypography.labelSmall(color: AppColors.textSecondaryLight)),
                      AppSpacing.hGapSm,
                      Icon(Icons.star_rounded, size: 14, color: AppColors.accentOrange),
                      AppSpacing.hGapXxs,
                      Text(repo.starsFormatted, style: AppTypography.labelSmall(color: AppColors.accentOrange)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
