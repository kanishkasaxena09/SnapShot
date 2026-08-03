import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/ai_tools_entities.dart';
import '../providers/ai_tools_providers.dart';
import '../widgets/tool_card.dart';

class BookmarkedToolsScreen extends ConsumerWidget {
  const BookmarkedToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarkedToolsProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Bookmarked Tools',
          style: AppTypography.titleLarge(color: AppColors.textPrimaryLight),
        ),
        centerTitle: true,
      ),
      body: bookmarkedIds.isEmpty
          ? _buildEmptyState(context)
          : _buildBookmarkedList(context, ref, bookmarkedIds),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_border,
                size: 64,
                color: AppColors.primaryLight,
              ),
            ),
            AppSpacing.gapXl,
            Text(
              'No bookmarks yet',
              style: AppTypography.headlineSmall(color: AppColors.textPrimaryLight),
            ),
            AppSpacing.gapSm,
            Text(
              'Save your favorite AI tools here for quick access later.',
              style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapXl,
            SizedBox(
              height: AppSpacing.buttonHeightLg,
              child: ElevatedButton(
                onPressed: () => context.push('/ai-tools'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                ),
                child: Text(
                  'Browse Tools',
                  style: AppTypography.labelLarge(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkedList(
    BuildContext context,
    WidgetRef ref,
    List<String> bookmarkedIds,
  ) {
    final tools = bookmarkedIds
        .map((id) => ref.read(aiToolDetailProvider(id)))
        .whereType<AiTool>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.base,
            AppSpacing.base,
            AppSpacing.base,
            AppSpacing.sm,
          ),
          child: Text(
            '${tools.length} bookmarked tool${tools.length == 1 ? '' : 's'}',
            style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.sm,
            ),
            itemCount: tools.length,
            separatorBuilder: (_, __) => AppSpacing.gapMd,
            itemBuilder: (context, index) {
              final tool = tools[index];
              return Stack(
                children: [
                  ToolCard(
                    tool: tool,
                    isBookmarked: true,
                    onTap: () => context.push('/ai-tools/${tool.id}'),
                  ),
                  Positioned(
                    top: AppSpacing.sm + 2,
                    right: AppSpacing.sm,
                    child: GestureDetector(
                      onTap: () {
                        ref.read(bookmarkedToolsProvider.notifier).toggle(tool.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: AppColors.errorLight,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
