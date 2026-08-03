import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // --- Primary ---
  static const Color primaryLight = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF8B83FF);
  static const Color primaryContainerLight = Color(0xFFE8E6FF);
  static const Color primaryContainerDark = Color(0xFF2D2B55);

  // --- Secondary ---
  static const Color secondaryLight = Color(0xFF00D9A6);
  static const Color secondaryDark = Color(0xFF00E6B8);
  static const Color secondaryContainerLight = Color(0xFFD4F7ED);
  static const Color secondaryContainerDark = Color(0xFF1A3D34);

  // --- Tertiary ---
  static const Color tertiaryLight = Color(0xFFFF6B6B);
  static const Color tertiaryDark = Color(0xFFFF8A8A);
  static const Color tertiaryContainerLight = Color(0xFFFFE0E0);
  static const Color tertiaryContainerDark = Color(0xFF3D2222);

  // --- Accent ---
  static const Color accentBlue = Color(0xFF4A9EFF);
  static const Color accentOrange = Color(0xFFFF9F43);
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentCyan = Color(0xFF00D2D3);
  static const Color accentYellow = Color(0xFFFFD93D);
  static const Color accentLime = Color(0xFFA8E06C);

  // --- Semantic ---
  static const Color successLight = Color(0xFF00C853);
  static const Color successDark = Color(0xFF69F0AE);
  static const Color warningLight = Color(0xFFFFAB00);
  static const Color warningDark = Color(0xFFFFD740);
  static const Color errorLight = Color(0xFFFF1744);
  static const Color errorDark = Color(0xFFFF5252);
  static const Color infoLight = Color(0xFF2196F3);
  static const Color infoDark = Color(0xFF64B5F6);

  // --- Neutral (Light) ---
  static const Color backgroundLight = Color(0xFFF8F9FC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF1F3F8);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color scaffoldLight = Color(0xFFF5F6FA);

  // --- Neutral (Dark) ---
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color surfaceDark = Color(0xFF161B22);
  static const Color surfaceVariantDark = Color(0xFF21262D);
  static const Color cardDark = Color(0xFF1C2128);
  static const Color scaffoldDark = Color(0xFF0D1117);

  // --- Text (Light) ---
  static const Color textPrimaryLight = Color(0xFF1A1D26);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);
  static const Color textInverseLight = Color(0xFFFFFFFF);
  static const Color textLinkLight = Color(0xFF6C63FF);

  // --- Text (Dark) ---
  static const Color textPrimaryDark = Color(0xFFF0F6FC);
  static const Color textSecondaryDark = Color(0xFF8B949E);
  static const Color textTertiaryDark = Color(0xFF6E7681);
  static const Color textInverseDark = Color(0xFF0D1117);
  static const Color textLinkDark = Color(0xFF8B83FF);

  // --- Border ---
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF30363D);
  static const Color borderFocusLight = Color(0xFF6C63FF);
  static const Color borderFocusDark = Color(0xFF8B83FF);

  // --- Divider ---
  static const Color dividerLight = Color(0xFFE5E7EB);
  static const Color dividerDark = Color(0xFF21262D);

  // --- Shadow ---
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x1A000000);

  // --- Overlay ---
  static const Color overlayLight = Color(0x80000000);
  static const Color overlayDark = Color(0x80000000);

  // --- Gradient Presets ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, Color(0xFF8B83FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF00D9A6), Color(0xFF00B4D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF1A1D26), Color(0xFF0D1117)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentPink, primaryLight, accentBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
