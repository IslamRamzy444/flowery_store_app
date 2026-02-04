 import 'package:firebase_core/firebase_core.dart';
import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/routes/app_page.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/theme/app_theme.dart';
import 'package:flower_app/app/feature/start/presentation/view/start_screen.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app/feature/start/presentation/view_model/start_view_model.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StartScreen());
}

 class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final startViewModel = Provider.of<StartViewModel>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: child,
        onGenerateRoute: RouteGenerator.getRoutes,
        initialRoute: Routes.splash,
        locale: Locale(startViewModel.language ?? 'en'),
      ),
    );
  }
}
