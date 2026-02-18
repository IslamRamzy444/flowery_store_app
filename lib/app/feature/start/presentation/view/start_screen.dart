import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/di/di.dart';
import '../view_model/start_view_model.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final StartViewModel startViewModel = getIt<StartViewModel>();

  @override
  void initState() {
    super.initState();
    startViewModel.getNotification();
    startViewModel.initLanguage();

    // Show a dialog explaining why notification permission is needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNotificationPermissionDialog(context);
    });
  }

  Future<void> _showNotificationPermissionDialog(BuildContext context) async {
    final bool? allowNotifications = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(AppLocale(context).enableNotification),
          content: Text(AppLocale(context).notificationMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(AppLocale(context).notNow),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(AppLocale(context).allow),
            ),
          ],
        );
      },
    );

    if (allowNotifications == true) {
      startViewModel.requestNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => startViewModel,
      child: MyApp(),
    );
  }
}
