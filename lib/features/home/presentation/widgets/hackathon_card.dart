import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/home_models.dart';
import 'section_header.dart';

class HackathonSection extends StatelessWidget {
  const HackathonSection({super.key, required this.hackathons});

  final List<Hackathon> hackathons;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Upcoming Hackathons', trailing: 'See All'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            scrollDirection: Axis.horizontal,
            itemCount: hackathons.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return HackathonCard(hackathon: hackathons[index])
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 100 * index),
                    duration: 400.ms,
                  )
                  .slideX(begin: 0.08);
            },
          ),
        ),
      ],
    );
  }
}

class HackathonCard extends StatelessWidget {
  const HackathonCard({super.key, required this.hackathon});

  final Hackathon hackathon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: hackathon.color.withValues(alpha: 0.06),
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: hackathon.color.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: hackathon.color.withValues(alpha: 0.15),
                    borderRadius: AppSpacing.borderRadiusSm,
                  ),
                  child: Icon(
                    Icons.emoji_events_outlined,
                    color: hackathon.color,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: hackathon.registrationOpen
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: AppSpacing.borderRadiusXs,
                  ),
                  child: Text(
                    hackathon.registrationOpen ? 'Open' : 'Soon',
                    style: AppTypography.labelSmall(
                      color: hackathon.registrationOpen
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              hackathon.name,
              style: AppTypography.titleSmall(
                color: colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              hackathon.description,
              style: AppTypography.bodySmall(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 12, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 2),
                Text(
                  hackathon.startDate,
                  style: AppTypography.labelSmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(Icons.attach_money_rounded, size: 14, color: hackathon.color),
                Text(
                  hackathon.prizePool,
                  style: AppTypography.labelMedium(
                    color: hackathon.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Icon(Icons.people_outline_rounded, size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 2),
                Text(
                  '${hackathon.participants} participants',
                  style: AppTypography.labelSmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(
                  hackathon.isOnline
                      ? Icons.wifi_rounded
                      : Icons.location_on_outlined,
                  size: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 2),
                Text(
                  hackathon.isOnline ? 'Online' : 'In-Person',
                  style: AppTypography.labelSmall(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
