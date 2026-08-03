import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

final _notesSearchProvider = StateProvider<String>((ref) => '');
final _notesCategoryProvider = StateProvider<String>((ref) => 'All');

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  final _searchController = TextEditingController();
  final Set<String> _bookmarked = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Algorithms':
        return AppColors.accentBlue;
      case 'Flutter':
        return AppColors.accentCyan;
      case 'React':
        return AppColors.accentPink;
      case 'Machine Learning':
        return AppColors.primaryLight;
      case 'Data Structures':
        return AppColors.accentOrange;
      case 'API Design':
        return AppColors.secondaryLight;
      case 'System Design':
        return AppColors.tertiaryLight;
      case 'Python':
        return AppColors.accentYellow;
      case 'Database':
        return AppColors.accentLime;
      case 'DevOps':
        return AppColors.accentPink;
      case 'Git':
        return AppColors.accentOrange;
      default:
        return AppColors.primaryLight;
    }
  }

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
    final allNotes = ref.watch(notesProvider);
    final searchQuery = ref.watch(_notesSearchProvider);
    final selectedCategory = ref.watch(_notesCategoryProvider);

    final filteredNotes = allNotes.where((note) {
      final matchesSearch = searchQuery.isEmpty ||
          note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == 'All' || note.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Notes & Guides', style: AppTypography.titleLarge()),
      ),
      body: Column(
        children: [
          Container(
            color: colorScheme.surface,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.base, 0, AppSpacing.base, AppSpacing.base,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                ref.read(_notesSearchProvider.notifier).state = value;
              },
              style: AppTypography.bodyMedium(),
              decoration: InputDecoration(
                hintText: 'Search notes...',
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
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: const BorderSide(
                    color: AppColors.borderFocusLight,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSpacing.chipHeightLg + AppSpacing.sm,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              scrollDirection: Axis.horizontal,
              itemCount: const [
                'All',
                'Algorithms',
                'Flutter',
                'React',
                'Machine Learning',
                'Data Structures',
                'API Design',
                'System Design',
                'Python',
                'Database',
                'DevOps',
                'Git',
              ].length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final categories = [
                  'All',
                  'Algorithms',
                  'Flutter',
                  'React',
                  'Machine Learning',
                  'Data Structures',
                  'API Design',
                  'System Design',
                  'Python',
                  'Database',
                  'DevOps',
                  'Git',
                ];
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
                    ref.read(_notesCategoryProvider.notifier).state =
                        category;
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: filteredNotes.isEmpty
                ? Center(
                    child: Text(
                      'No notes found',
                      style: AppTypography.bodyMedium(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(AppSpacing.base),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      final isBookmarked =
                          _bookmarked.contains(note.id);
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: _categoryColor(note.category),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(AppSpacing.radiusMd),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  AppSpacing.md,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            note.title,
                                            maxLines: 2,
                                            overflow:
                                                TextOverflow.ellipsis,
                                            style:
                                                AppTypography.titleSmall(),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isBookmarked) {
                                                _bookmarked
                                                    .remove(note.id);
                                              } else {
                                                _bookmarked
                                                    .add(note.id);
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
                                    Expanded(
                                      child: Text(
                                        note.content.length > 80
                                            ? '${note.content.substring(0, 80)}...'
                                            : note.content,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.bodySmall(
                                          color: colorScheme
                                              .onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Wrap(
                                      spacing: AppSpacing.xs,
                                      runSpacing: AppSpacing.xs,
                                      children: [
                                        _buildChip(
                                          note.category,
                                          _categoryColor(note.category),
                                        ),
                                        _buildChip(
                                          _difficultyLabel(
                                            note.difficulty,
                                          ),
                                          _difficultyColor(
                                            note.difficulty,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.description_outlined,
                                          size: AppSpacing.iconXs,
                                          color: colorScheme
                                              .onSurfaceVariant,
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.xxs,
                                        ),
                                        Text(
                                          '${note.pageCount}p',
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
                                          '${note.readTimeMinutes}m',
                                          style:
                                              AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                        const Spacer(),
                                        Flexible(
                                          child: Text(
                                            note.author,
                                            maxLines: 1,
                                            overflow:
                                                TextOverflow.ellipsis,
                                            style:
                                                AppTypography.labelSmall(
                                              color: colorScheme
                                                  .onSurfaceVariant,
                                            ),
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
