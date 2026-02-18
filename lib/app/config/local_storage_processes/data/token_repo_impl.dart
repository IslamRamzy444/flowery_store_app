import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../domain/storage_data_source_contract.dart';
import '../domain/token_repo_contract.dart';

@Injectable(as: TokenRepoContract)
class TokenRepoImpl extends TokenRepoContract {
  final StorageDataSourceContract _contract;

  TokenRepoImpl(this._contract);

  @override
  Future<BaseResponse<bool>> clearToken() async {
    await _contract.clearRememberMe();
    return _contract.clearToken();
  }

  @override
  bool? getRememberMe() {
    return _contract.getRememberMe();
  }

  @override
  Future<String?> getToken() {
    return _contract.getToken();
  }

  @override
  Future<String?> getDeviceToken() {
    return _contract.getDeviceToken();
  }

  @override
  Future<BaseResponse<bool>> clearDeviceToken() {
    return _contract.clearDeviceToken();
  }

  @override
  Future<BaseResponse<bool>> addDeviceToken(String deviceToken) {
    return _contract.addDeviceToken(deviceToken);
  }

  @override
  Future<BaseResponse<bool>> setNotification(bool enable) {
    return _contract.setNotification(enable);
  }

  @override
  bool? getNotification() {
    return _contract.getNotification();
  }
}
