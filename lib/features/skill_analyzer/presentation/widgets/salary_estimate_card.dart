import 'package:flutter/material.dart';

import '../../domain/entities/skill_analyzer_entities.dart';

class SalaryEstimateCard extends StatelessWidget {
  const SalaryEstimateCard({super.key, required this.estimate});

  final SalaryEstimate estimate;

  @override
  Widget build(BuildContext context) {
    final range = estimate.maxSalary - estimate.minSalary;
    final medianPosition = (estimate.medianSalary - estimate.minSalary) / range;

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
              const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF00B894), size: 22),
              const SizedBox(width: 8),
              Text('Salary Estimate', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            estimate.role,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on_rounded, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Flexible(child: Text(estimate.location, style: TextStyle(color: Colors.grey[600], fontSize: 13), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 12),
              Icon(Icons.work_history_rounded, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Flexible(child: Text(estimate.experienceLevel, style: TextStyle(color: Colors.grey[600], fontSize: 13), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${(estimate.minSalary / 1000).round()}K', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              Text('\$${(estimate.maxSalary / 1000).round()}K', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF00B894)),
                  minHeight: 8,
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width - 72) * medianPosition - 12,
                child: Container(
                  width: 24,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B894),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF00B894).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Median: \$${(estimate.medianSalary / 1000).round()}K/year',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00B894),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
