import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/add_language_use_case.dart';
import '../../domain/use_case/get_saved_language_use_case.dart';

@injectable
class StartViewModel extends ChangeNotifier {
  final GetSavedLanguageUseCase _getSavedLanguageUseCase;
  final AddLanguageUseCase _addLanguageUseCase;

  StartViewModel(this._getSavedLanguageUseCase, this._addLanguageUseCase);

  Future<void> requestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
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
