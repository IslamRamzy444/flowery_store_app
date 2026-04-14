import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';

sealed class MapFloweryAppEvents {}
class StartTrackingEvent extends MapFloweryAppEvents{
  final String orderId;
  StartTrackingEvent(this.orderId);
}
class StopTrackingEvent extends MapFloweryAppEvents {}
class UpdateTrackingDataEvent extends MapFloweryAppEvents {
  final OrderDetailsModel? data;
  UpdateTrackingDataEvent(this.data);
}
class MapReadyEvent extends MapFloweryAppEvents {}