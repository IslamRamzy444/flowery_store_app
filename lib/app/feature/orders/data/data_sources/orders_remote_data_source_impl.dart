import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../api_client/orders_api_client.dart';
import '../models/orders_response_model.dart';
import 'orders_remote_data_source.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final OrdersApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<OrdersResponseModel>> getUserOrders() async {
    try {
      final response = await _apiClient.getUserOrders();
      final ordersResponse = OrdersResponseModel.fromJson(response);
      return SuccessResponse(data: ordersResponse);
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }
}
