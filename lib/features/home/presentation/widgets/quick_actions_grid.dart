import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key, required this.actions});

  final List<QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Quick Actions'),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.0,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              return _ActionTile(action: actions[index])
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 60 * index),
                    duration: 350.ms,
                  )
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                  );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.action});

  final QuickAction action;

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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.1),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Icon(action.icon, color: action.color, size: 26),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            action.label,
            style: AppTypography.labelMedium(
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
