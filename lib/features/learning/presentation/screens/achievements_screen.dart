import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({super.key});

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  String _selectedRarity = 'All';

  static const _rarityFilters = [
    'All',
    'Common',
    'Uncommon',
    'Rare',
    'Epic',
    'Legendary',
  ];

  Color _rarityColor(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return AppColors.textTertiaryLight;
      case AchievementRarity.uncommon:
        return AppColors.successLight;
      case AchievementRarity.rare:
        return AppColors.accentBlue;
      case AchievementRarity.epic:
        return AppColors.primaryLight;
      case AchievementRarity.legendary:
        return AppColors.accentYellow;
    }
  }

  AchievementRarity? _rarityFromString(String value) {
    switch (value) {
      case 'Common':
        return AchievementRarity.common;
      case 'Uncommon':
        return AchievementRarity.uncommon;
      case 'Rare':
        return AchievementRarity.rare;
      case 'Epic':
        return AchievementRarity.epic;
      case 'Legendary':
        return AchievementRarity.legendary;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final achievements = ref.watch(learningAchievementsProvider);
    final unlockedCount = achievements.where((a) => a.isUnlocked).length;
    final totalXP = achievements
        .where((a) => a.isUnlocked)
        .fold<int>(0, (sum, a) => sum + a.progress * 10);

    final filtered = _selectedRarity == 'All'
        ? achievements
        : achievements
            .where((a) => a.rarity == _rarityFromString(_selectedRarity))
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Achievements', style: AppTypography.headlineLarge()),
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
            child: Container(
              width: double.infinity,
              padding: AppSpacing.paddingXl,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: AppSpacing.borderRadiusLg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '$unlockedCount/${achievements.length}',
                        style: AppTypography.headlineMedium(
                          color: AppColors.textInverseLight,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'Unlocked',
                        style: AppTypography.bodySmall(
                          color: AppColors.textInverseLight.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppColors.textInverseLight.withOpacity(0.3),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.accentYellow,
                            size: AppSpacing.iconMd,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '$totalXP',
                            style: AppTypography.headlineMedium(
                              color: AppColors.textInverseLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'XP Earned',
                        style: AppTypography.bodySmall(
                          color: AppColors.textInverseLight.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.base),
          SizedBox(
            height: AppSpacing.chipHeightLg,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
              ),
              itemCount: _rarityFilters.length,
              separatorBuilder: (_, __) => AppSpacing.hGapSm,
              itemBuilder: (context, index) {
                final rarity = _rarityFilters[index];
                final isSelected = _selectedRarity == rarity;
                final chipColor = rarity == 'All'
                    ? AppColors.primaryLight
                    : _rarityColor(_rarityFromString(rarity)!);
                return FilterChip(
                  label: Text(
                    rarity,
                    style: AppTypography.labelMedium(
                      color: isSelected
                          ? AppColors.textInverseLight
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: chipColor,
                  backgroundColor: AppColors.surfaceVariantLight,
                  checkmarkColor: AppColors.textInverseLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.borderRadiusFull,
                    side: BorderSide(
                      color: isSelected ? chipColor : AppColors.borderLight,
                    ),
                  ),
                  onSelected: (_) {
                    setState(() {
                      _selectedRarity = rarity;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No achievements in this category',
                      style: AppTypography.bodyMedium(
                        color: AppColors.textTertiaryLight,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.sm,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final achievement = filtered[index];
                      final color = achievement.isUnlocked
                          ? achievement.color
                          : AppColors.textTertiaryLight;
                      final progress =
                          achievement.progress / achievement.totalRequired;

                      return Container(
                        decoration: BoxDecoration(
                          color: achievement.isUnlocked
                              ? AppColors.cardLight
                              : AppColors.surfaceVariantLight,
                          borderRadius: AppSpacing.borderRadiusMd,
                          boxShadow: achievement.isUnlocked
                              ? const [
                                  BoxShadow(
                                    color: AppColors.shadowLight,
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    achievement.icon,
                                    color: color,
                                    size: AppSpacing.iconLg,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  achievement.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.titleSmall(
                                    color: achievement.isUnlocked
                                        ? AppColors.textPrimaryLight
                                        : AppColors.textTertiaryLight,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  achievement.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bodySmall(
                                    color: AppColors.textSecondaryLight,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: AppSpacing.xxs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _rarityColor(achievement.rarity)
                                        .withOpacity(0.1),
                                    borderRadius: AppSpacing.borderRadiusFull,
                                  ),
                                  child: Text(
                                    achievement.rarity.name.toUpperCase(),
                                    style: AppTypography.labelSmall(
                                      color: _rarityColor(achievement.rarity),
                                    ),
                                  ),
                                ),
                                if (!achievement.isUnlocked &&
                                    achievement.totalRequired > 1) ...[
                                  const SizedBox(height: AppSpacing.sm),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            AppSpacing.borderRadiusFull,
                                        child: LinearProgressIndicator(
                                          value: progress,
                                          minHeight: 6,
                                          backgroundColor:
                                              AppColors.borderLight,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            color,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.xxs),
                                      Text(
                                        '${achievement.progress}/${achievement.totalRequired}',
                                        style: AppTypography.labelSmall(
                                          color: AppColors.textTertiaryLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (achievement.isUnlocked &&
                                    achievement.unlockedAt != null) ...[
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    '${achievement.unlockedAt!.day}/${achievement.unlockedAt!.month}/${achievement.unlockedAt!.year}',
                                    style: AppTypography.labelSmall(
                                      color: AppColors.textTertiaryLight,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (!achievement.isUnlocked)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceVariantLight
                                        .withOpacity(0.6),
                                    borderRadius: AppSpacing.borderRadiusMd,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.lock_rounded,
                                      color: AppColors.textTertiaryLight,
                                      size: AppSpacing.iconXl,
                                    ),
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
}
