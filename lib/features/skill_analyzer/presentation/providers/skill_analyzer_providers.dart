import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/skill_analyzer_local_datasource.dart';
import '../../domain/entities/skill_analyzer_entities.dart';

final skillAnalyzerDataSourceProvider = Provider<SkillAnalyzerLocalDataSource>((ref) {
  return SkillAnalyzerLocalDataSource();
});

enum SkillAnalyzerState { initial, importing, analyzing, completed, error }

class SkillAnalyzerNotifier extends StateNotifier<SkillAnalyzerState> {
  SkillAnalyzerNotifier(this._ref) : super(SkillAnalyzerState.initial);

  final Ref _ref;
  SkillAnalysis? _analysis;
  final Set<ImportSource> _selectedSources = {};
  bool _isImporting = false;

  SkillAnalysis? get analysis => _analysis;
  Set<ImportSource> get selectedSources => _selectedSources;
  bool get isImporting => _isImporting;

  void toggleSource(ImportSource source) {
    if (_selectedSources.contains(source)) {
      _selectedSources.remove(source);
    } else {
      _selectedSources.add(source);
    }
    state = state;
  }

  Future<void> startAnalysis() async {
    if (_selectedSources.isEmpty) return;

    _isImporting = true;
    state = SkillAnalyzerState.importing;
    await Future.delayed(const Duration(seconds: 2));
    _isImporting = false;

    state = SkillAnalyzerState.analyzing;
    await Future.delayed(const Duration(seconds: 1));

    final dataSource = _ref.read(skillAnalyzerDataSourceProvider);
    _analysis = dataSource.analyzeFromSources(_selectedSources.toList());
    state = SkillAnalyzerState.completed;
  }

  void reset() {
    _analysis = null;
    _selectedSources.clear();
    state = SkillAnalyzerState.initial;
  }
}

final skillAnalyzerProvider = StateNotifierProvider<SkillAnalyzerNotifier, SkillAnalyzerState>((ref) {
  return SkillAnalyzerNotifier(ref);
});
