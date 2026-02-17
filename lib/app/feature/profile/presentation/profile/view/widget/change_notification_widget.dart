import 'package:flower_app/app/feature/profile/presentation/profile/view/widget/profile_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/utils/app_locale.dart';
import '../../../../../start/presentation/view_model/start_view_model.dart';


class ChangeNotificationWidget extends StatefulWidget {
  const ChangeNotificationWidget({
    super.key,

  });



  @override
  State<ChangeNotificationWidget> createState() =>
      _ChangeNotificationWidgetState();
}

class _ChangeNotificationWidgetState extends State<ChangeNotificationWidget> {


  @override
  Widget build(BuildContext context) {
    final startViewModel = Provider.of<StartViewModel>(context);

    return ProfileItemsWidget(
      data: AppLocale(context).notifications,
      leading: Switch(
        value: startViewModel.enableNotification ?? true,
        onChanged: (value) {
          startViewModel.setNotification(value);
        },
        activeTrackColor: AppColors.primaryColor,
      ),
    );
  }
}
