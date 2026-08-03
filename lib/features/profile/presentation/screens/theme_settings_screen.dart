import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = ref.watch(themeSettingsProvider);
    final selectedTheme = ref.watch(selectedThemeProvider);
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
        title: Text('Theme Settings', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Appearance', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.sm),
            ...themes.map((theme) {
              final isSelected = selectedTheme == theme.id;
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => ref.read(selectedThemeProvider.notifier).state = theme.id,
                  child: Container(
                    padding: AppSpacing.cardPadding,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: AppSpacing.borderRadiusMd,
                      border: Border.all(
                        color: isSelected ? AppColors.primaryLight : colorScheme.outlineVariant.withValues(alpha: 0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(theme.icon, color: isSelected ? AppColors.primaryLight : colorScheme.onSurfaceVariant, size: 24),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(theme.label, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: AppColors.primaryLight, size: 22)
                        else
                          Icon(Icons.circle_outlined, color: colorScheme.onSurfaceVariant, size: 22),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
