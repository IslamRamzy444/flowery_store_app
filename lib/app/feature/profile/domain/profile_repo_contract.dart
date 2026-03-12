import 'dart:io';

import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/profile/domain/request/update_profile_request.dart';

import '../domain/request/change_password_request.dart';
import 'model/user_entity.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<UserEntity>> getProfile();
  Future<BaseResponse<String>> updateProfile(UpdateProfileRequest request);
  Future<BaseResponse<String>> uploadPhoto(File file);
  Future<BaseResponse<String>> changePassword(
    ChangePasswordRequest changePasswordRequest,
  );
}
