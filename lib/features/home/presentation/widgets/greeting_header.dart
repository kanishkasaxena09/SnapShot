import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.userName,
    this.notificationCount = 0,
  });

  final String userName;
  final int notificationCount;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get _date {
    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '$_greeting, $userName. $_date. $notificationCount notifications.',
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$_greeting, $userName 👋',
                  style: AppTypography.headlineSmall(
                    color: colorScheme.onSurface,
                  ),
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.05),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _date,
                  style: AppTypography.bodyMedium(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: AppSpacing.borderRadiusFull,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: colorScheme.onSurface,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$notificationCount',
                          style: AppTypography.labelSmall(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
        ],
      ),
      ),
    );
  }
}
