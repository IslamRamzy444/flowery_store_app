import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/orders_repository.dart';
import '../data_sources/orders_remote_data_source.dart';
import '../models/orders_response_model.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<OrdersResponseModel>> getUserOrders() async {
    var response = await _remoteDataSource.getUserOrders();
    switch (response) {
      case SuccessResponse<OrdersResponseModel>():
        print(response.data);
        print(response.data);
        print(response.data);
        return SuccessResponse<OrdersResponseModel>(data: response.data);
      case ErrorResponse<OrdersResponseModel>():
        return ErrorResponse<OrdersResponseModel>(error: response.error);
    }
  }
}
