import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedAvatar extends StatelessWidget {

  const CachedAvatar({
    super.key,
    this.imageUrl,
    this.size = 40,
    this.initials,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });
  final String? imageUrl;
  final double size;
  final String? initials;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(size / 2);

    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: effectiveRadius,
        ),
        child: Center(
          child: Text(
            initials ?? '?',
            style: TextStyle(
              fontSize: size * 0.38,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: size,
        height: size,
        fit: fit,
        placeholder: (_, _) => _placeholder(context),
        errorWidget: (_, _, _) => _errorWidget(context),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Container(
        width: size,
        height: size,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }

  Widget _errorWidget(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Icon(
        Icons.person_rounded,
        size: size * 0.5,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class CachedNetworkImageWidget extends StatelessWidget {

  const CachedNetworkImageWidget({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final child = CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) =>
          placeholder ??
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            highlightColor: Theme.of(context).colorScheme.surface,
            child: Container(
              width: width,
              height: height,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
      errorWidget: (_, _, _) =>
          errorWidget ??
          Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.image_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }
}
