import 'package:flutter/material.dart';
import 'package:mangan/src/core/theme/app_theme.dart';
import 'package:mangan/src/features/detail/presentation/provider/favorite_detail_provider.dart';
import 'package:mangan/src/features/detail/presentation/provider/restaurant_provider.dart';
import 'package:mangan/src/features/home/presentation/provider/favorite_list_provider.dart';
import 'package:mangan/src/features/home/presentation/provider/restaurant_list_provider.dart';
import 'package:mangan/src/features/home/presentation/widgets/main_page_widget.dart';
import 'package:mangan/src/shared/data/datasources/localdatasources/sqflite_service.dart';
import 'package:mangan/src/shared/data/notification/local_notification_services.dart';
import 'package:mangan/src/shared/provider/local_notification_provider.dart';
import 'package:mangan/src/shared/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await Future.delayed(const Duration(milliseconds: 100)); // Ensure async load
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteDetailProvider(
            SqfliteService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteListProvider(
            SqfliteService(),
          ),
        ),
        Provider(
          create: (context) => LocalNotificationServices()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            flutterNotificationService:
                context.read<LocalNotificationServices>(),
          )
            ..requestPermissions()
            ..loadReminderStatus(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Mangan',
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      themeMode: themeProvider.themeMode,
      home: const MainPageWidget(),
    );
  }
}
