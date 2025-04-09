import 'package:flutter/material.dart';
import 'package:mangan/src/core/theme/app_font.dart';
import 'package:mangan/src/core/theme/app_palette.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primary),
    appBarTheme: _getAppBarTheme(),
    textTheme: _getTextTheme(),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primary),
    appBarTheme: _getAppBarTheme(colorDefault: Colors.black),
    textTheme: _getTextTheme(colorDefault: Colors.white),
  );

  static AppBarTheme _getAppBarTheme(
      {Color colorDefault = AppPalette.primary}) {
    return AppBarTheme(
      color: colorDefault,
    );
  }

  static TextTheme _getTextTheme({Color colorDefault = Colors.black}) {
    return TextTheme(
      displayMedium: AppFont.displayMedium.copyWith(color: colorDefault),
      headlineMedium: AppFont.headlineMedium.copyWith(color: colorDefault),
      titleMedium: AppFont.titleMedium.copyWith(color: colorDefault),
      labelMedium: AppFont.labelMedium.copyWith(color: colorDefault),
      bodyMedium: AppFont.bodyMedium.copyWith(color: colorDefault),
    );
  }
}
