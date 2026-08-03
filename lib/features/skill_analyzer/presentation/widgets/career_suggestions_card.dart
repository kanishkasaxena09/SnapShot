import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class CareerSuggestionsCard extends StatelessWidget {
  const CareerSuggestionsCard({super.key, required this.suggestions});

  final List<CareerSuggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up_rounded, color: Color(0xFF00B894), size: 22),
              const SizedBox(width: 8),
              Text('Career Suggestions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ...suggestions.map((s) => _buildCareerCard(context, s)),
        ],
      ),
    );
  }

  Widget _buildCareerCard(BuildContext context, CareerSuggestion career) {
    final matchColor = career.matchPercentage >= 80
        ? const Color(0xFF00B894)
        : career.matchPercentage >= 60
            ? const Color(0xFFFDCB6E)
            : const Color(0xFFE17055);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(career.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: matchColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${career.matchPercentage}% match',
                  style: TextStyle(fontSize: 12, color: matchColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(career.description, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.attach_money_rounded, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Flexible(child: Text(career.salaryRange, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 16),
              Icon(Icons.show_chart_rounded, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Flexible(child: Text(career.growthRate, style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...career.yourMatchingSkills.map((s) => _buildSkillChip(s, const Color(0xFF00B894), true)),
              ...career.requiredSkills
                  .where((s) => !career.yourMatchingSkills.contains(s))
                  .map((s) => _buildSkillChip(s, Colors.grey, false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String name, Color color, bool matched) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (matched) ...[
            Icon(Icons.check_circle_rounded, size: 10, color: color),
            const SizedBox(width: 3),
          ],
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              color: matched ? color : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
