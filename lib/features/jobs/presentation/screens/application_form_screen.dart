import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/job_entities.dart';
import '../providers/job_providers.dart';

class ApplicationFormScreen extends ConsumerStatefulWidget {
  const ApplicationFormScreen({super.key, required this.jobId});
  final String jobId;

  @override
  ConsumerState<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends ConsumerState<ApplicationFormScreen> {
  final _nameCtrl = TextEditingController(text: 'Alex Johnson');
  final _emailCtrl = TextEditingController(text: 'alex@example.com');
  final _phoneCtrl = TextEditingController(text: '+1 (555) 123-4567');
  final _coverLetterCtrl = TextEditingController();
  bool _resumeAttached = true;
  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _coverLetterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final job = ref.watch(jobDetailProvider(widget.jobId));

    if (job == null) {
      return Scaffold(appBar: AppBar(title: const Text('Apply')), body: const Center(child: Text('Not found')));
    }

    if (_submitted) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(title: Text('Apply', style: AppTypography.titleLarge()), leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded))),
        body: Center(
          child: Padding(
            padding: AppSpacing.paddingBase,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_rounded, size: 80, color: AppColors.successLight),
                AppSpacing.gapLg,
                Text('Application Submitted!', style: AppTypography.headlineSmall(color: AppColors.successLight)),
                AppSpacing.gapSm,
                Text(
                  'Your application for ${job.title} at ${job.company.name} has been submitted successfully.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                ),
                AppSpacing.gapXl,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/jobs'),
                        child: Text('Browse Jobs'),
                      ),
                    ),
                    AppSpacing.hGapMd,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.push('/jobs/applications'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryLight, foregroundColor: Colors.white),
                        child: Text('View Applications', style: AppTypography.labelLarge(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Apply', style: AppTypography.titleLarge()),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingBase,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobSummary(context, job),
            AppSpacing.gapLg,
            _buildSection('Personal Information'),
            AppSpacing.gapMd,
            _buildField('Full Name', _nameCtrl),
            AppSpacing.gapMd,
            _buildField('Email', _emailCtrl, keyboardType: TextInputType.emailAddress),
            AppSpacing.gapMd,
            _buildField('Phone', _phoneCtrl, keyboardType: TextInputType.phone),
            AppSpacing.gapLg,
            _buildSection('Resume'),
            AppSpacing.gapMd,
            _buildResumeAttachment(context),
            AppSpacing.gapLg,
            _buildSection('Cover Letter (optional)'),
            AppSpacing.gapMd,
            TextField(
              controller: _coverLetterCtrl,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Why are you a good fit for this role?',
                hintStyle: AppTypography.bodyMedium(color: colorScheme.onSurface.withValues(alpha: 0.4)),
                border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd),
                contentPadding: AppSpacing.paddingBase,
              ),
              style: AppTypography.bodyMedium(),
            ),
            AppSpacing.gapXl,
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _canSubmit() ? _submitApplication : null,
                icon: const Icon(Icons.send_rounded, size: 20),
                label: Text('Submit Application', style: AppTypography.labelLarge(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: colorScheme.surfaceContainerHighest,
                  disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildJobSummary(BuildContext context, Job job) {
    return Container(
      padding: AppSpacing.paddingBase,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.05),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm),
            child: Center(child: Text(job.company.logo, style: AppTypography.titleMedium(color: AppColors.primaryLight))),
          ),
          AppSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title, style: AppTypography.titleSmall()),
                Text('${job.company.name} • ${job.location}', style: AppTypography.bodySmall(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
                Text(job.salaryRange, style: AppTypography.labelMedium(color: AppColors.secondaryLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Text(title, style: AppTypography.titleMedium());
  }

  Widget _buildField(String label, TextEditingController ctrl, {TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd),
        contentPadding: AppSpacing.paddingBase,
      ),
      style: AppTypography.bodyMedium(),
    );
  }

  Widget _buildResumeAttachment(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _resumeAttached = !_resumeAttached),
      child: Container(
        padding: AppSpacing.paddingBase,
        decoration: BoxDecoration(
          color: _resumeAttached ? AppColors.successLight.withValues(alpha: 0.05) : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: _resumeAttached ? AppColors.successLight.withValues(alpha: 0.3) : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(
              _resumeAttached ? Icons.check_circle_rounded : Icons.upload_file_rounded,
              color: _resumeAttached ? AppColors.successLight : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_resumeAttached ? 'Resume Attached' : 'Attach Resume', style: AppTypography.titleSmall()),
                  if (_resumeAttached)
                    Text('alex_johnson_resume.pdf', style: AppTypography.bodySmall(color: AppColors.successLight)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canSubmit() {
    return _nameCtrl.text.isNotEmpty && _emailCtrl.text.isNotEmpty && _resumeAttached;
  }

  void _submitApplication() {
    final job = ref.read(jobDetailProvider(widget.jobId));
    if (job != null) {
      ref.read(applicationsProvider.notifier).apply(job);
      setState(() => _submitted = true);
    }
  }
}
