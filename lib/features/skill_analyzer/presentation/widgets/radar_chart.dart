import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class SkillRadarChart extends StatefulWidget {
  const SkillRadarChart({super.key, required this.categories});

  final List<SkillCategory> categories;

  @override
  State<SkillRadarChart> createState() => _SkillRadarChartState();
}

class _SkillRadarChartState extends State<SkillRadarChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Text('Skill Radar', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(280, 280),
                painter: RadarChartPainter(
                  categories: widget.categories,
                  animationValue: _animation.value,
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: widget.categories.map((cat) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: cat.type.color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text(cat.type.label, style: const TextStyle(fontSize: 12)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  RadarChartPainter({
    required this.categories,
    required this.animationValue,
  });

  final List<SkillCategory> categories;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 30;
    final count = categories.length;
    if (count < 3) return;

    _drawGrid(canvas, center, radius, count);

    _drawDataShape(canvas, center, radius, count);

    _drawDataPoints(canvas, center, radius, count);

    _drawLabels(canvas, center, radius, count);
  }

  void _drawGrid(Canvas canvas, Offset center, double radius, int count) {
    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int level = 1; level <= 4; level++) {
      final levelRadius = radius * level / 4;
      final path = Path();
      for (int i = 0; i < count; i++) {
        final angle = (2 * pi * i / count) - pi / 2;
        final point = Offset(
          center.dx + levelRadius * cos(angle),
          center.dy + levelRadius * sin(angle),
        );
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    for (int i = 0; i < count; i++) {
      final angle = (2 * pi * i / count) - pi / 2;
      final point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(center, point, gridPaint);
    }
  }

  void _drawDataShape(Canvas canvas, Offset center, double radius, int count) {
    final dataPaint = Paint()
      ..style = PaintingStyle.fill;

    final path = Path();
    for (int i = 0; i < count; i++) {
      final angle = (2 * pi * i / count) - pi / 2;
      final value = categories[i].averageProficiency / 100 * animationValue;
      final point = Offset(
        center.dx + radius * value * cos(angle),
        center.dy + radius * value * sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    dataPaint.color = const Color(0xFF6C5CE7).withOpacity(0.2);
    canvas.drawPath(path, dataPaint);

    dataPaint
      ..color = const Color(0xFF6C5CE7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(path, dataPaint);
  }

  void _drawDataPoints(Canvas canvas, Offset center, double radius, int count) {
    for (int i = 0; i < count; i++) {
      final angle = (2 * pi * i / count) - pi / 2;
      final value = categories[i].averageProficiency / 100 * animationValue;
      final point = Offset(
        center.dx + radius * value * cos(angle),
        center.dy + radius * value * sin(angle),
      );

      final pointPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(point, 5, pointPaint);

      final outerPaint = Paint()
        ..color = const Color(0xFF6C5CE7)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(point, 3.5, outerPaint);
    }
  }

  void _drawLabels(Canvas canvas, Offset center, double radius, int count) {
    final labelPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < count; i++) {
      final angle = (2 * pi * i / count) - pi / 2;
      final labelRadius = radius + 22;
      final point = Offset(
        center.dx + labelRadius * cos(angle),
        center.dy + labelRadius * sin(angle),
      );

      labelPainter.text = TextSpan(
        text: categories[i].type.label,
        style: TextStyle(
          color: categories[i].type.color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      );
      labelPainter.layout();

      final offset = Offset(
        point.dx - labelPainter.width / 2,
        point.dy - labelPainter.height / 2,
      );
      labelPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
