import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_content.dart';

abstract class AboutAppLocalDataSourceContract {
  Future<BaseResponse<AboutContent>> getAboutAppContent();
}