import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/notifications/data/models/mark_read_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/notifications_metadata_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/notifications_response_model.dart';
import 'package:flower_app/app/feature/notifications/data/models/unread_count_response_model.dart';
import 'package:flower_app/app/feature/notifications/domain/use_cases/notifications_use_cases.dart';
import 'package:flower_app/app/feature/notifications/presentation/view_model/notifications_events.dart';
import 'package:flower_app/app/feature/notifications/presentation/view_model/notifications_states.dart';
import 'package:flower_app/app/feature/notifications/presentation/view_model/notifications_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'notifications_view_model_test.mocks.dart';

@GenerateMocks([
  GetNotificationsUseCase,
  GetUnreadCountUseCase,
  MarkNotificationsAsReadUseCase,
  MarkAllNotificationsAsReadUseCase,
  ClearAllNotificationsUseCase,
])
void main() {
  late MockGetNotificationsUseCase mockGetNotifications;
  late MockGetUnreadCountUseCase mockGetUnreadCount;
  late MockMarkNotificationsAsReadUseCase mockMarkAsRead;
  late MockMarkAllNotificationsAsReadUseCase mockMarkAllAsRead;
  late MockClearAllNotificationsUseCase mockClearAll;
  late NotificationsViewModel viewModel;

  final testResponse = NotificationsResponseModel(
    message: 'success',
    metadata: NotificationsMetadataModel(
      currentPage: 1,
      totalPages: 1,
      limit: 40,
      totalItems: 0,
      unreadCount: 0,
    ),
    notifications: [],
  );

  final testMarkReadResponse = MarkReadResponseModel(
    message: 'All notifications marked as read',
    modifiedCount: 0,
    unreadCount: 0,
  );

  final testClearResponse = MarkReadResponseModel(
    message: 'All notifications cleared',
    deletedCount: 0,
  );

  setUp(() {
    mockGetNotifications = MockGetNotificationsUseCase();
    mockGetUnreadCount = MockGetUnreadCountUseCase();
    mockMarkAsRead = MockMarkNotificationsAsReadUseCase();
    mockMarkAllAsRead = MockMarkAllNotificationsAsReadUseCase();
    mockClearAll = MockClearAllNotificationsUseCase();

    viewModel = NotificationsViewModel(
      mockGetNotifications,
      mockGetUnreadCount,
      mockMarkAsRead,
      mockMarkAllAsRead,
      mockClearAll,
    );

    provideDummy<BaseResponse<NotificationsResponseModel>>(
      SuccessResponse(data: testResponse),
    );
    provideDummy<BaseResponse<UnreadCountResponseModel>>(
      SuccessResponse(data: UnreadCountResponseModel(unreadCount: 0)),
    );
    provideDummy<BaseResponse<MarkReadResponseModel>>(
      SuccessResponse(data: testMarkReadResponse),
    );
  });

  group('GetNotificationsEvent', () {
    blocTest<NotificationsViewModel, NotificationsStates>(
      'emits loading then success',
      build: () {
        when(
          mockGetNotifications.call(),
        ).thenAnswer((_) async => SuccessResponse(data: testResponse));
        return viewModel;
      },
      act: (vm) => vm.doIntent(GetNotificationsEvent()),
      expect: () => [
        const NotificationsStates(
          notificationsState: BaseState(isLoading: true),
        ),
        NotificationsStates(
          notificationsState: BaseState(
            success: testResponse,
            isLoading: false,
          ),
          unreadCount: 0,
        ),
      ],
    );

    blocTest<NotificationsViewModel, NotificationsStates>(
      'emits loading then error on failure',
      build: () {
        when(mockGetNotifications.call()).thenAnswer(
          (_) async => ErrorResponse(error: Exception('Network error')),
        );
        return viewModel;
      },
      act: (vm) => vm.doIntent(GetNotificationsEvent()),
      expect: () => [
        const NotificationsStates(
          notificationsState: BaseState(isLoading: true),
        ),
        isA<NotificationsStates>().having(
          (s) => s.notificationsState?.error,
          'error is not null',
          isNotNull,
        ),
      ],
    );
  });

  group('MarkAllNotificationsAsReadEvent', () {
    blocTest<NotificationsViewModel, NotificationsStates>(
      'emits loading then success and refreshes notifications',
      build: () {
        when(
          mockMarkAllAsRead.call(),
        ).thenAnswer((_) async => SuccessResponse(data: testMarkReadResponse));
        when(
          mockGetNotifications.call(),
        ).thenAnswer((_) async => SuccessResponse(data: testResponse));
        return viewModel;
      },
      act: (vm) => vm.doIntent(MarkAllNotificationsAsReadEvent()),
      expect: () => [
        const NotificationsStates(markReadState: BaseState(isLoading: true)),
        isA<NotificationsStates>().having(
          (s) => s.unreadCount,
          'unreadCount is 0',
          0,
        ),
        // Loading state from refresh
        isA<NotificationsStates>(),
        // Success state from refresh
        isA<NotificationsStates>(),
      ],
    );
  });

  group('ClearAllNotificationsEvent', () {
    blocTest<NotificationsViewModel, NotificationsStates>(
      'emits loading then success and clears list',
      build: () {
        when(
          mockClearAll.call(),
        ).thenAnswer((_) async => SuccessResponse(data: testClearResponse));
        return viewModel;
      },
      act: (vm) => vm.doIntent(ClearAllNotificationsEvent()),
      expect: () => [
        const NotificationsStates(clearAllState: BaseState(isLoading: true)),
        isA<NotificationsStates>()
            .having(
              (s) => s.clearAllState?.success,
              'clearAllState has success',
              isNotNull,
            )
            .having(
              (s) => s.clearAllState?.isLoading,
              'clearAllState is not loading',
              false,
            )
            .having((s) => s.unreadCount, 'unreadCount is 0', 0),
      ],
    );
  });
}
