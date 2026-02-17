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
    startViewModel.requestNotification();
    startViewModel.initLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => startViewModel,
      child: MyApp(),
    );
  }
}
