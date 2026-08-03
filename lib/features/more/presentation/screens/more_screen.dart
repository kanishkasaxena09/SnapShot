import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text('More', style: AppTypography.titleLarge(color: colorScheme.onSurface)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, 'AI & Productivity', _aiActions),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(context, 'Learning & Skills', _learningActions),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(context, 'Development', _devActions),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(context, 'Career', _careerActions),
            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<_MoreAction> actions) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.titleMedium(color: colorScheme.onSurface)),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.85,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return _MoreTile(action: action)
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 40 * index),
                  duration: 350.ms,
                )
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                );
          },
        ),
      ],
    );
  }

  static const _aiActions = [
    _MoreAction(label: 'AI Chat', icon: Icons.auto_awesome_outlined, color: AppColors.primaryLight, route: '/ai-assistant'),
    _MoreAction(label: 'AI Tools', icon: Icons.smart_toy_outlined, color: AppColors.accentPink, route: '/ai-tools'),
    _MoreAction(label: 'Skill Test', icon: Icons.psychology_outlined, color: AppColors.accentBlue, route: '/skill-analyzer'),
    _MoreAction(label: 'Cheat Sheets', icon: Icons.description_outlined, color: AppColors.accentOrange, route: '/learning/cheat-sheets'),
  ];

  static const _learningActions = [
    _MoreAction(label: 'Learn', icon: Icons.school_outlined, color: AppColors.accentBlue, route: '/learning-hub'),
    _MoreAction(label: 'Roadmaps', icon: Icons.route_outlined, color: AppColors.secondaryLight, route: '/learning/roadmaps'),
    _MoreAction(label: 'Lessons', icon: Icons.menu_book_outlined, color: AppColors.accentCyan, route: '/learning/lessons'),
    _MoreAction(label: 'Quizzes', icon: Icons.quiz_outlined, color: AppColors.accentOrange, route: '/learning/quizzes'),
    _MoreAction(label: 'Videos', icon: Icons.play_circle_outline, color: AppColors.tertiaryLight, route: '/learning/videos'),
    _MoreAction(label: 'Notes', icon: Icons.notes_outlined, color: AppColors.accentYellow, route: '/learning/notes'),
    _MoreAction(label: 'Challenges', icon: Icons.emoji_events_outlined, color: AppColors.accentPink, route: '/learning/challenges'),
    _MoreAction(label: 'Certificates', icon: Icons.workspace_premium_outlined, color: AppColors.accentBlue, route: '/learning/certificates'),
  ];

  static const _devActions = [
    _MoreAction(label: 'Projects', icon: Icons.folder_outlined, color: AppColors.accentCyan, route: '/project-hub'),
    _MoreAction(label: 'Search', icon: Icons.search_rounded, color: AppColors.accentYellow, route: '/github/search'),
    _MoreAction(label: 'Trending', icon: Icons.inventory_2_outlined, color: AppColors.accentOrange, route: '/github/trending-repos'),
    _MoreAction(label: 'Devs', icon: Icons.people_outline, color: AppColors.secondaryLight, route: '/github/trending-devs'),
  ];

  static const _careerActions = [
    _MoreAction(label: 'Jobs', icon: Icons.work_outline_rounded, color: AppColors.primaryLight, route: '/jobs'),
    _MoreAction(label: 'Resume', icon: Icons.description_outlined, color: AppColors.secondaryLight, route: '/profile/resume-score'),
    _MoreAction(label: 'Bookmarks', icon: Icons.bookmark_outline_rounded, color: AppColors.accentPink, route: '/bookmarks'),
    _MoreAction(label: 'History', icon: Icons.history_rounded, color: AppColors.accentOrange, route: '/profile/history'),
  ];
}

class _MoreAction {
  const _MoreAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String route;
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({required this.action});

  final _MoreAction action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        if (action.route.isNotEmpty) {
          GoRouter.of(context).push(action.route);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Icon(action.icon, color: action.color, size: 24),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            action.label,
            style: AppTypography.labelSmall(color: colorScheme.onSurface),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
