import 'package:flower_app/app/config/base_response/base_response.dart';

abstract class TokenRepoContract {
  Future<String?> getToken();

  Future<String?> getDeviceToken();

  Future<BaseResponse<bool>> addDeviceToken(String deviceToken);
  Future<BaseResponse<bool>> clearToken();

  Future<BaseResponse<bool>> clearDeviceToken();
  bool? getRememberMe();

  Future<BaseResponse<bool>> setNotification(bool enable);

  bool? getNotification();
}
