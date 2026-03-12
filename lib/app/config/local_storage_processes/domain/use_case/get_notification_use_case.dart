import 'package:flower_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationUseCase {
  final TokenRepoContract _repoContract;

  GetNotificationUseCase(this._repoContract);

  bool? invoke() {
    return _repoContract.getNotification();
  }
}
