import 'package:flower_app/app/config/base_response/base_response.dart';
import '../models/notifications_response_model.dart';
import '../models/unread_count_response_model.dart';
import '../models/mark_read_response_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<BaseResponse<NotificationsResponseModel>> getNotifications();

  Future<BaseResponse<UnreadCountResponseModel>> getUnreadCount();

  Future<BaseResponse<MarkReadResponseModel>> markNotificationsAsRead(
    List<String> notificationIds,
  );

  Future<BaseResponse<MarkReadResponseModel>> markAllNotificationsAsRead();

  Future<BaseResponse<MarkReadResponseModel>> clearAllNotifications();
}
