import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/domain/repos/map_flowery_app_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class MapFloweryAppUseCase {
  final MapFloweryAppRepoContract _mapFloweryAppRepoContract;
  MapFloweryAppUseCase(this._mapFloweryAppRepoContract);
  BaseResponse<Stream<OrderDetailsModel?>> call(String? orderId){
    if (orderId!.isEmpty) {
      return ErrorResponse<Stream<OrderDetailsModel?>>(
        error: Exception('Order ID cannot be empty'),
      );
    }
    return _mapFloweryAppRepoContract.getOrderTrackingStream(orderId);
  }
}