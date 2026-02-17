import '../../base_response/base_response.dart';

abstract class StorageDataSourceContract {
  Future<String?> getToken();

  Future<String?> getDeviceToken();

  Future<BaseResponse<bool>> addToken(String token);

  Future<BaseResponse<bool>> addDeviceToken(String token);

  Future<BaseResponse<bool>> addRememberMe(bool rememberMe);

  bool? getRememberMe();

  Future<BaseResponse<bool>> clearToken();

  Future<BaseResponse<bool>> clearDeviceToken();

  Future<BaseResponse<bool>> clearRememberMe();

  Future<BaseResponse<bool>> setNotification(bool enable);

  bool? getNotification();
}
