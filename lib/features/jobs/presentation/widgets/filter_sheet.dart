import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';

class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({super.key});

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  late List<JobType> _types;
  late List<JobExperience> _experiences;
  late List<JobCategory> _categories;
  late bool _remoteOnly;
  String? _sortBy;
  double? _minSalary;
  double? _maxSalary;

  @override
  void initState() {
    super.initState();
    final current = ref.read(jobFilterProvider);
    _types = List.from(current.types);
    _experiences = List.from(current.experiences);
    _categories = List.from(current.categories);
    _remoteOnly = current.remoteOnly;
    _sortBy = current.sortBy;
    _minSalary = current.minSalary;
    _maxSalary = current.maxSalary;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: AppSpacing.paddingBase,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: AppSpacing.borderRadiusFull,
              ),
            ),
          ),
          AppSpacing.gapMd,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: AppTypography.titleLarge()),
              TextButton(
                onPressed: () {
                  setState(() {
                    _types.clear();
                    _experiences.clear();
                    _categories.clear();
                    _remoteOnly = false;
                    _sortBy = null;
                    _minSalary = null;
                    _maxSalary = null;
                  });
                },
                child: Text('Clear All', style: AppTypography.bodyMedium(color: AppColors.primaryLight)),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('Sort By', _buildSortChips(colorScheme)),
                  _buildSection('Job Type', _buildTypeChips(colorScheme)),
                  _buildSection('Experience Level', _buildExperienceChips(colorScheme)),
                  _buildSection('Category', _buildCategoryChips(colorScheme)),
                  _buildSection('Remote Only', _buildRemoteSwitch(colorScheme)),
                  _buildSection('Salary Range', _buildSalarySlider(colorScheme)),
                ],
              ),
            ),
          ),
          AppSpacing.gapMd,
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
              ),
              child: Text('Apply Filters', style: AppTypography.labelLarge(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.titleSmall()),
          AppSpacing.gapSm,
          child,
        ],
      ),
    );
  }

  Widget _buildSortChips(ColorScheme colorScheme) {
    final options = [
      ('recent', 'Most Recent'),
      ('salary_high', 'Highest Salary'),
      ('salary_low', 'Lowest Salary'),
      ('match', 'Best Match'),
    ];
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: options.map((o) {
        final selected = _sortBy == o.$1;
        return ChoiceChip(
          label: Text(o.$2),
          selected: selected,
          onSelected: (v) => setState(() => _sortBy = v ? o.$1 : null),
          selectedColor: AppColors.primaryLight.withValues(alpha: 0.15),
          labelStyle: AppTypography.labelMedium(color: selected ? AppColors.primaryLight : colorScheme.onSurface),
          side: BorderSide(color: selected ? AppColors.primaryLight : colorScheme.outline.withValues(alpha: 0.3)),
        );
      }).toList(),
    );
  }

  Widget _buildTypeChips(ColorScheme colorScheme) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: JobType.values.map((t) {
        final selected = _types.contains(t);
        final label = t.name[0].toUpperCase() + t.name.substring(1).replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}');
        return ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: (v) => setState(() => v ? _types.add(t) : _types.remove(t)),
          selectedColor: AppColors.primaryLight.withValues(alpha: 0.15),
          labelStyle: AppTypography.labelMedium(color: selected ? AppColors.primaryLight : colorScheme.onSurface),
          side: BorderSide(color: selected ? AppColors.primaryLight : colorScheme.outline.withValues(alpha: 0.3)),
        );
      }).toList(),
    );
  }

  Widget _buildExperienceChips(ColorScheme colorScheme) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: JobExperience.values.map((e) {
        final selected = _experiences.contains(e);
        final label = e.name[0].toUpperCase() + e.name.substring(1).replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}');
        return ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: (v) => setState(() => v ? _experiences.add(e) : _experiences.remove(e)),
          selectedColor: AppColors.primaryLight.withValues(alpha: 0.15),
          labelStyle: AppTypography.labelMedium(color: selected ? AppColors.primaryLight : colorScheme.onSurface),
          side: BorderSide(color: selected ? AppColors.primaryLight : colorScheme.outline.withValues(alpha: 0.3)),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryChips(ColorScheme colorScheme) {
    final labels = {
      JobCategory.softwareEngineering: 'Software Eng',
      JobCategory.dataScience: 'Data Science',
      JobCategory.design: 'Design',
      JobCategory.product: 'Product',
      JobCategory.marketing: 'Marketing',
      JobCategory.devops: 'DevOps',
      JobCategory.cybersecurity: 'Security',
      JobCategory.aiMl: 'AI/ML',
      JobCategory.mobile: 'Mobile',
      JobCategory.finance: 'Finance',
    };
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: JobCategory.values.map((c) {
        final selected = _categories.contains(c);
        return ChoiceChip(
          label: Text(labels[c] ?? c.name),
          selected: selected,
          onSelected: (v) => setState(() => v ? _categories.add(c) : _categories.remove(c)),
          selectedColor: AppColors.primaryLight.withValues(alpha: 0.15),
          labelStyle: AppTypography.labelMedium(color: selected ? AppColors.primaryLight : colorScheme.onSurface),
          side: BorderSide(color: selected ? AppColors.primaryLight : colorScheme.outline.withValues(alpha: 0.3)),
        );
      }).toList(),
    );
  }

  Widget _buildRemoteSwitch(ColorScheme colorScheme) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('Remote jobs only', style: AppTypography.bodyMedium()),
      value: _remoteOnly,
      onChanged: (v) => setState(() => _remoteOnly = v),
      activeColor: AppColors.primaryLight,
    );
  }

  Widget _buildSalarySlider(ColorScheme colorScheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_minSalary != null ? '\$${(_minSalary! / 1000).toStringAsFixed(0)}k' : 'No min', style: AppTypography.bodySmall()),
            Text(_maxSalary != null ? '\$${(_maxSalary! / 1000).toStringAsFixed(0)}k' : 'No max', style: AppTypography.bodySmall()),
          ],
        ),
        RangeSlider(
          min: 0,
          max: 350000,
          divisions: 35,
          values: RangeValues(_minSalary ?? 0, _maxSalary ?? 350000),
          onChanged: (v) => setState(() {
            _minSalary = v.start > 0 ? v.start : null;
            _maxSalary = v.end < 350000 ? v.end : null;
          }),
          activeColor: AppColors.primaryLight,
        ),
      ],
    );
  }

  void _applyFilters() {
    ref.read(jobFilterProvider.notifier).state = JobFilter(
      types: _types,
      experiences: _experiences,
      categories: _categories,
      remoteOnly: _remoteOnly,
      sortBy: _sortBy,
      minSalary: _minSalary,
      maxSalary: _maxSalary,
    );
    Navigator.of(context).pop();
  }
}
