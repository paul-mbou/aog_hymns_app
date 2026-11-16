import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppFonts {
  static TextStyle ui(
    TextStyle? base, {
    FontWeight weight = FontWeight.w500,
    double? size,
    Color? color,
  }) {
    return GoogleFonts.ibmPlexSans(
      textStyle: base,
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle title(
    TextStyle? base, {
    FontWeight weight = FontWeight.w600,
    double? size,
    Color? color,
  }) {
    return GoogleFonts.fraunces(
      textStyle: base,
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }
}
