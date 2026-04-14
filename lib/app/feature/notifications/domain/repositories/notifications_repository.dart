import 'package:flower_app/app/config/base_response/base_response.dart';
import '../../data/models/notifications_response_model.dart';
import '../../data/models/unread_count_response_model.dart';
import '../../data/models/mark_read_response_model.dart';

abstract class NotificationsRepository {
  Future<BaseResponse<NotificationsResponseModel>> getNotifications();

  Future<BaseResponse<UnreadCountResponseModel>> getUnreadCount();

  Future<BaseResponse<MarkReadResponseModel>> markNotificationsAsRead(
    List<String> notificationIds,
  );

  Future<BaseResponse<MarkReadResponseModel>> markAllNotificationsAsRead();

  Future<BaseResponse<MarkReadResponseModel>> clearAllNotifications();
}
