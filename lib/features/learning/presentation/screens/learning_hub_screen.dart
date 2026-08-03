import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/learning_entities.dart';
import '../providers/learning_providers.dart';

class LearningHubScreen extends ConsumerStatefulWidget {
  const LearningHubScreen({super.key});

  @override
  ConsumerState<LearningHubScreen> createState() =>
      _LearningHubScreenState();
}

class _LearningHubScreenState
    extends ConsumerState<LearningHubScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final streak = ref.watch(streakProvider);
    final lessons = ref.watch(lessonsProvider);
    final challenges = ref.watch(dailyChallengesProvider);
    final achievements = ref.watch(learningAchievementsProvider);
    final certificates = ref.watch(certificatesProvider);
    final inProgressLessons =
        lessons.where((l) => l.completedModules > 0).toList();
    final todayChallenge =
        challenges.isNotEmpty ? challenges.first : null;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Learning Hub', style: AppTypography.headlineLarge()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StreakBanner(streak: streak),
            const SizedBox(height: AppSpacing.xxl),
            Text('Continue Learning',
                style: AppTypography.titleLarge(
                    color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 160,
              child: inProgressLessons.isEmpty
                  ? Center(
                      child: Text('No lessons in progress',
                          style: AppTypography.bodyMedium(
                              color:
                                  colorScheme.onSurfaceVariant)))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: inProgressLessons.length,
                      separatorBuilder: (_, __) =>
                          AppSpacing.hGapMd,
                      itemBuilder: (context, index) {
                        final lesson =
                            inProgressLessons[index];
                        return GestureDetector(
                          onTap: () => context.push(
                              '/learning/lesson/${lesson.id}'),
                          child: Container(
                            width: 240,
                            padding: AppSpacing.cardPadding,
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius:
                                  AppSpacing.borderRadiusMd,
                              boxShadow: const [
                                BoxShadow(
                                  color:
                                      AppColors.shadowLight,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(lesson.title,
                                    maxLines: 1,
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style: AppTypography.titleMedium(
                                        color: colorScheme
                                            .onSurface)),
                                const SizedBox(
                                    height: AppSpacing.xs),
                                Text(lesson.category,
                                    style: AppTypography.labelSmall(
                                        color: colorScheme
                                            .onSurfaceVariant)),
                                const Spacer(),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(
                                          AppSpacing
                                              .radiusFull),
                                  child:
                                      LinearProgressIndicator(
                                    value:
                                        lesson.progress,
                                    backgroundColor:
                                        colorScheme
                                            .primaryContainer,
                                    valueColor:
                                        AlwaysStoppedAnimation(
                                            colorScheme
                                                .primary),
                                    minHeight: 6,
                                  ),
                                ),
                                const SizedBox(
                                    height: AppSpacing.sm),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Text(
                                        '${lesson.completedModules}/${lesson.totalModules} modules',
                                        style: AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant)),
                                    Text(
                                        '${lesson.durationMinutes} min',
                                        style: AppTypography.labelSmall(
                                            color: colorScheme
                                                .onSurfaceVariant)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('Quick Access',
                style: AppTypography.titleLarge(
                    color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.6,
              children: const [
                _QuickAccessItem(
                  icon: Icons.map_outlined,
                  label: 'Roadmaps',
                  color: AppColors.accentBlue,
                  route: '/learning/roadmaps',
                ),
                _QuickAccessItem(
                  icon: Icons.book_outlined,
                  label: 'Lessons',
                  color: AppColors.primaryLight,
                  route: '/learning/lessons',
                ),
                _QuickAccessItem(
                  icon: Icons.play_circle_outline,
                  label: 'Videos',
                  color: AppColors.accentPink,
                  route: '/learning/videos',
                ),
                _QuickAccessItem(
                  icon: Icons.note_outlined,
                  label: 'Notes',
                  color: AppColors.accentOrange,
                  route: '/learning/notes',
                ),
                _QuickAccessItem(
                  icon: Icons.table_chart_outlined,
                  label: 'Cheat Sheets',
                  color: AppColors.accentCyan,
                  route: '/learning/cheat-sheets',
                ),
                _QuickAccessItem(
                  icon: Icons.quiz_outlined,
                  label: 'Quizzes',
                  color: AppColors.accentYellow,
                  route: '/learning/quizzes',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            if (todayChallenge != null) ...[
              Text('Daily Challenge',
                  style: AppTypography.titleLarge(
                      color: colorScheme.onSurface)),
              const SizedBox(height: AppSpacing.md),
              _DailyChallengeCard(
                  challenge: todayChallenge),
            ],
            const SizedBox(height: AppSpacing.xxl),
            Text('Recent Achievements',
                style: AppTypography.titleLarge(
                    color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount:
                    achievements.length.clamp(0, 4),
                separatorBuilder: (_, __) =>
                    AppSpacing.hGapMd,
                itemBuilder: (context, index) {
                  final achievement =
                      achievements[index];
                  return GestureDetector(
                    onTap: () => context
                        .push('/learning/achievements'),
                    child: Container(
                      width: 160,
                      padding: AppSpacing.paddingMd,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius:
                            AppSpacing.borderRadiusMd,
                        boxShadow: const [
                          BoxShadow(
                            color:
                                AppColors.shadowLight,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(achievement.icon,
                              color:
                                  achievement.color,
                              size: 28),
                          const SizedBox(
                              height: AppSpacing.xs),
                          Text(achievement.title,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              textAlign:
                                  TextAlign.center,
                              style: AppTypography.labelMedium(
                                  color: colorScheme
                                      .onSurface)),
                          const SizedBox(
                              height: AppSpacing.xxs),
                          _RarityBadge(
                              rarity:
                                  achievement.rarity),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('Certificates',
                style: AppTypography.titleLarge(
                    color: colorScheme.onSurface)),
            const SizedBox(height: AppSpacing.md),
            ...certificates.take(3).map(
                  (cert) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppSpacing.md),
                    child: GestureDetector(
                      onTap: () => context.push(
                          '/learning/certificates'),
                      child: Container(
                        padding: AppSpacing.cardPadding,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius:
                              AppSpacing.borderRadiusMd,
                          boxShadow: const [
                            BoxShadow(
                              color:
                                  AppColors.shadowLight,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: cert.color
                                    .withOpacity(0.1),
                                borderRadius: AppSpacing
                                    .borderRadiusSm,
                              ),
                              child: const Icon(
                                  Icons
                                      .workspace_premium_outlined,
                                  color: AppColors
                                      .accentOrange),
                            ),
                            AppSpacing.hGapMd,
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(cert.title,
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                      style: AppTypography.titleMedium(
                                          color: colorScheme
                                              .onSurface)),
                                  Text(cert.issuer,
                                      style: AppTypography.bodySmall(
                                          color: colorScheme
                                              .onSurfaceVariant)),
                                ],
                              ),
                            ),
                            Text(
                              '${cert.issuedDate.day}/${cert.issuedDate.month}/${cert.issuedDate.year}',
                              style: AppTypography.labelSmall(
                                  color: colorScheme
                                      .onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
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

class _StreakBanner extends StatelessWidget {
  final LearningStreak streak;

  const _StreakBanner({required this.streak});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/learning/streaks'),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: AppSpacing.borderRadiusLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                    Icons.local_fire_department_outlined,
                    color: AppColors.accentYellow,
                    size: 28),
                AppSpacing.hGapSm,
                Text('${streak.currentStreak} Day Streak',
                    style: AppTypography.titleLarge(
                        color:
                            AppColors.textInverseLight)),
                const Spacer(),
                Text('Level ${streak.level}',
                    style: AppTypography.titleMedium(
                        color: AppColors
                            .textInverseLight
                            .withOpacity(0.9))),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Text('+${streak.todayXP} XP today',
                    style: AppTypography.bodyMedium(
                        color: AppColors
                            .textInverseLight
                            .withOpacity(0.9))),
                const Spacer(),
                Text('${streak.totalXP} total XP',
                    style: AppTypography.labelSmall(
                        color: AppColors
                            .textInverseLight
                            .withOpacity(0.7))),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  AppSpacing.radiusFull),
              child: LinearProgressIndicator(
                value: streak.levelProgress,
                backgroundColor:
                    Colors.white.withOpacity(0.3),
                valueColor:
                    const AlwaysStoppedAnimation(
                        Colors.white),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String route;

  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: AppSpacing.paddingMd,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius:
                    AppSpacing.borderRadiusSm,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            AppSpacing.hGapSm,
            Expanded(
              child: Text(label,
                  style: AppTypography.titleSmall(
                      color: colorScheme.onSurface)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyChallengeCard extends StatelessWidget {
  final DailyChallenge challenge;

  const _DailyChallengeCard(
      {required this.challenge});

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () =>
          context.push('/learning/challenges'),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(challenge.title,
                      style: AppTypography.titleMedium(
                          color: colorScheme
                              .onSurface)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: _difficultyColor(
                            challenge.difficulty)
                        .withOpacity(0.1),
                    borderRadius:
                        AppSpacing.borderRadiusFull,
                  ),
                  child: Text(
                    challenge.difficulty.name
                        .toUpperCase(),
                    style: AppTypography.labelSmall(
                        color: _difficultyColor(
                            challenge.difficulty)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.star_outline,
                    size: 16,
                    color: AppColors.accentYellow),
                Text(' ${challenge.points} pts',
                    style: AppTypography.labelMedium(
                        color: colorScheme
                            .onSurfaceVariant)),
                AppSpacing.hGapMd,
                Icon(Icons.timer_outlined,
                    size: 16,
                    color:
                        colorScheme.onSurfaceVariant),
                Text(
                    ' ${challenge.timeLimitMinutes} min',
                    style: AppTypography.labelMedium(
                        color: colorScheme
                            .onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context
                    .push('/learning/challenges'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor:
                      AppColors.textInverseLight,
                  padding:
                      AppSpacing.paddingVerticalSm,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        AppSpacing.borderRadiusSm,
                  ),
                ),
                child: Text(
                    challenge.status ==
                            ChallengeStatus.completed
                        ? 'View Results'
                        : 'Start Challenge',
                    style: AppTypography.labelLarge(
                        color: AppColors
                            .textInverseLight)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RarityBadge extends StatelessWidget {
  final AchievementRarity rarity;

  const _RarityBadge({required this.rarity});

  Color _color() {
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
        return AppColors.accentOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs, vertical: 1),
      decoration: BoxDecoration(
        color: _color().withOpacity(0.1),
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Text(
        rarity.name.toUpperCase(),
        style:
            AppTypography.labelSmall(color: _color()),
      ),
    );
  }
}
