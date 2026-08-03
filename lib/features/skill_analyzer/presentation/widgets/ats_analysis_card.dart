import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class ATSAnalysisCard extends StatelessWidget {
  const ATSAnalysisCard({super.key, required this.atsResult});

  final ATSResult atsResult;

  @override
  Widget build(BuildContext context) {
    final scoreColor = atsResult.score >= 80
        ? const Color(0xFF00B894)
        : atsResult.score >= 60
            ? const Color(0xFFFDCB6E)
            : const Color(0xFFE17055);

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
              const Icon(Icons.verified_rounded, color: Color(0xFF0984E3), size: 22),
              const SizedBox(width: 8),
              Text('ATS Analysis', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: atsResult.score / 100,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(scoreColor),
                    ),
                    Text(
                      '${atsResult.score}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: scoreColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      atsResult.score >= 80
                          ? 'Your resume is ATS-friendly'
                          : atsResult.score >= 60
                              ? 'Good, but room for improvement'
                              : 'Needs significant improvement',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${atsResult.keywordsFound.length} keywords found, ${atsResult.keywordsMissing.length} missing',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Score Breakdown', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 8),
          ...atsResult.breakdown.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(entry.key, style: const TextStyle(fontSize: 13)),
                      ),
                      Text('${entry.value}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: entry.value / 100,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(
                        entry.value >= 80 ? const Color(0xFF00B894) : const Color(0xFFFDCB6E),
                      ),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          Text('Keywords Found', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: const Color(0xFF00B894))),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: atsResult.keywordsFound.map((kw) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B894).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(kw, style: const TextStyle(fontSize: 11, color: Color(0xFF00B894), fontWeight: FontWeight.w500)),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Text('Missing Keywords', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: const Color(0xFFE17055))),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: atsResult.keywordsMissing.map((kw) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE17055).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(kw, style: const TextStyle(fontSize: 11, color: Color(0xFFE17055), fontWeight: FontWeight.w500)),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Text('Suggestions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.grey[700])),
          const SizedBox(height: 8),
          ...atsResult.suggestions.map((s) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_rounded, size: 14, color: Colors.amber[600]),
                  const SizedBox(width: 6),
                  Expanded(child: Text(s, style: TextStyle(fontSize: 12, color: Colors.grey[600]))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
