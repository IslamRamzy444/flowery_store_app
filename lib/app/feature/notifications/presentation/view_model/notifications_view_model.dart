import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/notifications/domain/use_cases/notifications_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'notifications_events.dart';
import 'notifications_states.dart';

@injectable
class NotificationsViewModel extends Cubit<NotificationsStates> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetUnreadCountUseCase _getUnreadCountUseCase;
  final MarkNotificationsAsReadUseCase _markNotificationsAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase _markAllNotificationsAsReadUseCase;
  final ClearAllNotificationsUseCase _clearAllNotificationsUseCase;

  NotificationsViewModel(
    this._getNotificationsUseCase,
    this._getUnreadCountUseCase,
    this._markNotificationsAsReadUseCase,
    this._markAllNotificationsAsReadUseCase,
    this._clearAllNotificationsUseCase,
  ) : super(const NotificationsStates());

  void doIntent(NotificationsEvents event) {
    switch (event) {
      case GetNotificationsEvent():
        _getNotifications();
        break;
      case GetUnreadCountEvent():
        _getUnreadCount();
        break;
      case MarkNotificationsAsReadEvent():
        _markNotificationsAsRead(event.notificationIds);
        break;
      case MarkAllNotificationsAsReadEvent():
        _markAllNotificationsAsRead();
        break;
      case ClearAllNotificationsEvent():
        _clearAllNotifications();
        break;
    }
  }

  Future<void> _getNotifications() async {
    emit(state.copyWith(notificationsState: const BaseState(isLoading: true)));

    final response = await _getNotificationsUseCase();

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            notificationsState: BaseState(
              success: response.data,
              isLoading: false,
            ),
            unreadCount:
                response.data.metadata?.unreadCount ?? state.unreadCount,
          ),
        );
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            notificationsState: BaseState(
              error: response.error,
              isLoading: false,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _getUnreadCount() async {
    final response = await _getUnreadCountUseCase();
    if (response case SuccessResponse()) {
      emit(
        state.copyWith(
          unreadCount: response.data.unreadCount ?? state.unreadCount,
        ),
      );
    }
  }

  Future<void> _markNotificationsAsRead(List<String> ids) async {
    emit(state.copyWith(markReadState: const BaseState(isLoading: true)));

    final response = await _markNotificationsAsReadUseCase(ids);

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            markReadState: BaseState(success: response.data, isLoading: false),
            unreadCount: response.data.unreadCount ?? state.unreadCount,
          ),
        );
        _getNotifications();
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            markReadState: BaseState(error: response.error, isLoading: false),
          ),
        );
        break;
    }
  }

  Future<void> _markAllNotificationsAsRead() async {
    emit(state.copyWith(markReadState: const BaseState(isLoading: true)));

    final response = await _markAllNotificationsAsReadUseCase();

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            markReadState: BaseState(success: response.data, isLoading: false),
            unreadCount: 0,
          ),
        );
        _getNotifications();
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            markReadState: BaseState(error: response.error, isLoading: false),
          ),
        );
        break;
    }
  }

  Future<void> _clearAllNotifications() async {
    emit(state.copyWith(clearAllState: const BaseState(isLoading: true)));

    final response = await _clearAllNotificationsUseCase();

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            clearAllState: BaseState(success: response.data, isLoading: false),
            notificationsState: BaseState(
              success: state.notificationsState?.success?.copyWithEmptyList(),
              isLoading: false,
            ),
            unreadCount: 0,
          ),
        );
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            clearAllState: BaseState(error: response.error, isLoading: false),
          ),
        );
        break;
    }
  }
}
