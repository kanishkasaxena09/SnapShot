import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/ai_tools_entities.dart';

class PricingBadge extends StatelessWidget {

  const PricingBadge({
    super.key,
    required this.tier,
    this.displayText,
    this.fontSize,
  });
  final PricingTier tier;
  final String? displayText;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsForTier(tier);
    final label = displayText ?? _labelForTier(tier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: AppSpacing.borderRadiusXs,
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall(color: colors.$2).copyWith(fontSize: fontSize),
      ),
    );
  }

  (Color, Color) _colorsForTier(PricingTier tier) {
    switch (tier) {
      case PricingTier.free:
        return (const Color(0xFFD1FAE5), const Color(0xFF065F46));
      case PricingTier.freemium:
        return (const Color(0xFFDBEAFE), const Color(0xFF1E40AF));
      case PricingTier.paid:
        return (const Color(0xFFFED7AA), const Color(0xFF9A3412));
      case PricingTier.enterprise:
        return (const Color(0xFFE9D5FF), const Color(0xFF6B21A8));
      case PricingTier.contact:
        return (const Color(0xFFE5E7EB), const Color(0xFF374151));
    }
  }

  String _labelForTier(PricingTier tier) {
    switch (tier) {
      case PricingTier.free:
        return 'Free';
      case PricingTier.freemium:
        return 'Freemium';
      case PricingTier.paid:
        return 'Paid';
      case PricingTier.enterprise:
        return 'Enterprise';
      case PricingTier.contact:
        return 'Contact';
    }
  }
}
