import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/retrofit.dart';

part 'search_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class SearchApiClient {
  factory SearchApiClient(Dio dio, {String baseUrl}) = _SearchApiClient;

  @GET(AppEndPoint.productsList)
  Future<dynamic> searchProducts(@Query('keyword') String keyword);
}
