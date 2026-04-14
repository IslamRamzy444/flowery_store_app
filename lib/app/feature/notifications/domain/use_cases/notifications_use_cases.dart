import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/notifications/data/models/mark_read_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/notifications_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/unread_count_response_model.dart';
import 'package:flower_app/app/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationsRepository _repository;
  GetNotificationsUseCase(this._repository);
  Future<BaseResponse<NotificationsResponseModel>> call() =>
      _repository.getNotifications();
}

@injectable
class GetUnreadCountUseCase {
  final NotificationsRepository _repository;
  GetUnreadCountUseCase(this._repository);
  Future<BaseResponse<UnreadCountResponseModel>> call() =>
      _repository.getUnreadCount();
}

@injectable
class MarkNotificationsAsReadUseCase {
  final NotificationsRepository _repository;
  MarkNotificationsAsReadUseCase(this._repository);
  Future<BaseResponse<MarkReadResponseModel>> call(
    List<String> notificationIds,
  ) => _repository.markNotificationsAsRead(notificationIds);
}

@injectable
class MarkAllNotificationsAsReadUseCase {
  final NotificationsRepository _repository;
  MarkAllNotificationsAsReadUseCase(this._repository);
  Future<BaseResponse<MarkReadResponseModel>> call() =>
      _repository.markAllNotificationsAsRead();
}

@injectable
class ClearAllNotificationsUseCase {
  final NotificationsRepository _repository;
  ClearAllNotificationsUseCase(this._repository);
  Future<BaseResponse<MarkReadResponseModel>> call() =>
      _repository.clearAllNotifications();
}
