import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  Color _colorForType(HistoryItemType type) {
    switch (type) {
      case HistoryItemType.job: return AppColors.accentBlue;
      case HistoryItemType.article: return AppColors.accentOrange;
      case HistoryItemType.project: return AppColors.accentCyan;
      case HistoryItemType.lesson: return Colors.green;
      case HistoryItemType.quiz: return AppColors.accentPink;
      case HistoryItemType.skillTest: return AppColors.primaryLight;
      case HistoryItemType.aiChat: return AppColors.accentYellow;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('History', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.base),
        itemCount: history.length,
        itemBuilder: (_, i) {
          final item = history[i];
          final color = _colorForType(item.type);
          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: AppSpacing.borderRadiusMd,
              border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Icon(item.icon, color: color, size: 20),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                      Text(item.subtitle, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Text(item.timestamp, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          );
        },
      ),
    );
  }
}
