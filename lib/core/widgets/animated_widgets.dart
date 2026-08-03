import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListItem extends StatelessWidget {
  const AnimatedListItem({super.key, required this.index, required this.child, this.duration = 400});
  final int index;
  final Widget child;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: duration),
      child: SlideAnimation(
        verticalOffset: 50,
        child: FadeInAnimation(child: child),
      ),
    );
  }
}

class AnimatedGridItem extends StatelessWidget {
  const AnimatedGridItem({super.key, required this.index, required this.child, this.duration = 400});
  final int index;
  final Widget child;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: Duration(milliseconds: duration),
      columnCount: 2,
      child: ScaleAnimation(
        child: FadeInAnimation(child: child),
      ),
    );
  }
}

class AnimatedPageSwitch extends StatelessWidget {
  const AnimatedPageSwitch({super.key, required this.child, required this.animationKey});
  final Widget child;
  final String animationKey;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.02),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
      ),
      child: KeyedSubtree(key: ValueKey(animationKey), child: child),
    );
  }
}

class ScaleInWidget extends StatefulWidget {
  const ScaleInWidget({super.key, required this.child, this.delay = Duration.zero});
  final Widget child;
  final Duration delay;

  @override
  State<ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<ScaleInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _anim, child: widget.child);
  }
}

class SlideInFromRight extends StatefulWidget {
  const SlideInFromRight({super.key, required this.child, this.delay = Duration.zero});
  final Widget child;
  final Duration delay;

  @override
  State<SlideInFromRight> createState() => _SlideInFromRightState();
}

class _SlideInFromRightState extends State<SlideInFromRight> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _anim = Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _anim, child: widget.child);
  }
}
