import 'package:aog_hymns_app/core/theme/app_fonts.dart';
import 'package:aog_hymns_app/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

/// Same component layout as the FGM hymnbook, with the crest gold palette.
abstract final class AppTheme {
  static const radius = 20.0;
  static const controlHeight = 48.0;

  static ThemeData light() => _build(AppThemeColors.lightScheme);

  static ThemeData dark() => _build(AppThemeColors.darkScheme);

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
    );
    final text = base.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
      fontFamily: AppFonts.ui(null).fontFamily,
    );
    return base.copyWith(
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppFonts.title(text.titleLarge, size: 22),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: 0.22),
        labelTextStyle: WidgetStatePropertyAll(
          AppFonts.ui(text.labelMedium, weight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.brightness == Brightness.light
            ? const Color(0xFFFFF3D6)
            : const Color(0xFF241C12),
        hintStyle: AppFonts.ui(text.bodyMedium, color: scheme.onSurface.withValues(alpha: 0.55)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(controlHeight),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: AppFonts.ui(null, weight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.25)),
        ),
      ),
    );
  }
}
