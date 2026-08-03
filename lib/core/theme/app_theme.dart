import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  // ========== LIGHT THEME ==========
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryContainerLight,
      onPrimaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryContainerLight,
      onSecondaryContainer: AppColors.secondaryLight,
      tertiary: AppColors.tertiaryLight,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.tertiaryContainerLight,
      onTertiaryContainer: AppColors.tertiaryLight,
      error: AppColors.errorLight,
      onError: Colors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      onSurfaceVariant: AppColors.textSecondaryLight,
      outline: AppColors.borderLight,
      outlineVariant: AppColors.dividerLight,
      shadow: AppColors.shadowLight,
      scrim: AppColors.overlayLight,
      inverseSurface: AppColors.textPrimaryDark,
      onInverseSurface: AppColors.surfaceLight,
    );

    return _buildTheme(colorScheme, Brightness.light);
  }

  // ========== DARK THEME ==========
  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: AppColors.backgroundDark,
      primaryContainer: AppColors.primaryContainerDark,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.backgroundDark,
      secondaryContainer: AppColors.secondaryContainerDark,
      onSecondaryContainer: AppColors.secondaryDark,
      tertiary: AppColors.tertiaryDark,
      onTertiary: AppColors.backgroundDark,
      tertiaryContainer: AppColors.tertiaryContainerDark,
      onTertiaryContainer: AppColors.tertiaryDark,
      error: AppColors.errorDark,
      onError: AppColors.backgroundDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      outline: AppColors.borderDark,
      outlineVariant: AppColors.dividerDark,
      shadow: AppColors.shadowDark,
      scrim: AppColors.overlayDark,
      inverseSurface: AppColors.textPrimaryLight,
      onInverseSurface: AppColors.surfaceDark,
    );

    return _buildTheme(colorScheme, Brightness.dark);
  }

  // ========== SHARED THEME BUILDER ==========
  static ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final textPrimary = isLight ? AppColors.textPrimaryLight : AppColors.textPrimaryDark;
    final textSecondary = isLight ? AppColors.textSecondaryLight : AppColors.textSecondaryDark;
    final textTertiary = isLight ? AppColors.textTertiaryLight : AppColors.textTertiaryDark;
    final surface = isLight ? AppColors.surfaceLight : AppColors.surfaceDark;
    final surfaceVariant = isLight ? AppColors.surfaceVariantLight : AppColors.surfaceVariantDark;
    final border = isLight ? AppColors.borderLight : AppColors.borderDark;
    final scaffoldBg = isLight ? AppColors.scaffoldLight : AppColors.scaffoldDark;
    final dividerColor = isLight ? AppColors.dividerLight : AppColors.dividerDark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,

      // --- Text Theme ---
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.5,
          height: 1.12,
          color: textPrimary,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          height: 1.16,
          color: textPrimary,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          height: 1.22,
          color: textPrimary,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          height: 1.25,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          height: 1.29,
          color: textPrimary,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.33,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 1.27,
          color: textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          height: 1.5,
          color: textPrimary,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.43,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
          color: textPrimary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
          color: textSecondary,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          height: 1.43,
          color: textPrimary,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          height: 1.33,
          color: textSecondary,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
          color: textTertiary,
        ),
      ),

      // --- AppBar ---
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        backgroundColor: scaffoldBg,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: isLight
            ? SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
              )
            : SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
              ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),

      // --- Card ---
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          side: BorderSide(color: border, width: 0.5),
        ),
      ),

      // --- Elevated Button ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightLg),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // --- Outlined Button ---
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeightLg),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          side: BorderSide(color: border),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // --- Text Button ---
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // --- Input Decoration ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: border.withAlpha(128)),
        ),
      ),

      // --- Chip ---
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: surfaceVariant.withAlpha(128),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusSm,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        side: BorderSide(color: border),
      ),

      // --- Bottom Navigation ---
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      // --- Tab Bar ---
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: textSecondary,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        indicatorColor: colorScheme.primary,
        dividerColor: dividerColor,
      ),

      // --- Divider ---
      dividerTheme: DividerThemeData(
        color: dividerColor,
        thickness: AppSpacing.dividerThickness,
        space: AppSpacing.dividerHeight,
      ),

      // --- ListTile ---
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusSm,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        subtitleTextStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      ),

      // --- Dialog ---
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),

      // --- Bottom Sheet ---
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
      ),

      // --- Snackbar ---
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isLight ? AppColors.textPrimaryLight : AppColors.surfaceLight,
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isLight ? Colors.white : AppColors.textPrimaryLight,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
      ),

      // --- Progress Indicator ---
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: surfaceVariant,
        circularTrackColor: surfaceVariant,
      ),

      // --- Switch ---
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return surfaceVariant;
        }),
      ),

      // --- Slider ---
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: surfaceVariant,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withAlpha(51),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),

      // --- Floating Action Button ---
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
      ),

      // --- Popup Menu ---
      popupMenuTheme: PopupMenuThemeData(
        color: surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusSm,
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
      ),

      // --- Tooltip ---
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isLight ? AppColors.textPrimaryLight : AppColors.surfaceLight,
          borderRadius: AppSpacing.borderRadiusSm,
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isLight ? Colors.white : AppColors.textPrimaryDark,
        ),
      ),
    );
  }
}
