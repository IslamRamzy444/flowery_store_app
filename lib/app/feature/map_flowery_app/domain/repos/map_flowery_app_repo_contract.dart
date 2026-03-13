import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';

abstract class MapFloweryAppRepoContract {
  BaseResponse<Stream<OrderDetailsModel?>> getOrderTrackingStream(String? orderId);
}