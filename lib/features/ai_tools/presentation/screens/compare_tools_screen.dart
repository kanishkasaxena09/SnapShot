import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/ai_tools_entities.dart';
import '../providers/ai_tools_providers.dart';

class CompareToolsScreen extends ConsumerWidget {
  const CompareToolsScreen({super.key});

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

  String _pricingLabel(PricingTier tier) {
    switch (tier) {
      case PricingTier.free:
        return 'Free';
      case PricingTier.freemium:
        return 'Freemium';
      case PricingTier.paid:
        return 'Paid';
      case PricingTier.enterprise:
        return 'Enterprise';
      case PricingTier.contact:
        return 'Contact';
    }
  }

  String _categoryLabel(AiToolCategory cat) {
    switch (cat) {
      case AiToolCategory.llm:
        return 'LLM';
      case AiToolCategory.imageGeneration:
        return 'Image Gen';
      case AiToolCategory.codeAssist:
        return 'Code';
      case AiToolCategory.productivity:
        return 'Productivity';
      case AiToolCategory.video:
        return 'Video';
      case AiToolCategory.audio:
        return 'Audio';
      case AiToolCategory.design:
        return 'Design';
      case AiToolCategory.dataScience:
        return 'Data Science';
      case AiToolCategory.writing:
        return 'Writing';
      case AiToolCategory.automation:
        return 'Automation';
      case AiToolCategory.research:
        return 'Research';
      case AiToolCategory.translation:
        return 'Translation';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comparedIds = ref.watch(comparedToolsProvider);
    final tools = comparedIds
        .map((id) => ref.watch(aiToolDetailProvider(id)))
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
        title: Text('Compare Tools', style: AppTypography.titleLarge(color: AppColors.textPrimaryLight)),
        centerTitle: true,
        actions: [
          if (comparedIds.isNotEmpty)
            TextButton(
              onPressed: () => ref.read(comparedToolsProvider.notifier).clear(),
              child: Text('Clear All', style: AppTypography.labelLarge(color: AppColors.errorLight)),
            ),
        ],
      ),
      body: tools.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.compare_arrows, size: 40, color: AppColors.primaryLight),
                    ),
                    AppSpacing.gapXl,
                    Text(
                      'No tools selected',
                      style: AppTypography.titleMedium(color: AppColors.textPrimaryLight),
                    ),
                    AppSpacing.gapSm,
                    Text(
                      'Select up to 3 tools to compare',
                      style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight),
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.gapXl,
                    Container(
                      height: AppSpacing.buttonHeightLg,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                        ),
                        child: Text('Browse Tools', style: AppTypography.labelLarge(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.base),
                    child: Row(
                      children: [
                        const SizedBox(width: 100),
                        ...tools.map((tool) => Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: tool.color.withOpacity(0.15),
                                      child: Icon(tool.icon, color: tool.color, size: AppSpacing.iconMd),
                                    ),
                                    AppSpacing.gapXs,
                                    Text(
                                      tool.name,
                                      style: AppTypography.labelLarge(color: AppColors.textPrimaryLight),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildComparisonRow('Rating', tools, (tool) => _buildStarRow(tool.rating, size: 12)),
                  _buildComparisonRow('Reviews', tools, (tool) => Text(
                        '${tool.reviewCount}',
                        style: AppTypography.bodyMedium(color: AppColors.textPrimaryLight),
                      )),
                  _buildComparisonRow('Pricing', tools, (tool) => Text(
                        _pricingLabel(tool.pricing),
                        style: AppTypography.bodyMedium(color: AppColors.textPrimaryLight),
                      )),
                  _buildComparisonRow('Category', tools, (tool) => Text(
                        _categoryLabel(tool.category),
                        style: AppTypography.bodyMedium(color: AppColors.textPrimaryLight),
                      )),
                  _buildComparisonRow('Last Updated', tools, (tool) => Text(
                        tool.lastUpdated,
                        style: AppTypography.bodyMedium(color: AppColors.textPrimaryLight),
                      )),
                  const SizedBox(height: AppSpacing.base),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                    child: Text('Features', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
                  ),
                  AppSpacing.gapSm,
                  _buildFeatureComparison(tools),
                  if (tools.any((t) => t.pros.isNotEmpty)) ...[
                    const SizedBox(height: AppSpacing.base),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                      child: Text('Pros', style: AppTypography.titleMedium(color: AppColors.successLight)),
                    ),
                    AppSpacing.gapSm,
                    _buildProsConsComparison(tools, (tool) => tool.pros),
                  ],
                  if (tools.any((t) => t.cons.isNotEmpty)) ...[
                    const SizedBox(height: AppSpacing.base),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                      child: Text('Cons', style: AppTypography.titleMedium(color: AppColors.errorLight)),
                    ),
                    AppSpacing.gapSm,
                    _buildProsConsComparison(tools, (tool) => tool.cons),
                  ],
                  const SizedBox(height: AppSpacing.xxl),
                  if (tools.length < 3)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
                      child: SizedBox(
                        width: double.infinity,
                        height: AppSpacing.buttonHeightLg,
                        child: OutlinedButton.icon(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.add, size: 20, color: AppColors.primaryLight),
                          label: Text('Add Tool', style: AppTypography.labelLarge(color: AppColors.primaryLight)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primaryLight),
                            shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
    );
  }

  Widget _buildComparisonRow(String label, List<AiTool> tools, Widget Function(AiTool) builder) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        border: Border(bottom: BorderSide(color: AppColors.borderLight, width: 0.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: AppTypography.labelMedium(color: AppColors.textSecondaryLight)),
          ),
          ...tools.map((tool) => Expanded(
                child: Center(child: builder(tool)),
              )),
        ],
      ),
    );
  }

  Widget _buildFeatureComparison(List<AiTool> tools) {
    final allFeatures = <String>{};
    for (final tool in tools) {
      allFeatures.addAll(tool.features);
    }
    final sortedFeatures = allFeatures.toList()..sort();

    return Column(
      children: sortedFeatures.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.md),
          decoration: const BoxDecoration(
            color: AppColors.surfaceLight,
            border: Border(bottom: BorderSide(color: AppColors.borderLight, width: 0.5)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  feature,
                  style: AppTypography.bodySmall(color: AppColors.textPrimaryLight),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ...tools.map((tool) => Expanded(
                    child: Center(
                      child: tool.features.contains(feature)
                          ? const Icon(Icons.check_circle, size: 18, color: AppColors.successLight)
                          : const Icon(Icons.cancel_outlined, size: 18, color: AppColors.errorLight),
                    ),
                  )),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProsConsComparison(List<AiTool> tools, List<String> Function(AiTool) extractor) {
    final allItems = <String>{};
    for (final tool in tools) {
      allItems.addAll(extractor(tool));
    }
    final sortedItems = allItems.toList()..sort();

    return Column(
      children: sortedItems.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.sm),
          decoration: const BoxDecoration(
            color: AppColors.surfaceLight,
            border: Border(bottom: BorderSide(color: AppColors.borderLight, width: 0.5)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  item,
                  style: AppTypography.bodySmall(color: AppColors.textPrimaryLight),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ...tools.map((tool) => Expanded(
                    child: Center(
                      child: extractor(tool).contains(item)
                          ? const Icon(Icons.check, size: 16, color: AppColors.successLight)
                          : const Icon(Icons.close, size: 16, color: AppColors.errorLight),
                    ),
                  )),
            ],
          ),
        );
      }).toList(),
    );
  }
}
