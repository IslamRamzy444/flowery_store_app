import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/data_sources/local/about_app_local_data_source_contract.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_content.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/domain/repos/about_app_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AboutAppRepoContract)
class AboutAppRepoImpl implements AboutAppRepoContract{
  final AboutAppLocalDataSourceContract _aboutAppLocalDataSourceContract;
  AboutAppRepoImpl(this._aboutAppLocalDataSourceContract);
  @override
  Future<BaseResponse<List<AboutSection>>> getAboutAppInfo() async{
    final response=await _aboutAppLocalDataSourceContract.getAboutAppContent();
    switch(response){
      
      case SuccessResponse<AboutContent>():
        return SuccessResponse<List<AboutSection>>(data: response.data.aboutApp);
      case ErrorResponse<AboutContent>():
        return ErrorResponse<List<AboutSection>>(error: response.error);
    }
  }

}