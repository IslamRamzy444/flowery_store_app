import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'orders_api_client.dart';

@module
abstract class OrdersApiModule {
  @injectable
  OrdersApiClient ordersApiClient(Dio dio) => OrdersApiClient(dio);
}
