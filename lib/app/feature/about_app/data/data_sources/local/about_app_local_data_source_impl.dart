import 'dart:convert';

import 'package:flower_app/app/config/api_utils/api_utils.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/feature/about_app/data/data_sources/local/about_app_local_data_source_contract.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_content.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AboutAppLocalDataSourceContract)
class AboutAppLocalDataSourceImpl implements AboutAppLocalDataSourceContract{
  @override
  Future<BaseResponse<AboutContent>> getAboutAppContent() async{
    return executeApi(() async{
      final jsonString=await rootBundle.loadString(AssetsFiles.aboutAppFile);
      final jsonMap=jsonDecode(jsonString) as Map<String,dynamic>;
      return AboutContent.fromJson(jsonMap);
    },);
  }
}