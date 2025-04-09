import 'package:flutter/material.dart';
import 'package:mangan/src/core/theme/app_theme.dart';
import 'package:mangan/src/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mangan',
      theme: AppTheme.lightThemeMode,
      home: const HomePage(),
    );
  }
}
