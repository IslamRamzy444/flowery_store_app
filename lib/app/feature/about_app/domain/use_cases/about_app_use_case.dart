import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/domain/repos/about_app_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class AboutAppUseCase {
  final AboutAppRepoContract _aboutAppRepoContract;
  AboutAppUseCase(this._aboutAppRepoContract);
  Future<BaseResponse<List<AboutSection>>> call()async{
    return _aboutAppRepoContract.getAboutAppInfo();
  }
}