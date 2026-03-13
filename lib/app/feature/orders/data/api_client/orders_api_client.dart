import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/retrofit.dart';

part 'orders_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class OrdersApiClient {
  factory OrdersApiClient(Dio dio, {String baseUrl}) = _OrdersApiClient;

  @GET(AppEndPoint.orders)
  Future<dynamic> getUserOrders();
}
