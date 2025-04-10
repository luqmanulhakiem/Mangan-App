import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont {
  static TextStyle inriaSans = GoogleFonts.inriaSans();
  static TextStyle displayMedium = inriaSans.copyWith(
    fontSize: 45,
    // height: 52,
  );
  static TextStyle headlineMedium = inriaSans.copyWith(
    fontSize: 28,
    // height: 36,
  );
  static TextStyle titleMedium = inriaSans.copyWith(
    fontSize: 16,
    // height: 24,
    letterSpacing: 0.15,
  );
  static TextStyle labelMedium = inriaSans.copyWith(
    fontSize: 12,
    // height: 20,
    letterSpacing: 0.5,
  );
  static TextStyle bodyMedium = inriaSans.copyWith(
    fontSize: 14,
    // height: 20,
    letterSpacing: 0.25,
  );
}
