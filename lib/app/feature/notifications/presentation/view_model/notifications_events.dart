sealed class NotificationsEvents {}

class GetNotificationsEvent extends NotificationsEvents {}

class GetUnreadCountEvent extends NotificationsEvents {}

class MarkNotificationsAsReadEvent extends NotificationsEvents {
  final List<String> notificationIds;
  MarkNotificationsAsReadEvent(this.notificationIds);
}

class MarkAllNotificationsAsReadEvent extends NotificationsEvents {}

class ClearAllNotificationsEvent extends NotificationsEvents {}
