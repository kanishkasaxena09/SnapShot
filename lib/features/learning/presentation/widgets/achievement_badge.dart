import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/learning_entities.dart';

class _RarityBorderPainter extends CustomPainter {
  final AchievementRarity rarity;
  final Color color;
  final bool isUnlocked;

  _RarityBorderPainter({
    required this.rarity,
    required this.color,
    required this.isUnlocked,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    switch (rarity) {
      case AchievementRarity.common:
        break;
      case AchievementRarity.uncommon:
        final paint = Paint()
          ..color = AppColors.successLight
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(center, radius - 1, paint);
        break;
      case AchievementRarity.rare:
        final outerPaint = Paint()
          ..color = AppColors.accentBlue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(center, radius - 1, outerPaint);
        final innerPaint = Paint()
          ..color = AppColors.accentBlue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawCircle(center, radius - 4, innerPaint);
        break;
      case AchievementRarity.epic:
        final gradientPaint = Paint()
          ..shader = SweepGradient(
            colors: const [
              Color(0xFF9B59B6),
              Color(0xFF8E44AD),
              Color(0xFF6C3483),
              Color(0xFF9B59B6),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
        canvas.drawCircle(center, radius - 1, gradientPaint);
        break;
      case AchievementRarity.legendary:
        final goldPaint = Paint()
          ..shader = SweepGradient(
            colors: const [
              AppColors.accentYellow,
              Color(0xFFFFD700),
              Color(0xFFFFA500),
              AppColors.accentYellow,
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
        canvas.drawCircle(center, radius - 1, goldPaint);

        final starPaint = Paint()..color = AppColors.accentYellow;
        for (var i = 0; i < 5; i++) {
          final angle = (i * 2 * pi / 5) - pi / 2;
          final starOffset = Offset(
            center.dx + (radius + 4) * cos(angle),
            center.dy + (radius + 4) * sin(angle),
          );
          canvas.drawCircle(starOffset, 2, starPaint);
        }
        break;
    }
  }

  @override
  bool shouldRepaint(_RarityBorderPainter oldDelegate) =>
      oldDelegate.rarity != rarity ||
      oldDelegate.color != color ||
      oldDelegate.isUnlocked != isUnlocked;
}

class AchievementBadge extends StatelessWidget {
  final AchievementRarity rarity;
  final bool isUnlocked;
  final double size;
  final IconData? icon;
  final Color? color;

  const AchievementBadge({
    super.key,
    required this.rarity,
    this.isUnlocked = false,
    this.size = 80,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primaryLight;
    final iconSize = size * 0.4;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RarityBorderPainter(
          rarity: rarity,
          color: effectiveColor,
          isUnlocked: isUnlocked,
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isUnlocked ? effectiveColor : AppColors.surfaceVariantLight,
            boxShadow: isUnlocked
                ? [
                    BoxShadow(
                      color: effectiveColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: isUnlocked
              ? Icon(
                  icon ?? Icons.emoji_events,
                  size: iconSize,
                  color: Colors.white,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    if (rarity == AchievementRarity.legendary ||
                        rarity == AchievementRarity.epic)
                      Opacity(
                        opacity: 0.15,
                        child: Icon(
                          icon ?? Icons.emoji_events,
                          size: iconSize,
                          color: effectiveColor,
                        ),
                      ),
                    Icon(
                      Icons.lock,
                      size: iconSize * 0.6,
                      color: AppColors.textTertiaryLight,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
