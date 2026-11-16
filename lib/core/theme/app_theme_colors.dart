import 'package:flutter/material.dart';

/// Gold crest palette. Views read [ColorScheme]; hex lives only here.
abstract final class AppThemeColors {
  static const antiqueGold = Color(0xFF8C6A12);
  static const brightGold = Color(0xFFE6C15A);
  static const nearBlack = Color(0xFF1A1408);
  static const ivory = Color(0xFFFFF8E8);
  static const darkScaffold = Color(0xFF14110C);

  static const lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: antiqueGold,
    onPrimary: nearBlack,
    secondary: Color(0xFF6E5310),
    onSecondary: ivory,
    surface: ivory,
    onSurface: nearBlack,
    error: Color(0xFF8C2F2F),
    onError: ivory,
  );

  static const darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: brightGold,
    onPrimary: nearBlack,
    secondary: Color(0xFFC6A45A),
    onSecondary: nearBlack,
    surface: darkScaffold,
    onSurface: Color(0xFFF6EED6),
    error: Color(0xFFE7B0A8),
    onError: nearBlack,
  );
}
