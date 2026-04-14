import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/orders/data/models/orders_response_model.dart';
import 'package:injectable/injectable.dart';
import '../repositories/orders_repository.dart';

@injectable
class GetUserOrdersUseCase {
  final OrdersRepository _repository;

  GetUserOrdersUseCase(this._repository);
  Future<BaseResponse<OrdersResponseModel>> call() async {
    return await _repository.getUserOrders();
  }
}
