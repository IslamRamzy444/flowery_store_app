import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/retrofit.dart';

part 'occasion_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class OccasionApiClient {
  factory OccasionApiClient(Dio dio, {String baseUrl}) = _OccasionApiClient;

  @GET(AppEndPoint.allOccasions)
  Future<dynamic> getAllOccasions();

  @GET('${AppEndPoint.allOccasions}/{id}')
  Future<dynamic> getOccasionById(@Path('id') String id);
}
