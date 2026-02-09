import 'package:flower_app/app/feature/profile/presentation/profile/view/widget/profile_items_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/utils/app_locale.dart';
import '../notification_controller.dart';

class ChangeNotificationWidget extends StatefulWidget {
  const ChangeNotificationWidget({
    super.key,
    required this.notificationController,
  });

  final NotificationController notificationController;

  @override
  State<ChangeNotificationWidget> createState() =>
      _ChangeNotificationWidgetState();
}

class _ChangeNotificationWidgetState extends State<ChangeNotificationWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.notificationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileItemsWidget(
      data: AppLocale(context).notifications,
      leading: Switch(
        value: widget.notificationController.isNotification,
        onChanged: (value) {
          widget.notificationController.changeNotification();
        },
        activeTrackColor: AppColors.primaryColor,
      ),
    );
  }
}
