import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';

class RecruiterContactScreen extends ConsumerStatefulWidget {
  const RecruiterContactScreen({super.key, required this.jobId});
  final String jobId;

  @override
  ConsumerState<RecruiterContactScreen> createState() => _RecruiterContactScreenState();
}

class _RecruiterContactScreenState extends ConsumerState<RecruiterContactScreen> {
  final _messageController = TextEditingController();
  String _selectedTopic = 'General Inquiry';
  bool _sent = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final job = ref.watch(jobDetailProvider(widget.jobId));

    if (job == null) {
      return Scaffold(appBar: AppBar(title: const Text('Contact')), body: const Center(child: Text('Not found')));
    }

    if (_sent) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(title: Text('Contact Recruiter', style: AppTypography.titleLarge()), leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_rounded, size: 80, color: AppColors.successLight),
              AppSpacing.gapLg,
              Text('Message Sent!', style: AppTypography.headlineSmall(color: AppColors.successLight)),
              AppSpacing.gapSm,
              Text('The recruiter will get back to you soon', style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.6))),
              AppSpacing.gapXl,
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLight, foregroundColor: Colors.white),
                child: Text('Back to Job', style: AppTypography.labelLarge(color: Colors.white)),
              ),
            ],
          ).animate().scale(duration: 300.ms),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Contact Recruiter', style: AppTypography.titleLarge()),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingBase,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecruiterInfo(context, job),
            AppSpacing.gapLg,
            _buildTopicSelector(colorScheme),
            AppSpacing.gapLg,
            Text('Message', style: AppTypography.titleSmall()),
            AppSpacing.gapSm,
            TextField(
              controller: _messageController,
              maxLines: 6,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Write your message to the recruiter...',
                hintStyle: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.4)),
                border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd),
                contentPadding: AppSpacing.paddingBase,
              ),
              style: AppTypography.bodyMedium(),
            ),
            AppSpacing.gapLg,
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _messageController.text.isEmpty ? null : () => setState(() => _sent = true),
                icon: const Icon(Icons.send_rounded, size: 18),
                label: Text('Send Message', style: AppTypography.labelLarge(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecruiterInfo(BuildContext context, Job job) {
    return Container(
      padding: AppSpacing.paddingBase,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.05),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.1),
            child: Text(job.company.logo, style: AppTypography.titleMedium(color: AppColors.primaryLight)),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${job.company.name} Recruiter', style: AppTypography.titleSmall()),
                Text(job.title, style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildTopicSelector(ColorScheme colorScheme) {
    final topics = ['General Inquiry', 'Application Status', 'Interview Prep', 'Role Details', 'Salary Discussion'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Topic', style: AppTypography.titleSmall()),
        AppSpacing.gapSm,
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: topics.map((t) {
            final selected = _selectedTopic == t;
            return ChoiceChip(
              label: Text(t),
              selected: selected,
              onSelected: (_) => setState(() => _selectedTopic = t),
              selectedColor: AppColors.primaryLight.withValues(alpha: 0.15),
              labelStyle: AppTypography.labelMedium(color: selected ? AppColors.primaryLight : colorScheme.onSurface),
              side: BorderSide(color: selected ? AppColors.primaryLight : colorScheme.outline.withValues(alpha: 0.3)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
