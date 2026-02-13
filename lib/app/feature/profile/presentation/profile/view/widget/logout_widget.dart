import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../home/presentation/view_model/home_view_model.dart';
import '../../view_model/profile_intent.dart';
import '../../view_model/profile_state.dart';
class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}
class _LogoutWidgetState extends State<LogoutWidget> {
  final ProfileViewModel profileViewModel = getIt<ProfileViewModel>();
  final HomeViewModel homeViewModel = getIt<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      bloc: profileViewModel,
      listener: (context, state) {
        if (state.isLogout == true) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocale(context).logOutAction),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      profileViewModel.doIntent(LogoutUserAction());
                    },
                    child: Text(AppLocale(context).yes,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                          fontSize: 20
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(AppLocale(context).no,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
