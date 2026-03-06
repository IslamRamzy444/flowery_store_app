import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../data/model/categories_response.dart';

part 'categories_api_clients.g.dart';

@RestApi()
abstract class CategoriesApiClient {
  factory CategoriesApiClient(Dio dio, {String baseUrl}) = _CategoriesApiClient;

  @GET(AppEndPoint.allCategories)
  Future<CategoriesResponse> getAllCategories();
}
