import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:latlong2/latlong.dart';

class MapFloweryAppStates {
  BaseState<OrderDetailsModel?>? trackingState;
  LatLng? mapCenter;
  bool isMapReady;
  MapFloweryAppStates({this.trackingState,this.mapCenter,this.isMapReady=false});
  MapFloweryAppStates copyWith({
    BaseState<OrderDetailsModel?>? trackingState,
    LatLng? mapCenter,
    bool? isMapReady,
  }){
    return MapFloweryAppStates(
      trackingState: trackingState ?? this.trackingState,
      mapCenter: mapCenter ?? this.mapCenter,
      isMapReady: isMapReady ?? this.isMapReady
    );
  }
}