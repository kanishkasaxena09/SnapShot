import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _animation1 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.4, curve: Curves.easeInOut)),
    );
    _animation2 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeInOut)),
    );
    _animation3 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeInOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 4, bottom: 4, right: 60),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(_animation1),
                const SizedBox(width: 4),
                _buildDot(_animation2),
                const SizedBox(width: 4),
                _buildDot(_animation3),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
