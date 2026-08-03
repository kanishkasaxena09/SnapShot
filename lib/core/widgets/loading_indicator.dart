import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/asset_constants.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum LoadingIndicatorType { circular, dots, lottie }

class AppLoadingIndicator extends StatelessWidget {

  const AppLoadingIndicator({
    super.key,
    this.type = LoadingIndicatorType.circular,
    this.size,
    this.color,
    this.message,
  });
  final LoadingIndicatorType type;
  final double? size;
  final Color? color;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(),
          if (message != null) ...[
            AppSpacing.gapMd,
            Text(
              message!,
              style: AppTypography.bodyMedium(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return switch (type) {
      LoadingIndicatorType.circular => SizedBox(
          width: size ?? 40,
          height: size ?? 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: color,
          ),
        ),
      LoadingIndicatorType.dots => _DotsLoader(
          color: color,
          size: size ?? 8,
        ),
      LoadingIndicatorType.lottie => SizedBox(
          width: size ?? 120,
          height: size ?? 120,
          child: Lottie.asset(
            AssetConstants.loading,
            repeat: true,
          ),
        ),
    };
  }
}

class _DotsLoader extends StatefulWidget {

  const _DotsLoader({this.color, this.size = 8});
  final Color? color;
  final double size;

  @override
  State<_DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<_DotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final value = (_controller.value - delay).clamp(0.0, 1.0);
            final opacity = (value < 0.5
                    ? value * 2
                    : (1.0 - value) * 2)
                .clamp(0.3, 1.0);
            final scale = 0.5 + opacity * 0.5;

            return Transform.scale(
              scale: scale,
              child: Container(
                width: widget.size,
                height: widget.size,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: opacity),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Full-screen loading overlay.
class LoadingOverlay extends StatelessWidget {

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });
  final bool isLoading;
  final Widget child;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: AppLoadingIndicator(
              type: LoadingIndicatorType.circular,
              message: message,
            ),
          ),
      ],
    );
  }
}
