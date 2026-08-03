import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/profile_entities.dart';
import '../providers/profile_providers.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(profileAchievementsProvider);
    final unlocked = achievements.where((a) => a.isUnlocked).length;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text('Achievements', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.accentYellow, AppColors.accentYellow.withValues(alpha: 0.8)]),
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Row(
                children: [
                  Icon(Icons.emoji_events, color: Colors.white, size: 36),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$unlocked / ${achievements.length}', style: AppTypography.titleLarge(color: Colors.white)),
                      Text('Achievements Unlocked', style: AppTypography.bodySmall(color: Colors.white.withValues(alpha: 0.85))),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: unlocked / achievements.length,
                          strokeWidth: 5,
                          backgroundColor: Colors.white.withValues(alpha: 0.3),
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                        Center(
                          child: Text('${((unlocked / achievements.length) * 100).round()}%', style: AppTypography.labelMedium(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Achievements Grid
            Text('All Achievements', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            ...achievements.map((a) => _AchievementTile(achievement: a)),
          ],
        ),
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({required this.achievement});
  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progress = achievement.maxProgress > 0 ? achievement.progress / achievement.maxProgress : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: achievement.isUnlocked ? colorScheme.surface : colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: achievement.isUnlocked ? achievement.color.withValues(alpha: 0.3) : colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: achievement.color.withValues(alpha: achievement.isUnlocked ? 0.15 : 0.06),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Icon(achievement.icon, color: achievement.color.withValues(alpha: achievement.isUnlocked ? 1.0 : 0.4), size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(achievement.title, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                    ),
                    if (achievement.isUnlocked)
                      Icon(Icons.check_circle, color: achievement.color, size: 18)
                    else
                      Text('${achievement.progress}/${achievement.maxProgress}', style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(achievement.description, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
                if (!achievement.isUnlocked) ...[
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: AppSpacing.borderRadiusXs,
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation(achievement.color),
                    ),
                  ),
                ],
                if (achievement.isUnlocked && achievement.unlockedAt != null) ...[
                  const SizedBox(height: 4),
                  Text('Unlocked ${achievement.unlockedAt}', style: AppTypography.labelSmall(color: achievement.color)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
