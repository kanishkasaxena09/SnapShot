import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final achievements = ref.watch(profileAchievementsProvider);
    final learningStats = ref.watch(learningStatsProvider);
    final githubStats = ref.watch(gitHubStatsProvider);
    final resumeScore = ref.watch(resumeScoreProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final unlockedCount = achievements.where((a) => a.isUnlocked).length;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text('Profile', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 22),
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Semantics(
              label: 'Profile: ${profile.name}, ${profile.title}',
              child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.base),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: Text(profile.name.split(' ').map((n) => n[0]).join(), style: AppTypography.titleLarge(color: Colors.white)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(profile.name, style: AppTypography.titleLarge(color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(profile.title, style: AppTypography.bodySmall(color: Colors.white.withValues(alpha: 0.85))),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                      const SizedBox(width: 3),
                      Text(profile.location, style: AppTypography.labelSmall(color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                  if (profile.isPremium) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accentYellow.withValues(alpha: 0.2),
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.workspace_premium, size: 14, color: AppColors.accentYellow),
                          const SizedBox(width: 4),
                          Text('Premium', style: AppTypography.labelSmall(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            ),

            // Stats Row
            Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: Row(
                children: [
                  _StatCard(title: '${learningStats.totalHoursLearned}h', subtitle: 'Learned', icon: Icons.school, color: AppColors.accentBlue),
                  _StatCard(title: '${learningStats.currentStreak}', subtitle: 'Streak', icon: Icons.local_fire_department, color: AppColors.accentOrange),
                  _StatCard(title: '$unlockedCount/${achievements.length}', subtitle: 'Badges', icon: Icons.emoji_events, color: AppColors.accentYellow),
                  _StatCard(title: '${resumeScore.overallScore}%', subtitle: 'Resume', icon: Icons.description, color: AppColors.accentPink),
                ],
              ),
            ),

            // Quick Access Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: Text('Quick Access', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 0.9,
                children: [
                  _QuickAccessTile(label: 'Bookmarks', icon: Icons.bookmark_outline, color: AppColors.accentPink, onTap: () => context.push('/profile/bookmarks')),
                  _QuickAccessTile(label: 'History', icon: Icons.history, color: AppColors.accentBlue, onTap: () => context.push('/profile/history')),
                  _QuickAccessTile(label: 'Achievements', icon: Icons.emoji_events_outlined, color: AppColors.accentYellow, onTap: () => context.push('/profile/achievements')),
                  _QuickAccessTile(label: 'Learning', icon: Icons.school_outlined, color: AppColors.accentCyan, onTap: () => context.push('/profile/learning-stats')),
                  _QuickAccessTile(label: 'GitHub', icon: Icons.code, color: AppColors.accentOrange, onTap: () => context.push('/profile/github-stats')),
                  _QuickAccessTile(label: 'Resume', icon: Icons.description_outlined, color: AppColors.primaryLight, onTap: () => context.push('/profile/resume-score')),
                  _QuickAccessTile(label: 'Theme', icon: Icons.palette_outlined, color: AppColors.accentLime, onTap: () => context.push('/profile/theme-settings')),
                  _QuickAccessTile(label: 'Account', icon: Icons.person_outline, color: colorScheme.onSurfaceVariant, onTap: () => context.push('/profile/account-settings')),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Learning Stats Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: _SectionCard(
                title: 'Learning Stats',
                onTap: () => context.push('/profile/learning-stats'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MiniStat(value: '${learningStats.totalLessonsCompleted}', label: 'Lessons'),
                    _MiniStat(value: '${learningStats.coursesCompleted}', label: 'Courses'),
                    _MiniStat(value: '${learningStats.quizzesPassed}', label: 'Quizzes'),
                    _MiniStat(value: '${learningStats.skillsLearned}', label: 'Skills'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // GitHub Stats Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: _SectionCard(
                title: 'GitHub Stats',
                onTap: () => context.push('/profile/github-stats'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MiniStat(value: '${githubStats.totalRepos}', label: 'Repos'),
                    _MiniStat(value: '${githubStats.totalStars}', label: 'Stars'),
                    _MiniStat(value: '${githubStats.totalCommits}', label: 'Commits'),
                    _MiniStat(value: '${githubStats.contributionStreak}d', label: 'Streak'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Resume Score Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: _SectionCard(
                title: 'Resume Score',
                onTap: () => context.push('/profile/resume-score'),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: resumeScore.overallScore / 100,
                            strokeWidth: 6,
                            backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                            valueColor: AlwaysStoppedAnimation(
                              resumeScore.overallScore >= 80 ? Colors.green : AppColors.accentOrange,
                            ),
                          ),
                          Center(
                            child: Text('${resumeScore.overallScore}', style: AppTypography.titleMedium(color: colorScheme.onSurface)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overall Score', style: AppTypography.labelMedium(color: colorScheme.onSurface)),
                          const SizedBox(height: 4),
                          Text('${resumeScore.suggestions.length} suggestions to improve', style: AppTypography.bodySmall(color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.subtitle, required this.icon, required this.color});
  final String title, subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(title, style: AppTypography.titleSmall(color: color)),
            Text(subtitle, style: AppTypography.labelSmall(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessTile extends StatelessWidget {
  const _QuickAccessTile({required this.label, required this.icon, required this.color, required this.onTap});
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelSmall(color: Theme.of(context).colorScheme.onSurface), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child, this.onTap});
  final String title;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTypography.titleSmall(color: colorScheme.onSurface)),
                if (onTap != null) Icon(Icons.chevron_right, size: 20, color: colorScheme.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(value, style: AppTypography.titleMedium(color: colorScheme.onSurface)),
        Text(label, style: AppTypography.labelSmall(color: colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
