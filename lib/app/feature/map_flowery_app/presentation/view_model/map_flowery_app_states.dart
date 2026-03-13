import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:latlong2/latlong.dart';

class MapFloweryAppStates {
  BaseState<OrderDetailsModel?>? trackingState;
  BaseState<int?>? switchTrackingState;
  LatLng? mapCenter;
  bool isMapReady;
  MapFloweryAppStates({this.trackingState,this.mapCenter,this.isMapReady=false,this.switchTrackingState});
  MapFloweryAppStates copyWith({
    BaseState<OrderDetailsModel?>? trackingState,
    BaseState<int?>? switchTrackingState,
    LatLng? mapCenter,
    bool? isMapReady,
  }){
    return MapFloweryAppStates(
      trackingState: trackingState ?? this.trackingState,
      switchTrackingState: switchTrackingState ?? this.switchTrackingState,
      mapCenter: mapCenter ?? this.mapCenter,
      isMapReady: isMapReady ?? this.isMapReady
    );
  }
}