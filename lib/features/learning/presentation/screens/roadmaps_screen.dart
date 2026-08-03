import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

class RoadmapsScreen extends ConsumerWidget {
  const RoadmapsScreen({super.key});

  Color _difficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.successLight;
      case DifficultyLevel.intermediate:
        return AppColors.accentOrange;
      case DifficultyLevel.advanced:
        return AppColors.errorLight;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roadmaps = ref.watch(roadmapsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Learning Roadmaps',
            style: AppTypography.headlineMedium(
                color: colorScheme.onSurface)),
      ),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Follow structured paths to master new skills',
              style: AppTypography.bodyMedium(
                  color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: ListView.separated(
                itemCount: roadmaps.length,
                separatorBuilder: (_, __) =>
                    AppSpacing.gapMd,
                itemBuilder: (context, index) {
                  final roadmap = roadmaps[index];
                  return GestureDetector(
                    onTap: roadmap.isLocked
                        ? null
                        : () => context.push(
                            '/learning/roadmap/${roadmap.id}'),
                    child: Stack(
                      children: [
                        Container(
                          padding: AppSpacing.cardPadding,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius:
                                AppSpacing.borderRadiusMd,
                            boxShadow: const [
                              BoxShadow(
                                color:
                                    AppColors.shadowLight,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: roadmap.color
                                      .withOpacity(0.1),
                                  borderRadius: AppSpacing
                                      .borderRadiusMd,
                                ),
                                child: Icon(
                                    roadmap.icon,
                                    color:
                                        roadmap.color,
                                    size: 26),
                              ),
                              AppSpacing.hGapMd,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(roadmap.title,
                                        style: AppTypography.titleMedium(
                                            color: colorScheme
                                                .onSurface)),
                                    const SizedBox(
                                        height:
                                            AppSpacing.xs),
                                    Text(
                                        roadmap
                                            .description,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow
                                                .ellipsis,
                                        style: AppTypography.bodySmall(
                                            color: colorScheme
                                                .onSurfaceVariant)),
                                    const SizedBox(
                                        height:
                                            AppSpacing.sm),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                                  AppSpacing
                                                      .sm,
                                              vertical:
                                                  AppSpacing
                                                      .xxs),
                                          decoration:
                                              BoxDecoration(
                                            color: _difficultyColor(
                                                    roadmap
                                                        .difficulty)
                                                .withOpacity(
                                                    0.1),
                                            borderRadius:
                                                AppSpacing
                                                    .borderRadiusFull,
                                          ),
                                          child: Text(
                                            roadmap
                                                .difficulty
                                                .name
                                                .toUpperCase(),
                                            style: AppTypography.labelSmall(
                                                color: _difficultyColor(
                                                    roadmap
                                                        .difficulty)),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                AppSpacing
                                                    .sm),
                                        Icon(
                                            Icons
                                                .schedule_outlined,
                                            size: 14,
                                            color: colorScheme
                                                .onSurfaceVariant),
                                        Text(
                                            ' ${roadmap.estimatedTime}',
                                            style: AppTypography.labelSmall(
                                                color: colorScheme
                                                    .onSurfaceVariant)),
                                      ],
                                    ),
                                    const SizedBox(
                                        height:
                                            AppSpacing.sm),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    AppSpacing
                                                        .radiusFull),
                                            child:
                                                LinearProgressIndicator(
                                              value: roadmap
                                                  .progress,
                                              backgroundColor:
                                                  colorScheme
                                                      .primaryContainer,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      colorScheme
                                                          .primary),
                                              minHeight: 6,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                AppSpacing
                                                    .sm),
                                        Text(
                                            '${roadmap.completedSteps}/${roadmap.totalSteps} steps',
                                            style: AppTypography.labelSmall(
                                                color: colorScheme
                                                    .onSurfaceVariant)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (roadmap.isLocked)
                          Positioned.fill(
                            child: Container(
                              padding:
                                  AppSpacing.cardPadding,
                              decoration: BoxDecoration(
                                color: colorScheme
                                    .surface
                                    .withValues(alpha: 0.7),
                                borderRadius:
                                    AppSpacing
                                        .borderRadiusMd,
                              ),
                              child: Align(
                                alignment:
                                    Alignment.topRight,
                                child: Icon(
                                    Icons.lock_outline,
                                    color: colorScheme
                                        .onSurfaceVariant,
                                    size: 20),
                              ),
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
      ),
    );
  }
}
