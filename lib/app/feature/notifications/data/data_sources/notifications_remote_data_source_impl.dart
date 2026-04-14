import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/notifications/data/api_client/notifications_api_client.dart';
import 'package:flower_app/app/feature/notifications/data/models/mark_read_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/notifications_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/unread_count_response_model.dart';
import 'package:injectable/injectable.dart';
import 'notifications_remote_data_source.dart';

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final NotificationsApiClient _apiClient;

  NotificationsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<NotificationsResponseModel>> getNotifications() async {
    try {
      final response = await _apiClient.getNotifications();
      return SuccessResponse(
        data: NotificationsResponseModel.fromJson(response),
      );
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }

  @override
  Future<BaseResponse<UnreadCountResponseModel>> getUnreadCount() async {
    try {
      final response = await _apiClient.getUnreadCount();
      return SuccessResponse(data: UnreadCountResponseModel.fromJson(response));
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }

  @override
  Future<BaseResponse<MarkReadResponseModel>> markNotificationsAsRead(
    List<String> notificationIds,
  ) async {
    try {
      final response = await _apiClient.markNotificationsAsRead({
        'notificationIds': notificationIds,
      });
      return SuccessResponse(data: MarkReadResponseModel.fromJson(response));
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }

  @override
  Future<BaseResponse<MarkReadResponseModel>>
  markAllNotificationsAsRead() async {
    try {
      final response = await _apiClient.markAllNotificationsAsRead();
      return SuccessResponse(data: MarkReadResponseModel.fromJson(response));
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }

  @override
  Future<BaseResponse<MarkReadResponseModel>> clearAllNotifications() async {
    try {
      final response = await _apiClient.clearAllNotifications();
      return SuccessResponse(data: MarkReadResponseModel.fromJson(response));
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }
}
