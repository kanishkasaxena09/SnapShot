import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  const ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.strokeWidth != strokeWidth;
}

class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final Widget? child;
  final bool showPercentage;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 60,
    this.strokeWidth = 6,
    this.color,
    this.backgroundColor,
    this.child,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primaryLight;
    final effectiveBg = backgroundColor ?? AppColors.surfaceVariantLight;
    final clampedProgress = progress.clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: ProgressRingPainter(
          progress: clampedProgress,
          color: effectiveColor,
          backgroundColor: effectiveBg,
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: child ??
              (showPercentage
                  ? Text(
                      '${(clampedProgress * 100).round()}%',
                      style: AppTypography.labelMedium(
                        color: effectiveColor,
                      ),
                    )
                  : null),
        ),
      ),
    );
  }
}
