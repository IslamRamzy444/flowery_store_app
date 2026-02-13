import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';

abstract class AboutAppRepoContract {
  Future<BaseResponse<List<AboutSection>>> getAboutAppInfo();
}