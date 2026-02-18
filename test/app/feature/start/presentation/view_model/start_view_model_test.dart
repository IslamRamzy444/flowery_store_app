import 'package:flower_app/app/config/base_error/custom_exceptions.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/get_notification_use_case.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/set_notification_use_case.dart';
import 'package:flower_app/app/feature/start/domain/use_case/add_language_use_case.dart';
import 'package:flower_app/app/feature/start/domain/use_case/get_saved_language_use_case.dart';
import 'package:flower_app/app/feature/start/presentation/view_model/start_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'start_view_model_test.mocks.dart';

@GenerateMocks([GetSavedLanguageUseCase, AddLanguageUseCase,
  SetNotificationUseCase, GetNotificationUseCase
])
void main() {
  late GetSavedLanguageUseCase mockGetSavedLanguage;
  late AddLanguageUseCase mockAddLanguage;
  late SetNotificationUseCase mockSetNotification;
  late GetNotificationUseCase mockGetNotification;
  late StartViewModel viewModel;

  setUp(() {
    mockGetSavedLanguage = MockGetSavedLanguageUseCase();
    mockAddLanguage = MockAddLanguageUseCase();
    mockSetNotification = MockSetNotificationUseCase();
    mockGetNotification = MockGetNotificationUseCase();
    viewModel = StartViewModel(mockGetSavedLanguage, mockAddLanguage,
        mockSetNotification, mockGetNotification);
  });

  // ---------------- initLanguage ----------------

  test('initLanguage uses saved language when exists', () async {

    // arrange
    when(mockGetSavedLanguage.invoke()).thenReturn('ar');

    bool notified = false;
    viewModel.addListener(() {
      notified = true;
    });

    // act
    viewModel.initLanguage();

    // assert
    expect(viewModel.language, 'ar');
    expect(notified, true);
    verify(mockGetSavedLanguage.invoke()).called(1);
  });

  test('initLanguage uses system language when saved is null', () {
    // arrange
    when(mockGetSavedLanguage.invoke()).thenReturn(null);

    WidgetsFlutterBinding.ensureInitialized();

    // act
    viewModel.initLanguage();

    // assert
    expect(viewModel.language, 'en');
    verify(mockGetSavedLanguage.invoke()).called(1);
  });

  // ---------------- changeLanguage ----------------

  test('changeLanguage updates language and notifies on success', () async {
    // arrange
    provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
    when(
      mockAddLanguage.invoke('fr'),
    ).thenAnswer((_) async => SuccessResponse(data: true));

    WidgetsFlutterBinding.ensureInitialized();

    // act
    await viewModel.changeLanguage('fr');

    // assert
    expect(viewModel.language, 'fr');
    verify(mockAddLanguage.invoke('fr')).called(1);
  });

  test('changeLanguage still updates language on error', () async {
    // arrange
    provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
    when(
      mockAddLanguage.invoke('de'),
    ).thenAnswer((_) async => ErrorResponse(error: UnexpectedError()));
    WidgetsFlutterBinding.ensureInitialized();

    // act
    await viewModel.changeLanguage('de');

    // assert
    expect(viewModel.language, 'de');
    verify(mockAddLanguage.invoke('de')).called(1);
  });
}
