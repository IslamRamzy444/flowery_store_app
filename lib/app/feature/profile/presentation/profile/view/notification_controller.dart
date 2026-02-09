import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';

class NotificationController extends ChangeNotifier {
  bool isNotification = true;

  void changeNotification() {
    isNotification = !isNotification;
    AppSettings.openAppSettings(type: AppSettingsType.notification);
    notifyListeners();
  }
}
