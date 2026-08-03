import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
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
        title: Text('Account Settings', style: AppTypography.titleMedium(color: AppColors.textPrimaryLight)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusLg,
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryLight.withValues(alpha: 0.15),
                    child: Text(profile.name.split(' ').map((n) => n[0]).join(), style: AppTypography.titleMedium(color: AppColors.primaryLight)),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                        Text(profile.email, style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Settings Sections
            Text('Account', style: AppTypography.labelMedium(color: AppColors.textSecondaryLight)),
            const SizedBox(height: AppSpacing.sm),
            _SettingsTile(icon: Icons.person_outline, title: 'Edit Profile', onTap: () {}),
            _SettingsTile(icon: Icons.email_outlined, title: 'Change Email', onTap: () {}),
            _SettingsTile(icon: Icons.lock_outline, title: 'Change Password', onTap: () {}),
            _SettingsTile(icon: Icons.link, title: 'Connected Accounts', onTap: () {}),
            const SizedBox(height: AppSpacing.lg),

            Text('Preferences', style: AppTypography.labelMedium(color: AppColors.textSecondaryLight)),
            const SizedBox(height: AppSpacing.sm),
            _SettingsTile(icon: Icons.notifications_outlined, title: 'Notifications', onTap: () {}),
            _SettingsTile(icon: Icons.language, title: 'Language', trailing: 'English', onTap: () {}),
            _SettingsTile(icon: Icons.compress, title: 'Data Usage', onTap: () {}),
            const SizedBox(height: AppSpacing.lg),

            Text('Support', style: AppTypography.labelMedium(color: AppColors.textSecondaryLight)),
            const SizedBox(height: AppSpacing.sm),
            _SettingsTile(icon: Icons.help_outline, title: 'Help Center', onTap: () {}),
            _SettingsTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', onTap: () {}),
            _SettingsTile(icon: Icons.description_outlined, title: 'Terms of Service', onTap: () {}),
            _SettingsTile(icon: Icons.info_outline, title: 'About', trailing: 'v1.0.0', onTap: () {}),
            const SizedBox(height: AppSpacing.lg),

            // Danger Zone
            Text('Danger Zone', style: AppTypography.labelMedium(color: AppColors.accentPink)),
            const SizedBox(height: AppSpacing.sm),
            _SettingsTile(icon: Icons.delete_outline, title: 'Delete Account', color: AppColors.accentPink, onTap: () {}),
            _SettingsTile(icon: Icons.logout, title: 'Log Out', color: AppColors.accentPink, onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, this.trailing, this.color, required this.onTap});
  final IconData icon;
  final String title;
  final String? trailing;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final itemColor = color ?? colorScheme.onSurface;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: itemColor, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(title, style: AppTypography.titleSmall(color: itemColor))),
            if (trailing != null)
              Text(trailing!, style: AppTypography.labelMedium(color: colorScheme.onSurfaceVariant)),
            const SizedBox(width: AppSpacing.xs),
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant, size: 20),
          ],
        ),
      ),
    );
  }
}
