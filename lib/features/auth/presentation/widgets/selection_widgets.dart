import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SelectionChip extends StatelessWidget {

  const SelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.isLarge = false,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: isLarge ? 18 : 16,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
            ],
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        avatar: null,
        labelPadding: EdgeInsets.symmetric(
          horizontal: isLarge ? 12 : 8,
          vertical: isLarge ? 2 : 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isLarge ? 8 : 4,
          vertical: isLarge ? 4 : 2,
        ),
        labelStyle: AppTypography.labelLarge(
          color: isSelected
              ? colorScheme.onPrimary
              : colorScheme.onSurface,
        ),
        selectedColor: colorScheme.primary,
        backgroundColor: colorScheme.surfaceContainerHighest,
        side: BorderSide(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
      ),
    );
  }
}

class SelectionGrid extends StatelessWidget {

  const SelectionGrid({
    super.key,
    required this.options,
    required this.selected,
    required this.onToggle,
    this.maxSelection,
    this.icons,
  });
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final int? maxSelection;
  final Map<String, IconData>? icons;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: options.asMap().entries.map((entry) {
        final option = entry.value;
        final isSelected = selected.contains(option);
        final index = entry.key;

        return SelectionChip(
          label: option,
          isSelected: isSelected,
          icon: icons?[option],
          onTap: () {
            if (maxSelection != null && selected.length >= maxSelection!) {
              if (isSelected) {
                onToggle(option);
              }
              return;
            }
            onToggle(option);
          },
        ).animate().fadeIn(
              delay: Duration(milliseconds: 30 * index),
              duration: 300.ms,
            );
      }).toList(),
    );
  }
}

class SingleSelectionList extends StatelessWidget {

  const SingleSelectionList({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onSelected,
  });
  final List<SelectionOption> options;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: options.asMap().entries.map((entry) {
        final option = entry.value;
        final isSelected = option.id == selectedId;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surface,
              borderRadius: AppSpacing.borderRadiusMd,
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: 0.5),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              onTap: () => onSelected(option.id),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.xs,
              ),
              leading: option.icon != null
                  ? Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: AppSpacing.borderRadiusSm,
                      ),
                      child: Icon(
                        option.icon,
                        color: isSelected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                      ),
                    )
                  : null,
              title: Text(
                option.title,
                style: AppTypography.titleSmall(
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
              subtitle: option.subtitle != null
                  ? Text(
                      option.subtitle!,
                      style: AppTypography.bodySmall(
                        color: isSelected
                            ? colorScheme.onPrimaryContainer
                                .withValues(alpha: 0.7)
                            : colorScheme.onSurfaceVariant,
                      ),
                    )
                  : null,
              trailing: Radio<String>(
                value: option.id,
                groupValue: selectedId,
                onChanged: (value) {
                  if (value != null) onSelected(value);
                },
                activeColor: colorScheme.primary,
              ),
            ),
          ),
        ).animate().fadeIn(
              delay: Duration(milliseconds: 50 * entry.key),
              duration: 300.ms,
            );
      }).toList(),
    );
  }
}

class SelectionOption {

  const SelectionOption({
    required this.id,
    required this.title,
    this.subtitle,
    this.icon,
  });
  final String id;
  final String title;
  final String? subtitle;
  final IconData? icon;
}
