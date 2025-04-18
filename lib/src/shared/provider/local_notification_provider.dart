import 'package:flutter/material.dart';
import 'package:mangan/src/shared/data/datasources/localdatasources/schedule_notification_local_data_source.dart';
import 'package:mangan/src/shared/data/notification/local_notification_services.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationServices flutterNotificationService;

  LocalNotificationProvider({required this.flutterNotificationService});

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  bool _isDailyReminderEnabled = false;
  bool get isDailyReminderEnabled => _isDailyReminderEnabled;

  Future<void> loadReminderStatus() async {
    _isDailyReminderEnabled = await ScheduleNotificationLocalDataSource()
        .loadScheduleNotificationSetting();
    if (_isDailyReminderEnabled) {
      scheduleDailyTenAMNotification();
    }
    notifyListeners();
  }

  Future<void> _saveReminderStatus(bool value) async {
    await ScheduleNotificationLocalDataSource()
        .editScheduleNotificationSetting(value);
  }

  Future<void> toggleDailyReminder(bool isEnabled) async {
    _isDailyReminderEnabled = isEnabled;
    await _saveReminderStatus(isEnabled);

    if (isEnabled) {
      scheduleDailyTenAMNotification();
    } else {
      await flutterNotificationService.cancelNotificationAll();
    }

    notifyListeners();
  }

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyTenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyTenAMNotification(
      id: _notificationId,
    );
  }
}
