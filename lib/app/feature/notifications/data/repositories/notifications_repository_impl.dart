import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:flower_app/app/feature/notifications/data/models/mark_read_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/notifications_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/unread_count_response_model.dart';
import 'package:flower_app/app/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<NotificationsResponseModel>> getNotifications() =>
      _remoteDataSource.getNotifications();

  @override
  Future<BaseResponse<UnreadCountResponseModel>> getUnreadCount() =>
      _remoteDataSource.getUnreadCount();

  @override
  Future<BaseResponse<MarkReadResponseModel>> markNotificationsAsRead(
    List<String> notificationIds,
  ) => _remoteDataSource.markNotificationsAsRead(notificationIds);

  @override
  Future<BaseResponse<MarkReadResponseModel>> markAllNotificationsAsRead() =>
      _remoteDataSource.markAllNotificationsAsRead();

  @override
  Future<BaseResponse<MarkReadResponseModel>> clearAllNotifications() =>
      _remoteDataSource.clearAllNotifications();
}
