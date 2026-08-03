import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ScoreUtils {
  ScoreUtils._();

  static Color colorForScore(double score) {
    if (score >= 80) return AppColors.successLight;
    if (score >= 60) return AppColors.accentOrange;
    return AppColors.errorLight;
  }

  static String labelForScore(double score) {
    if (score >= 90) return 'Exceptional';
    if (score >= 80) return 'Strong';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Developing';
    return 'Needs Improvement';
  }
}
