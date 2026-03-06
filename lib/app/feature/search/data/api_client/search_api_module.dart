import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'search_api_client.dart';

@module
abstract class SearchApiModule {
  @lazySingleton
  SearchApiClient searchApiClient(Dio dio) => SearchApiClient(dio);
}
