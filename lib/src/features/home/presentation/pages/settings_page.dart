import 'package:flutter/material.dart';
import 'package:mangan/src/features/home/presentation/widgets/switch_setting_widget.dart';
import 'package:mangan/src/shared/provider/local_notification_provider.dart';
import 'package:mangan/src/shared/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localNotificationProvider =
        Provider.of<LocalNotificationProvider>(context);

    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Consumer<LocalNotificationProvider>(
              builder: (context, value, child) {
                return SwitchSettingWidget(
                  title: "Lunch Notification",
                  subtitle: "Enable Notification to active lunch notification",
                  value: value.isDailyReminderEnabled,
                  onChanged: (val) {
                    localNotificationProvider.toggleDailyReminder(val);
                    debugPrint(val.toString());
                  },
                );
              },
            ),
            SwitchSettingWidget(
              title: "Dark Mode",
              subtitle: "Enable to active dark mode",
              value: isDarkMode,
              onChanged: (val) async {
                final savedTheme = await themeProvider.getThemePreferences();
                themeProvider.toggleTheme(!savedTheme);
              },
            ),
          ],
        ),
      ),
    );
  }
}
