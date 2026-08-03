import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

final _cheatSheetCategoryProvider = StateProvider<String>((ref) => 'All');

class CheatSheetsScreen extends ConsumerStatefulWidget {
  const CheatSheetsScreen({super.key});

  @override
  ConsumerState<CheatSheetsScreen> createState() => _CheatSheetsScreenState();
}

class _CheatSheetsScreenState extends ConsumerState<CheatSheetsScreen> {
  final Set<String> _bookmarked = {};

  Color _difficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return AppColors.successLight;
      case DifficultyLevel.intermediate:
        return AppColors.warningLight;
      case DifficultyLevel.advanced:
        return AppColors.errorLight;
    }
  }

  String _difficultyLabel(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return 'Beginner';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final allCheatSheets = ref.watch(cheatSheetsProvider);
    final selectedCategory = ref.watch(_cheatSheetCategoryProvider);

    final filtered = allCheatSheets.where((sheet) {
      return selectedCategory == 'All' || sheet.category == selectedCategory;
    }).toList();

    const categories = [
      'All',
      'Flutter',
      'Python',
      'JavaScript',
      'React',
      'Docker',
      'Kubernetes',
      'Git',
      'SQL',
      'Bash',
      'Data Structures',
      'API Design',
      'Linux',
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Cheat Sheets', style: AppTypography.titleLarge()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: colorScheme.surface,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base, AppSpacing.sm, AppSpacing.base, AppSpacing.base,
            ),
            child: Text(
              'Quick reference guides for instant lookup',
              style: AppTypography.bodyMedium(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            height: AppSpacing.chipHeightLg + AppSpacing.sm,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.xs,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  labelStyle: AppTypography.labelMedium(
                    color: isSelected
                        ? AppColors.textInverseLight
                        : colorScheme.onSurfaceVariant,
                  ),
                  selected: isSelected,
                  selectedColor: colorScheme.primary,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  onSelected: (_) {
                    ref.read(_cheatSheetCategoryProvider.notifier).state =
                        category;
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No cheat sheets found',
                      style: AppTypography.bodyMedium(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.xs,
                    ),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final sheet = filtered[index];
                      final isBookmarked =
                          _bookmarked.contains(sheet.id);
                      return Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 100,
                              decoration: BoxDecoration(
                                color: sheet.color,
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(AppSpacing.radiusMd),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  AppSpacing.base,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            sheet.title,
                                            style:
                                                AppTypography.titleSmall(),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isBookmarked) {
                                                _bookmarked
                                                    .remove(sheet.id);
                                              } else {
                                                _bookmarked
                                                    .add(sheet.id);
                                              }
                                            });
                                          },
                                          child: Icon(
                                            isBookmarked
                                                ? Icons.bookmark
                                                : Icons
                                                    .bookmark_border_rounded,
                                            size: AppSpacing.iconMd,
                                            color: isBookmarked
                                                ? colorScheme.primary
                                                : colorScheme
                                                    .onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Wrap(
                                      spacing: AppSpacing.xs,
                                      runSpacing: AppSpacing.xs,
                                      children: [
                                        _buildChip(
                                          sheet.category,
                                          sheet.color,
                                        ),
                                        _buildChip(
                                          _difficultyLabel(
                                            sheet.difficulty,
                                          ),
                                          _difficultyColor(
                                            sheet.difficulty,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.format_list_bulleted_rounded,
                                          size: AppSpacing.iconXs,
                                          color: colorScheme
                                              .onSurfaceVariant,
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.xxs,
                                        ),
                                        Text(
                                          '${sheet.itemCount} items',
                                          style:
                                              AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.sm,
                                        ),
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: AppSpacing.iconXs,
                                          color: colorScheme
                                              .onSurfaceVariant,
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.xxs,
                                        ),
                                        Text(
                                          '${sheet.readTimeMinutes}m read',
                                          style:
                                              AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          'Updated ${sheet.lastUpdated}',
                                          style:
                                              AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall(color: color),
      ),
    );
  }
}
