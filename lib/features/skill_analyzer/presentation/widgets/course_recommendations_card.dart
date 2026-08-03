import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class CourseRecommendationsCard extends StatelessWidget {
  const CourseRecommendationsCard({super.key, required this.courses});

  final List<CourseRecommendation> courses;

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
              const Icon(Icons.school_rounded, color: Color(0xFF6C5CE7), size: 22),
              const SizedBox(width: 8),
              Text('Recommended Courses', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return _buildCourseCard(context, courses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, CourseRecommendation course) {
    final difficultyColor = {
      'Beginner': const Color(0xFF00B894),
      'Intermediate': const Color(0xFFFDCB6E),
      'Advanced': const Color(0xFFE17055),
    }[course.difficulty] ?? Colors.grey;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: difficultyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              course.difficulty,
              style: TextStyle(fontSize: 10, color: difficultyColor, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            course.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            course.provider,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.star_rounded, size: 14, color: Colors.amber[600]),
              const SizedBox(width: 2),
              Text('${course.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              Icon(Icons.access_time_rounded, size: 12, color: Colors.grey[500]),
              const SizedBox(width: 2),
              Text(course.duration, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Target: ${course.skillTarget}',
            style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
