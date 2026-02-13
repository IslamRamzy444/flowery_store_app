import 'package:equatable/equatable.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/profile/domain/model/user_entity.dart';

class ProfileState extends Equatable {
  final BaseState<UserEntity> profileState;
  final bool? isLogout;

  const ProfileState({this.isLogout, required this.profileState});

  ProfileState copyWith({BaseState<UserEntity>? profileState, bool? isLogout}) {
    return ProfileState(
      isLogout: isLogout ?? this.isLogout,
      profileState: BaseState(
        isLoading: profileState?.isLoading ?? this.profileState.isLoading,
        success: profileState?.success ?? this.profileState.success,
        error: profileState?.error ?? this.profileState.error,
      ),
    );
  }

  @override
  List<Object?> get props => [profileState, isLogout];
}

