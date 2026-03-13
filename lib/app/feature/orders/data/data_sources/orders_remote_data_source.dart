import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/orders/data/models/orders_response_model.dart';

abstract class OrdersRemoteDataSource {
  Future<BaseResponse<OrdersResponseModel>> getUserOrders();
}
