import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

final _videoCategoryFilterProvider = StateProvider<String>((ref) => 'All');

class VideosScreen extends ConsumerStatefulWidget {
  const VideosScreen({super.key});

  @override
  ConsumerState<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends ConsumerState<VideosScreen> {
  String _searchQuery = '';

  static const _categories = [
    'All',
    'Flutter',
    'AI/ML',
    'React',
    'System Design',
    'DevOps',
    'Databases',
  ];

  Color _difficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.successLight;
      case DifficultyLevel.intermediate:
        return AppColors.warningLight;
      case DifficultyLevel.advanced:
        return Theme.of(context).colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final allVideos = ref.watch(videosProvider);
    final category = ref.watch(_videoCategoryFilterProvider);

    final filteredVideos = allVideos.where((video) {
      final matchesSearch = _searchQuery.isEmpty ||
          video.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          video.channel
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          category == 'All' || video.category == category;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Videos', style: AppTypography.headlineLarge()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base,
              AppSpacing.sm,
              AppSpacing.base,
              0,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Search videos...',
                hintStyle: AppTypography.bodyMedium(
                  color: colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: AppSpacing.chipHeightLg,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
              ),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => AppSpacing.hGapSm,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = category == cat;
                return FilterChip(
                  label: Text(
                    cat,
                    style: AppTypography.labelMedium(
                      color: isSelected
                          ? AppColors.textInverseLight
                          : colorScheme.onSurface,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: colorScheme.primary,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  checkmarkColor: AppColors.textInverseLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusFull,
                    side: BorderSide(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outlineVariant,
                    ),
                  ),
                  onSelected: (_) {
                    ref.read(_videoCategoryFilterProvider.notifier).state =
                        cat;
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: filteredVideos.isEmpty
                ? Center(
                    child: Text(
                      'No videos found',
                      style: AppTypography.bodyMedium(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.sm,
                    ),
                    itemCount: filteredVideos.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final video = filteredVideos[index];
                      final thumbnailColor = Color(
                        int.parse(
                          video.thumbnailColor.replaceFirst('#', '0xFF'),
                        ),
                      );

                      return Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: AppSpacing.borderRadiusMd,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 160,
                                  width: double.infinity,
                                  color: thumbnailColor,
                                  child: Center(
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: AppColors.textInverseLight,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: AppSpacing.sm,
                                  right: AppSpacing.sm,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.sm,
                                      vertical: AppSpacing.xxs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius:
                                          AppSpacing.borderRadiusXs,
                                    ),
                                    child: Text(
                                      '${video.durationMinutes} min',
                                      style: AppTypography.labelSmall(
                                        color: AppColors.textInverseLight,
                                      ),
                                    ),
                                  ),
                                ),
                                if (video.isWatched)
                                  Positioned(
                                    top: AppSpacing.sm,
                                    left: AppSpacing.sm,
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        AppSpacing.xs,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: AppColors.successLight,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color: AppColors.textInverseLight,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: AppSpacing.cardPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          video.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTypography.titleMedium(
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          video.isSaved
                                              ? Icons.bookmark_rounded
                                              : Icons.bookmark_outline_rounded,
                                          color: video.isSaved
                                              ? colorScheme.primary
                                              : colorScheme.onSurfaceVariant,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints:
                                            const BoxConstraints(),
                                        splashRadius: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    video.channel,
                                    style: AppTypography.bodySmall(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility_outlined,
                                        size: AppSpacing.iconSm,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: AppSpacing.xs),
                                      Text(
                                        '${video.viewCount}',
                                        style: AppTypography.labelSmall(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: AppSpacing.md,
                                      ),
                                      const Icon(
                                        Icons.star_rounded,
                                        size: AppSpacing.iconSm,
                                        color: AppColors.accentYellow,
                                      ),
                                      const SizedBox(width: AppSpacing.xs),
                                      Text(
                                        video.rating.toStringAsFixed(1),
                                        style: AppTypography.labelSmall(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: AppSpacing.md,
                                      ),
                                      Text(
                                        video.publishedAt,
                                        style: AppTypography.labelSmall(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.sm,
                                      vertical: AppSpacing.xxs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _difficultyColor(
                                        video.difficulty,
                                      ).withOpacity(0.1),
                                      borderRadius:
                                          AppSpacing.borderRadiusFull,
                                    ),
                                    child: Text(
                                      video.difficulty.name.toUpperCase(),
                                      style: AppTypography.labelSmall(
                                        color: _difficultyColor(
                                          video.difficulty,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
