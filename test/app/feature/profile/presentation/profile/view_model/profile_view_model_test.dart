import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/app/config/base_error/custom_exceptions.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/logout_user_use_case.dart';
import 'package:flower_app/app/feature/profile/domain/model/user_entity.dart';
import 'package:flower_app/app/feature/profile/domain/use_case/get_user_data_use_case.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_event.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_intent.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_state.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_model_test.mocks.dart';

@GenerateMocks([GetUserDataUseCase, LogoutUserUseCase])
void main() {
  late GetUserDataUseCase getUserDataUseCase;
  late LogoutUserUseCase logoutUserUseCase;
  late UserEntity userEntity;
  late ProfileViewModel profileViewModel;
  setUpAll(() {
    getUserDataUseCase = MockGetUserDataUseCase();
    logoutUserUseCase = MockLogoutUserUseCase();
    userEntity = UserEntity(email: 's@yahoo.com');
  });
  setUp(() {
    profileViewModel = ProfileViewModel(getUserDataUseCase, logoutUserUseCase);
  });

  blocTest(
    'when calling dointent with get user data  action it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<UserEntity>>(SuccessResponse(data: userEntity));
      when(getUserDataUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value(SuccessResponse(data: userEntity));
      });
    },
    build: () => profileViewModel,
    act: (bloc) {
      profileViewModel.doIntent(GetProfileAction());
    },
    expect: () {
      var state = ProfileState(profileState: BaseState());
      return [
        state.copyWith(profileState: BaseState(isLoading: true)),
        state.copyWith(
          profileState: BaseState(isLoading: false, success: userEntity),
        ),
      ];
    },
  );
  blocTest(
    'when calling dointent with get user data action with error it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<UserEntity>>(
        ErrorResponse(error: UnexpectedError()),
      );
      when(getUserDataUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value(ErrorResponse(error: UnexpectedError()));
      });
    },
    build: () => profileViewModel,
    act: (bloc) {
      profileViewModel.doIntent(GetProfileAction());
    },
    expect: () {
      var state = ProfileState(profileState: BaseState());
      return [
        state.copyWith(profileState: BaseState(isLoading: true)),
        state.copyWith(profileState: BaseState(
            isLoading: false, error: UnexpectedError())),
      ];
    },
  );
  test('change language emits event (broadcast)', () async {
    final future = expectLater(
      profileViewModel.streamController.stream,
      emits(isA<ChangeLanguageEvent>()),
    );

    profileViewModel.doIntent(ChangeLanguageAction());

    await future;
  });
  blocTest(
    'when calling dointent with logout action it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
      when(logoutUserUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value(SuccessResponse(data: true));
      });
    },
    build: () => profileViewModel,
    act: (bloc) {
      profileViewModel.doIntent(LogoutUserAction());
    },
    expect: () {
      var state = ProfileState(profileState: BaseState());
      return [
        state.copyWith(
            isLogout: true
        ),
      ];
    },
  );
  blocTest(
    'when calling dointent with logout action with error  it should emit correct state',
    setUp: () {
      provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
      when(logoutUserUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value(ErrorResponse<bool>(error: UnexpectedError()));
      });
    },
    build: () => profileViewModel,
    act: (bloc) {
      profileViewModel.doIntent(LogoutUserAction());
    },
    expect: () {
      var state = ProfileState(profileState: BaseState());
      return [
        state.copyWith(
            isLogout: false
        ),
      ];
    },
  );
  test('BackNavigation emits event (broadcast)', () async {
    final future = expectLater(
      profileViewModel.streamController.stream,
      emits(isA<NavigateToEditProfileEvent>()),
    );

    profileViewModel.doIntent(NavigateToEditProfileAction());

    await future;
  });
}
