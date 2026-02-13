import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/custom_cubit.dart';
import 'package:flower_app/app/feature/profile/domain/model/user_entity.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_event.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_intent.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/local_storage_processes/domain/use_case/logout_user_use_case.dart';
import '../../../domain/use_case/get_user_data_use_case.dart';

@injectable
class ProfileViewModel extends CustomCubit<ProfileEvent, ProfileState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final LogoutUserUseCase _logoutUserUseCase;

  ProfileViewModel(this._getUserDataUseCase, this._logoutUserUseCase)
    : super(ProfileState(profileState: BaseState()));

  Future<void> _getUserData() async {
    emit(state.copyWith(profileState: BaseState(isLoading: true)));
    final response = await _getUserDataUseCase.invoke();
    switch (response) {
      case SuccessResponse<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, success: response.data),
          ),
        );
        break;
      case ErrorResponse<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, error: response.error),
          ),
        );
        break;
    }
  }

  Future<void> _logoutUser() async {
    final response = await _logoutUserUseCase.invoke();
    switch (response) {
      case SuccessResponse<bool>():
        emit(state.copyWith(isLogout: true));
        break;
      case ErrorResponse<bool>():
        emit(state.copyWith(isLogout: false));
        break;
    }
  }

  void doIntent(ProfileIntent intent) {
    switch (intent) {
      case GetProfileAction():
        _getUserData();
        break;
      case NavigateToEditProfileAction():
        streamController.add(NavigateToEditProfileEvent());
      case ChangeLanguageAction():
        streamController.add(ChangeLanguageEvent());
        break;
      case LogoutUserAction():
        _logoutUser();
        break;
      case NavigateToAddressScreenAction():
        streamController.add(NavigateToAddressScreenEvent());
        break;
    }
  }
}
