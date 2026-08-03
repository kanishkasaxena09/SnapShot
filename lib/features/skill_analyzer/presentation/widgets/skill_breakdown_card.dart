import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class SkillBreakdownCard extends StatelessWidget {
  const SkillBreakdownCard({super.key, required this.categories});

  final List<SkillCategory> categories;

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
          Text('Skill Breakdown', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...categories.map((cat) => _buildCategorySection(context, cat)),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, SkillCategory category) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: category.type.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(category.type.icon, size: 14, color: category.type.color),
              ),
              const SizedBox(width: 8),
              Text(
                category.type.label,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Spacer(),
              Text(
                '${category.averageProficiency.round()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: category.type.color,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...category.skills.map((skill) => _buildSkillBar(context, skill, category.type.color)),
        ],
      ),
    );
  }

  Widget _buildSkillBar(BuildContext context, Skill skill, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  skill.name,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              Text(
                _getLevelLabel(skill.level),
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: skill.proficiency / 100,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  String _getLevelLabel(SkillLevel level) {
    switch (level) {
      case SkillLevel.expert:
        return 'Expert';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.beginner:
        return 'Beginner';
    }
  }
}
