import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/notifications_events.dart';
import '../../view_model/notifications_states.dart';
import '../../view_model/notifications_view_model.dart';
import '../widgets/notification_card_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationsViewModel _viewModel = getIt<NotificationsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.doIntent(GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: BlocConsumer<NotificationsViewModel, NotificationsStates>(
        listener: (context, state) {
          if (state.markReadState?.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.markReadState!.error!.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.clearAllState?.success != null &&
              state.clearAllState?.isLoading == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('All notifications cleared')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _buildAppBar(context, state),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    NotificationsStates state,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 133.w,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 16.r,
                color: const Color(0xFF0C1015),
              ),
              SizedBox(width: 4.w),
              Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: const Color(0xFF0C1015),
                ),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        'Notification',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
          color: const Color(0xFF0C1015),
          height: 1.0,
        ),
      ),
      centerTitle: true,
      actions: [
        if (_hasNotifications(state))
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: const Color(0xFF0C1015),
              size: 20.r,
            ),
            onSelected: (value) {
              if (value == 'mark_all') {
                _viewModel.doIntent(MarkAllNotificationsAsReadEvent());
              } else if (value == 'clear_all') {
                _showClearAllDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem(value: 'clear_all', child: Text('Clear all')),
            ],
          ),
      ],
    );
  }

  bool _hasNotifications(NotificationsStates state) {
    final notifications =
        state.notificationsState?.success?.notifications ?? [];
    return notifications.isNotEmpty;
  }

  Widget _buildBody(BuildContext context, NotificationsStates state) {
    final notificationsState = state.notificationsState;

    if (notificationsState?.isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    if (notificationsState?.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notificationsState!.error!.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: AppColors.grayColor),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () => _viewModel.doIntent(GetNotificationsEvent()),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    final notifications = notificationsState?.success?.notifications ?? [];

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 60.r,
              color: AppColors.grayColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'No notifications yet',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.sp,
                color: AppColors.grayColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return GestureDetector(
          onTap: () {
            if (notification.isRead == false && notification.id != null) {
              _viewModel.doIntent(
                MarkNotificationsAsReadEvent([notification.id!]),
              );
            }
          },
          child: NotificationCardWidget(notification: notification),
        );
      },
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all notifications'),
        content: const Text(
          'Are you sure you want to delete all notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _viewModel.doIntent(ClearAllNotificationsEvent());
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
