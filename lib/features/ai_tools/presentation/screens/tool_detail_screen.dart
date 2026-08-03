import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/ai_tools_entities.dart';
import '../providers/ai_tools_providers.dart';

class ToolDetailScreen extends ConsumerWidget {

  const ToolDetailScreen({super.key, required this.toolId});
  final String toolId;

  Widget _buildStarRow(double rating, {double size = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: size, color: AppColors.accentYellow);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: size, color: AppColors.accentYellow);
        }
        return Icon(Icons.star_border, size: size, color: AppColors.accentYellow);
      }),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tool = ref.watch(aiToolDetailProvider(toolId));
    final reviews = ref.watch(aiToolReviewsProvider(toolId));
    final isBookmarked = ref.watch(bookmarkedToolsProvider).contains(toolId);

    if (tool == null) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldLight,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceLight,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => context.pop(),
          ),
          title: Text('Tool Not Found', style: AppTypography.titleLarge(color: AppColors.textPrimaryLight)),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Tool not found', style: AppTypography.bodyLarge(color: AppColors.textSecondaryLight)),
        ),
      );
    }

    final alternatives = tool.alternatives
        .map((id) => ref.read(aiToolDetailProvider(id)))
        .whereType<AiTool>()
        .toList();

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(tool.name, style: AppTypography.titleLarge(color: AppColors.textPrimaryLight)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              size: 22,
              color: isBookmarked ? AppColors.primaryLight : AppColors.textSecondaryLight,
            ),
            onPressed: () => ref.read(bookmarkedToolsProvider.notifier).toggle(toolId),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22, color: AppColors.textSecondaryLight),
            onPressed: () => Share.share('${tool.name} - ${tool.website}'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    tag: 'tool_icon_${tool.id}',
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: tool.color.withOpacity(0.15),
                      child: Icon(tool.icon, color: tool.color, size: AppSpacing.iconXxl),
                    ),
                  ),
                  AppSpacing.gapMd,
                  Text(tool.name, style: AppTypography.headlineMedium(color: AppColors.textPrimaryLight)),
                  AppSpacing.gapXs,
                  Text(tool.tagline, style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight), textAlign: TextAlign.center),
                  AppSpacing.gapSm,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(tool.company, style: AppTypography.labelLarge(color: AppColors.textSecondaryLight)),
                      if (tool.isVerified) ...[
                        AppSpacing.hGapXs,
                        const Icon(Icons.verified, size: 16, color: AppColors.accentBlue),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatColumn(
                      child: _buildStarRow(tool.rating, size: 16),
                      label: tool.rating.toStringAsFixed(1),
                    ),
                  ),
                  Expanded(
                    child: _buildStatColumn(
                      child: const Icon(Icons.reviews_outlined, size: 18, color: AppColors.accentBlue),
                      label: '${_formatCount(tool.reviewCount)} reviews',
                    ),
                  ),
                  Expanded(
                    child: _buildStatColumn(
                      child: const Icon(Icons.people_outline, size: 18, color: AppColors.secondaryLight),
                      label: '${_formatCount(tool.usageCount)} users',
                    ),
                  ),
                  Expanded(
                    child: _buildStatColumn(
                      child: const Icon(Icons.update_outlined, size: 18, color: AppColors.accentOrange),
                      label: tool.lastUpdated,
                    ),
                  ),
                ],
              ),
            ),
            if (tool.pricingTiers.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Text('Pricing', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
              ),
              AppSpacing.gapSm,
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  itemCount: tool.pricingTiers.length,
                  separatorBuilder: (_, __) => AppSpacing.hGapSm,
                  itemBuilder: (context, index) {
                    final entry = tool.pricingTiers.entries.elementAt(index);
                    final isMain = index == 0;
                    return Container(
                      width: 160,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isMain ? tool.color.withOpacity(0.08) : AppColors.surfaceLight,
                        borderRadius: AppSpacing.borderRadiusMd,
                        border: Border.all(
                          color: isMain ? tool.color : AppColors.borderLight,
                          width: isMain ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            entry.key,
                            style: AppTypography.titleSmall(
                              color: isMain ? tool.color : AppColors.textPrimaryLight,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSpacing.gapXs,
                          Text(
                            entry.value,
                            style: AppTypography.bodyLarge(color: AppColors.textPrimaryLight, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.gapBase,
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: Text(tool.description, style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight)),
            ),
            AppSpacing.gapXl,
            if (tool.features.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Text('Key Features', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
              ),
              AppSpacing.gapSm,
              ...tool.features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.xs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle, size: 18, color: AppColors.successLight),
                        AppSpacing.hGapSm,
                        Expanded(
                          child: Text(feature, style: AppTypography.bodyMedium(color: AppColors.textPrimaryLight)),
                        ),
                      ],
                    ),
                  )),
              AppSpacing.gapBase,
            ],
            if (tool.useCases.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Text('Best For', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
              ),
              AppSpacing.gapSm,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: tool.useCases
                      .map((useCase) => Chip(
                            label: Text(useCase, style: AppTypography.labelMedium(color: tool.color)),
                            backgroundColor: tool.color.withOpacity(0.1),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusFull),
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
              ),
              AppSpacing.gapBase,
            ],
            if (tool.pros.isNotEmpty || tool.cons.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tool.pros.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.check_circle, size: 18, color: AppColors.successLight),
                                AppSpacing.hGapXs,
                                Text('Pros', style: AppTypography.titleSmall(color: AppColors.successLight)),
                              ],
                            ),
                            AppSpacing.gapSm,
                            ...tool.pros.map((pro) => Padding(
                                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.check, size: 14, color: AppColors.successLight),
                                      AppSpacing.hGapXs,
                                      Expanded(
                                        child: Text(pro, style: AppTypography.bodySmall(color: AppColors.textPrimaryLight)),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    if (tool.pros.isNotEmpty && tool.cons.isNotEmpty) AppSpacing.hGapBase,
                    if (tool.cons.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.cancel, size: 18, color: AppColors.errorLight),
                                AppSpacing.hGapXs,
                                Text('Cons', style: AppTypography.titleSmall(color: AppColors.errorLight)),
                              ],
                            ),
                            AppSpacing.gapSm,
                            ...tool.cons.map((con) => Padding(
                                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.close, size: 14, color: AppColors.errorLight),
                                      AppSpacing.hGapXs,
                                      Expanded(
                                        child: Text(con, style: AppTypography.bodySmall(color: AppColors.textPrimaryLight)),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              AppSpacing.gapXl,
            ],
            if (reviews.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Text('User Reviews', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
              ),
              AppSpacing.gapSm,
              ...reviews.map((review) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.xs),
                    padding: AppSpacing.cardPadding,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: AppSpacing.borderRadiusMd,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.primaryLight.withOpacity(0.15),
                              child: Text(
                                review.userName.isNotEmpty ? review.userName[0].toUpperCase() : '?',
                                style: AppTypography.labelMedium(color: AppColors.primaryLight),
                              ),
                            ),
                            AppSpacing.hGapSm,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(review.userName, style: AppTypography.labelLarge(color: AppColors.textPrimaryLight)),
                                      if (review.isVerified) ...[
                                        AppSpacing.hGapXs,
                                        const Icon(Icons.verified, size: 14, color: AppColors.accentBlue),
                                      ],
                                    ],
                                  ),
                                  _buildStarRow(review.rating, size: 12),
                                ],
                              ),
                            ),
                            Text(
                              '${review.date.day}/${review.date.month}/${review.date.year}',
                              style: AppTypography.bodySmall(color: AppColors.textTertiaryLight),
                            ),
                          ],
                        ),
                        AppSpacing.gapSm,
                        Text(review.title, style: AppTypography.titleSmall(color: AppColors.textPrimaryLight)),
                        AppSpacing.gapXs,
                        Text(review.content, style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight)),
                        AppSpacing.gapSm,
                        Row(
                          children: [
                            const Icon(Icons.thumb_up_outlined, size: 14, color: AppColors.textTertiaryLight),
                            AppSpacing.hGapXs,
                            Text(
                              'Helpful (${review.helpfulCount})',
                              style: AppTypography.bodySmall(color: AppColors.textTertiaryLight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              AppSpacing.gapBase,
            ],
            if (alternatives.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Text('Alternatives', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
              ),
              AppSpacing.gapSm,
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  itemCount: alternatives.length,
                  separatorBuilder: (_, __) => AppSpacing.hGapSm,
                  itemBuilder: (context, index) {
                    final alt = alternatives[index];
                    return GestureDetector(
                      onTap: () => context.push('/ai-tools/${alt.id}'),
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: AppSpacing.borderRadiusMd,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: alt.color.withOpacity(0.15),
                              child: Icon(alt.icon, color: alt.color, size: AppSpacing.iconMd),
                            ),
                            AppSpacing.gapSm,
                            Text(
                              alt.name,
                              style: AppTypography.labelMedium(color: AppColors.textPrimaryLight),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppSpacing.gapXs,
                            _buildStarRow(alt.rating, size: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.gapBase,
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(AppSpacing.base, AppSpacing.md, AppSpacing.base, AppSpacing.xl),
        decoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: AppSpacing.buttonHeightLg,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse(tool.website.startsWith('http') ? tool.website : 'https://${tool.website}');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                  ),
                  child: Text('Visit Website', style: AppTypography.labelLarge(color: Colors.white)),
                ),
              ),
            ),
            AppSpacing.hGapSm,
            SizedBox(
              height: AppSpacing.buttonHeightLg,
              child: OutlinedButton(
                onPressed: () => ref.read(bookmarkedToolsProvider.notifier).toggle(toolId),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderLight),
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                ),
                child: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  size: 20,
                  color: isBookmarked ? AppColors.primaryLight : AppColors.textSecondaryLight,
                ),
              ),
            ),
            AppSpacing.hGapSm,
            SizedBox(
              height: AppSpacing.buttonHeightLg,
              child: OutlinedButton(
                onPressed: () {
                  ref.read(comparedToolsProvider.notifier).toggle(toolId);
                  context.push('/ai-tools/compare');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderLight),
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                ),
                child: Icon(
                  Icons.compare_arrows,
                  size: 20,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn({required Widget child, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        AppSpacing.gapXs,
        Text(label, style: AppTypography.bodySmall(color: AppColors.textSecondaryLight)),
      ],
    );
  }
}
