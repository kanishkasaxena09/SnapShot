import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/score_utils.dart';
import '../../domain/entities/skill_analyzer_entities.dart';
import '../widgets/radar_chart.dart';
import '../widgets/circular_chart.dart';
import '../widgets/skill_breakdown_card.dart';
import '../widgets/missing_skills_card.dart';
import '../widgets/course_recommendations_card.dart';
import '../widgets/career_suggestions_card.dart';
import '../widgets/salary_estimate_card.dart';
import '../widgets/learning_plan_card.dart';
import '../widgets/ats_analysis_card.dart';

class SkillResultsScreen extends StatelessWidget {
  const SkillResultsScreen({super.key, required this.analysis});

  final SkillAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF export coming soon!')),
              );
            },
            tooltip: 'Export PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallScore(context),
            const SizedBox(height: 20),
            SkillRadarChart(categories: analysis.categories),
            const SizedBox(height: 20),
            SkillBreakdownCard(categories: analysis.categories),
            const SizedBox(height: 16),
            ATSAnalysisCard(atsResult: analysis.atsResult),
            const SizedBox(height: 16),
            SkillCircularCharts(categories: analysis.categories),
            const SizedBox(height: 16),
            MissingSkillsCard(missingSkills: analysis.missingSkills),
            const SizedBox(height: 16),
            CourseRecommendationsCard(courses: analysis.courseRecommendations),
            const SizedBox(height: 16),
            CareerSuggestionsCard(suggestions: analysis.careerSuggestions),
            const SizedBox(height: 16),
            SalaryEstimateCard(estimate: analysis.salaryEstimate),
            const SizedBox(height: 16),
            LearningPlanCard(plan: analysis.learningPlan),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallScore(BuildContext context) {
    final score = analysis.overallScore;
    final color = ScoreUtils.colorForScore(score.toDouble());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(color),
                  strokeCap: BorderRadius.circular is BorderRadius ? StrokeCap.round : StrokeCap.round,
                ),
                Text(
                  '$score',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Skill Score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _getScoreLabel(score),
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${analysis.sources.length} source${analysis.sources.length == 1 ? '' : 's'} analyzed',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreLabel(int score) {
    if (score >= 90) return 'Exceptional';
    if (score >= 80) return 'Strong';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Developing';
    return 'Needs Improvement';
  }
}
