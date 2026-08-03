import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class LearningPlanCard extends StatelessWidget {
  const LearningPlanCard({super.key, required this.plan});

  final LearningPlan plan;

  @override
  Widget build(BuildContext context) {
    final completedSteps = plan.steps.where((s) => s.isCompleted).length;
    final progress = completedSteps / plan.steps.length;

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
              const Icon(Icons.map_rounded, color: Color(0xFF6C5CE7), size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Learning Plan', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${plan.title} • ${plan.totalDuration}',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Color(0xFF6C5CE7)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedSteps of ${plan.steps.length} steps completed',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 16),
          ...plan.steps.asMap().entries.map((entry) {
            return _buildStep(context, entry.key, entry.value);
          }),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, int index, LearningStep step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: step.isCompleted
                      ? const Color(0xFF00B894)
                      : const Color(0xFF6C5CE7).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: step.isCompleted
                      ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C5CE7),
                          ),
                        ),
                ),
              ),
              if (index < 4)
                Container(width: 2, height: 30, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    decoration: step.isCompleted ? TextDecoration.lineThrough : null,
                    color: step.isCompleted ? Colors.grey[500] : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(step.duration, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: step.skills.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(skill, style: const TextStyle(fontSize: 10, color: Color(0xFF6C5CE7))),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: step.resources.take(2).map((r) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.link_rounded, size: 10, color: Colors.grey[500]),
                        const SizedBox(width: 2),
                        Text(r, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
