import 'dart:async';

import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/domain/use_cases/map_flowery_app_use_case.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_events.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class MapFloweryAppViewModel extends Cubit<MapFloweryAppStates>{
  final MapFloweryAppUseCase _mapFloweryAppUseCase;
  StreamSubscription? _trackingSubscription;
  MapFloweryAppViewModel(this._mapFloweryAppUseCase):super(MapFloweryAppStates());
  void doIntent(MapFloweryAppEvents event){
    switch(event){
      
      case StartTrackingEvent():
        _startTracking(event.orderId);
      case StopTrackingEvent():
        _stopTracking();
      case UpdateTrackingDataEvent():
        _updateTrackingData(event.data);
      case MapReadyEvent():
        _onMapReady();
    }
  }
  void _startTracking(String? orderId){
    emit(state.copyWith(
      trackingState: BaseState<OrderDetailsModel?>(
        isLoading: true
      )
    ));
    final response=_mapFloweryAppUseCase.call(orderId);
    switch(response){
      
      case SuccessResponse<Stream<OrderDetailsModel?>>():
        _listenToStream(response.data);
      case ErrorResponse<Stream<OrderDetailsModel?>>():
        emit(state.copyWith(
          trackingState: BaseState<OrderDetailsModel?>(
            isLoading: false,
            error: response.error
          )
        ));
    }
  }
  void _listenToStream(Stream<OrderDetailsModel?> stream){
    _trackingSubscription=stream.listen(
      (data) {
        if (data != null) {
          final center = data.driverLocation ??
              data.storeLocation ??
              data.clientLocation;
          emit(state.copyWith(
            trackingState: BaseState<OrderDetailsModel?>(
              isLoading: false,
              success: data,
            ),
            mapCenter: center,
          ));
        } else {
          emit(state.copyWith(
            trackingState: BaseState<OrderDetailsModel?>(
              isLoading: false,
              error: Exception("No tracking data found"),
            ),
          ));
        }
      },
      onError: (error){ 
        emit(state.copyWith(
          trackingState: BaseState<OrderDetailsModel?>(
            isLoading: false,
            error: error is Exception ? error :Exception(error.toString())
          )
        ));
      }
    );
  }
  void _updateTrackingData(OrderDetailsModel? data){
    if(data!=null){
      final center=data.driverLocation ?? data.clientLocation ?? data.storeLocation;
      emit(state.copyWith(
        trackingState: BaseState<OrderDetailsModel?>(
          isLoading:  false,
          success: data
        ),
        mapCenter: center
      ));
    }else{
      emit(state.copyWith(
        trackingState: BaseState<OrderDetailsModel?>(
          isLoading: false,
          error: Exception("No tracking data found")
        )
      ));
    }
  }
  void _stopTracking() {
    _trackingSubscription?.cancel();
    _trackingSubscription = null;
  }
  void _onMapReady() {
    emit(state.copyWith(isMapReady: true));
  }
  @override
  Future<void> close() {
    _stopTracking();
    return super.close();
  }
}