import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/skill_analyzer_entities.dart';
import '../providers/skill_analyzer_providers.dart';
import 'skill_results_screen.dart';

class SkillAnalyzerScreen extends ConsumerWidget {
  const SkillAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(skillAnalyzerProvider);
    final notifier = ref.read(skillAnalyzerProvider.notifier);
    final analysis = notifier.analysis;

    if (state == SkillAnalyzerState.completed && analysis != null) {
      return SkillResultsScreen(analysis: analysis);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Analyzer'),
        actions: [
          if (state != SkillAnalyzerState.initial)
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () => notifier.reset(),
            ),
        ],
      ),
      body: state == SkillAnalyzerState.importing || state == SkillAnalyzerState.analyzing
          ? _buildLoadingState(state)
          : _buildImportView(context, ref),
    );
  }

  Widget _buildLoadingState(SkillAnalyzerState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 24),
          Text(
            state == SkillAnalyzerState.importing ? 'Importing data...' : 'Analyzing skills...',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            state == SkillAnalyzerState.importing
                ? 'Connecting to your profiles'
                : 'Building your skill profile',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildImportView(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(skillAnalyzerProvider.notifier);
    final selected = notifier.selectedSources;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.analytics_rounded, size: 48, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Analyze Your Skills',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Import from your profiles to get a comprehensive skill analysis',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          const SizedBox(height: 32),
          Text('Import Sources', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _buildSourceCard(
            context,
            ref,
            source: ImportSource.resume,
            icon: Icons.description_rounded,
            title: 'Resume Upload',
            subtitle: 'Upload your resume (PDF/DOC)',
            color: const Color(0xFF6C5CE7),
            isSelected: selected.contains(ImportSource.resume),
          ),
          const SizedBox(height: 10),
          _buildSourceCard(
            context,
            ref,
            source: ImportSource.github,
            icon: Icons.code_rounded,
            title: 'GitHub Import',
            subtitle: 'Analyze repos, commits & languages',
            color: const Color(0xFF2D3436),
            isSelected: selected.contains(ImportSource.github),
          ),
          const SizedBox(height: 10),
          _buildSourceCard(
            context,
            ref,
            source: ImportSource.linkedin,
            icon: Icons.work_outline_rounded,
            title: 'LinkedIn Import',
            subtitle: 'Import experience & endorsements',
            color: const Color(0xFF0077B5),
            isSelected: selected.contains(ImportSource.linkedin),
          ),
          const SizedBox(height: 10),
          _buildSourceCard(
            context,
            ref,
            source: ImportSource.portfolio,
            icon: Icons.language_rounded,
            title: 'Portfolio Import',
            subtitle: 'Import from personal website',
            color: const Color(0xFF00B894),
            isSelected: selected.contains(ImportSource.portfolio),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: selected.isEmpty ? null : () => notifier.startAnalysis(),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'Analyze Skills (${selected.length} source${selected.length == 1 ? '' : 's'})',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSourceCard(
    BuildContext context,
    WidgetRef ref, {
    required ImportSource source,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isSelected,
  }) {
    final notifier = ref.read(skillAnalyzerProvider.notifier);

    return Material(
      color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => notifier.toggleSource(source),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? color : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: isSelected ? color : Colors.grey[400]!, width: 2),
                ),
                child: isSelected
                    ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
