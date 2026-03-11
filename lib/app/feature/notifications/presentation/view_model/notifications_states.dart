import 'package:equatable/equatable.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import '../../data/models/mark_read_response_model.dart';
import '../../data/models/notifications_response_model.dart';

class NotificationsStates extends Equatable {
  final BaseState<NotificationsResponseModel>? notificationsState;
  final BaseState<MarkReadResponseModel>? markReadState;
  final BaseState<MarkReadResponseModel>? clearAllState;
  final int unreadCount;

  const NotificationsStates({
    this.notificationsState,
    this.markReadState,
    this.clearAllState,
    this.unreadCount = 0,
  });

  NotificationsStates copyWith({
    BaseState<NotificationsResponseModel>? notificationsState,
    BaseState<MarkReadResponseModel>? markReadState,
    BaseState<MarkReadResponseModel>? clearAllState,
    int? unreadCount,
  }) {
    return NotificationsStates(
      notificationsState: notificationsState ?? this.notificationsState,
      markReadState: markReadState ?? this.markReadState,
      clearAllState: clearAllState ?? this.clearAllState,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
    notificationsState,
    markReadState,
    clearAllState,
    unreadCount,
  ];
}
