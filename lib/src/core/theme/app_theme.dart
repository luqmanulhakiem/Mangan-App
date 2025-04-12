import 'package:flutter/material.dart';
import 'package:mangan/src/core/theme/app_font.dart';
import 'package:mangan/src/core/theme/app_palette.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primary),
    appBarTheme: _getAppBarTheme(),
    textTheme: _getTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: _cardTheme(color: Colors.grey.shade200),
    // iconTheme: const IconThemeData(color: Colors.black),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primary),
      appBarTheme: _getAppBarTheme(
        colorDefault: Colors.black,
        isDarkMode: true,
      ),
      textTheme: _getTextTheme(colorDefault: Colors.white),
      scaffoldBackgroundColor: Colors.black,
      cardTheme: _cardTheme(color: Colors.grey.shade900),
      tabBarTheme: TabBarTheme(
        dividerColor: Colors.white,
        labelColor: Colors.white,
        overlayColor: WidgetStatePropertyAll(Colors.grey.shade700),
        unselectedLabelColor: Colors.grey.shade700,
        indicatorColor: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      ));

  static CardTheme _cardTheme({required Color color}) {
    return CardTheme(
      color: color,
    );
  }

  static AppBarTheme _getAppBarTheme({
    Color colorDefault = Colors.white,
    bool isDarkMode = false,
  }) {
    return AppBarTheme(
      backgroundColor: colorDefault,
      iconTheme: IconThemeData(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
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
