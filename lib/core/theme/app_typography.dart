import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  // --- Display ---
  static TextStyle displayLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        height: 1.12,
        color: color,
      );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        height: 1.16,
        color: color,
      );

  static TextStyle displaySmall({Color? color}) => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.22,
        color: color,
      );

  // --- Headline ---
  static TextStyle headlineLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.25,
        color: color,
      );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
        color: color,
      );

  static TextStyle headlineSmall({Color? color}) => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
        color: color,
      );

  // --- Title ---
  static TextStyle titleLarge({Color? color}) => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.27,
        color: color,
      );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
        color: color,
      );

  static TextStyle titleSmall({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
        color: color,
      );

  // --- Body ---
  static TextStyle bodyLarge({Color? color, FontWeight? fontWeight}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: color,
      );

  static TextStyle bodyMedium({Color? color, FontWeight? fontWeight}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: color,
      );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: color,
      );

  // --- Label ---
  static TextStyle labelLarge({Color? color, FontWeight? fontWeight}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
        color: color,
      );

  static TextStyle labelMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.33,
        color: color,
      );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: color,
      );

  // --- Code ---
  static TextStyle code({Color? color}) => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.5,
        color: color,
      );

  static TextStyle codeLarge({Color? color}) => GoogleFonts.jetBrainsMono(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.5,
        color: color,
      );
}
