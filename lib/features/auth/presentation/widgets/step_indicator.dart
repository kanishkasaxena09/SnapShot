import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class StepIndicator extends StatelessWidget {

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.labels = const [],
    this.constLabels = const [],
  });
  final int currentStep;
  final int totalSteps;
  final List<String> labels;
  final List<String> constLabels;

  List<String> get _effectiveLabels => labels.isNotEmpty ? labels : constLabels;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final isActive = index <= currentStep;
            final isCurrent = index == currentStep;

            return Expanded(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: AppSpacing.borderRadiusFull,
                    ),
                  ),
                  if (_effectiveLabels.length > index) ...[
                    const SizedBox(height: 6),
                    Text(
                      _effectiveLabels[index],
                      style: AppTypography.labelSmall(
                        color: isCurrent
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
