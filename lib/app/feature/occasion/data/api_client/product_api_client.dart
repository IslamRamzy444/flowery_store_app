import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;

  @GET(AppEndPoint.products)
  Future<dynamic> getProductsByOccasion(@Query('occasion') String occasionId);
}
