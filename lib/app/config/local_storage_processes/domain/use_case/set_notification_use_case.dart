import 'package:flower_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../base_response/base_response.dart';

@injectable
class SetNotificationUseCase {
  final TokenRepoContract _repoContract;

  SetNotificationUseCase(this._repoContract);

  Future<BaseResponse<bool>> invoke(bool enable) {
    return _repoContract.setNotification(enable);
  }
}
