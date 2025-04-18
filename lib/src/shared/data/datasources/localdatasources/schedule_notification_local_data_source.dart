import 'package:shared_preferences/shared_preferences.dart';

class ScheduleNotificationLocalDataSource {
  Future<bool> loadScheduleNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dailyReminder') ?? false;
  }

  Future<void> editScheduleNotificationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dailyReminder', value);
  }
}
