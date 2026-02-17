import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/set_notification_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/local_storage_processes/domain/use_case/get_notification_use_case.dart';
import '../../domain/use_case/add_language_use_case.dart';
import '../../domain/use_case/get_saved_language_use_case.dart';

@injectable
class StartViewModel extends ChangeNotifier {
  final GetSavedLanguageUseCase _getSavedLanguageUseCase;
  final AddLanguageUseCase _addLanguageUseCase;
  final SetNotificationUseCase _notificationUseCase;
  final GetNotificationUseCase _getNotificationUseCase;
  bool? enableNotification;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  StartViewModel(
    this._getSavedLanguageUseCase,
    this._addLanguageUseCase,
    this._notificationUseCase,
    this._getNotificationUseCase,
  );

  void setNotification(bool enable) {
    enableNotification = enable;
    _notificationUseCase.invoke(enable);
    messaging.setAutoInitEnabled(enable);
    notifyListeners();
  }

  void getNotification() {
    enableNotification = _getNotificationUseCase.invoke();
    notifyListeners();
  }
  Future<void> requestNotification() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    String? token = await FirebaseMessaging.instance.getToken();

  }
  void initLanguage() {
    String? savedLanguage = _getSavedLanguageUseCase.invoke();
    language = savedLanguage ?? _getSystemLanguageCode();
    notifyListeners();
  }

  String? language;

  Future<void> changeLanguage(String lang) async {
    language = lang;
    await _addLanguageUseCase.invoke(lang);
    notifyListeners();
  }

  String _getSystemLanguageCode() {
    return WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }
}
