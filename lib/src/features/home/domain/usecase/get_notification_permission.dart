import 'package:flutter/material.dart';
import 'package:mangan/src/shared/provider/local_notification_provider.dart';
import 'package:provider/provider.dart';

class GetNotificationPermission {
  Future<void> requestPermission(BuildContext context) async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }
}
