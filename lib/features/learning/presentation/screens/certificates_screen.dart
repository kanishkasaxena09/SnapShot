import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/learning_providers.dart';

class CertificatesScreen extends ConsumerWidget {
  const CertificatesScreen({super.key});

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certificates = ref.watch(certificatesProvider);
    final verifiedCount = certificates.where((c) => c.isVerified).length;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Certificates', style: AppTypography.headlineLarge()),
      ),
      body: certificates.isEmpty
          ? Center(
              child: Text(
                'No certificates earned yet',
                style: AppTypography.bodyMedium(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.base,
                    AppSpacing.sm,
                    AppSpacing.base,
                    0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.card_membership_outlined,
                                size: AppSpacing.iconMd,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${certificates.length}',
                                    style: AppTypography.titleMedium(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    'Total',
                                    style: AppTypography.labelSmall(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.successLight.withOpacity(0.1),
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.verified_outlined,
                                size: AppSpacing.iconMd,
                                color: AppColors.successLight,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$verifiedCount',
                                    style: AppTypography.titleMedium(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    'Verified',
                                    style: AppTypography.labelSmall(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.base),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.sm,
                    ),
                    itemCount: certificates.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final cert = certificates[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: AppSpacing.borderRadiusMd,
                          border: Border.all(
                            color: colorScheme.outlineVariant,
                            width: 1.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 6,
                              decoration: BoxDecoration(
                                color: cert.color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(AppSpacing.radiusMd),
                                ),
                              ),
                            ),
                            CustomPaint(
                              painter: _DashedBorderPainter(
                                color: cert.color.withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: AppSpacing.paddingBase,
                                child: Column(
                                  children: [
                                    Text(
                                      'CERTIFICATE OF COMPLETION',
                                      style: AppTypography.labelSmall(
                                        color: cert.color,
                                      )..copyWith(
                                          letterSpacing: 2,
                                        ),
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Text(
                                      cert.title,
                                      textAlign: TextAlign.center,
                                      style: AppTypography.headlineSmall(
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Text(
                                      'Awarded to',
                                      style: AppTypography.bodySmall(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.xxs),
                                    Text(
                                      'Snapshot User',
                                      style: AppTypography.titleMedium(
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Issued by',
                                              style: AppTypography.bodySmall(
                                                color: colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                            const SizedBox(height: AppSpacing.xxs),
                                            Text(
                                              cert.issuer,
                                              style: AppTypography.labelLarge(
                                                color: colorScheme.onSurface,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Issued',
                                                style: AppTypography.bodySmall(
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ),
                                              const SizedBox(height: AppSpacing.xxs),
                                              Text(
                                                _formatDate(cert.issuedDate),
                                                style: AppTypography.labelMedium(
                                                  color: colorScheme.onSurface,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 30,
                                          color: colorScheme.outlineVariant,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Expires',
                                                style: AppTypography.bodySmall(
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ),
                                              const SizedBox(height: AppSpacing.xxs),
                                              Text(
                                                _formatDate(cert.expiryDate),
                                                style: AppTypography.labelMedium(
                                                  color: colorScheme.onSurface,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: AppSpacing.xxs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.surfaceContainerHighest,
                                        borderRadius: AppSpacing.borderRadiusSm,
                                      ),
                                      child: Text(
                                        'ID: ${cert.credentialId}',
                                        style: AppTypography.code(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    if (cert.isVerified)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.sm,
                                          vertical: AppSpacing.xxs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.successLight.withOpacity(0.1),
                                          borderRadius: AppSpacing.borderRadiusFull,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.check_circle_rounded,
                                              size: AppSpacing.iconSm,
                                              color: AppColors.successLight,
                                            ),
                                            const SizedBox(width: AppSpacing.xs),
                                            Text(
                                              'Verified',
                                              style: AppTypography.labelSmall(
                                                color: AppColors.successLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(height: AppSpacing.md),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: colorScheme.primary,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: AppSpacing.borderRadiusMd,
                                              ),
                                              minimumSize: const Size(
                                                0,
                                                AppSpacing.buttonHeightMd,
                                              ),
                                            ),
                                            child: Text(
                                              'View',
                                              style: AppTypography.labelMedium(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: AppSpacing.borderRadiusMd,
                                              ),
                                              minimumSize: const Size(
                                                0,
                                                AppSpacing.buttonHeightMd,
                                              ),
                                            ),
                                            child: Text(
                                              'Share',
                                              style: AppTypography.labelMedium(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {

  const _DashedBorderPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 4.0;
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final start = metric.getTangentForOffset(distance)!.position;
        final end = distance + dashWidth < metric.length
            ? metric.getTangentForOffset(distance + dashWidth)!.position
            : metric.getTangentForOffset(metric.length)!.position;
        canvas.drawLine(start, end, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
