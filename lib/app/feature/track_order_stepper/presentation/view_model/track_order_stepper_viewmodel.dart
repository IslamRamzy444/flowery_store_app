import 'dart:async';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/use_cases/add_new_order_document_to_firebase_usecase.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/use_cases/get_driver_info_usecase.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/use_cases/get_new_order_state_usecase.dart';
import 'package:flower_app/app/feature/track_order_stepper/presentation/view_model/track_order_stepper_events.dart';
import 'package:flower_app/app/feature/track_order_stepper/presentation/view_model/track_order_stepper_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class TrackOrderStepperViewmodel extends Cubit<TrackOrderStepperStates>{
  GetNewOrderStateUsecase _getNewOrderStateUsecase;
  GetDriverInfoUsecase _getDriverInfoUsecase;
  AddNewOrderDocumentToFirebaseUsecase _addNewOrderDocumentToFirebaseUsecase;
  StreamSubscription? subscription;
  int? activeStep = 0;
  String? currentStep;
  bool firstTime=true;
  TrackOrderStepperViewmodel(this._addNewOrderDocumentToFirebaseUsecase,this._getNewOrderStateUsecase,this._getDriverInfoUsecase): super(TrackOrderStepperStates());

  void doIntent(TrackOrderStepperEvents event){
    switch(event){
      
      case GetOrderStateEvent():
        _getNewOrderState(orderId: event.orderId,context: event.context);
      case GetDriverInfoEvent():
        _getDriverInfo(orderId: event.orderId,context: event.context);
      case AddNewOrderDocumentToFirebaseEvent():
        _addNewOrderDocumentToFirebase(context: event.context,orderId: event.orderId);
    }
  }

  void _getNewOrderState({String? orderId,required BuildContext context}) async{
    
    
    //subscription?.cancel();
    subscription = _getNewOrderStateUsecase.call(orderId: orderId,context: context).listen((event) {
      switch(event){
        
        case SuccessResponse<String?>():
          activeStep=editOrderState(event.data);
          currentStep=event.data;
          if(currentStep=="Accepted"){
              _getDriverInfo(orderId: orderId,context: context);
              print("Reppeated NIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGEEEEEEEEEEEEEERRRRRRRRRRRRR");
          }
          emit(state.copyWith(orderStateNew: BaseState(success: activeStep,isLoading: false)));
        case ErrorResponse<String?>():
          emit(state.copyWith(orderStateNew: BaseState(error: event.error,isLoading: false)));
      }
    });
  }

  void _getDriverInfo({required BuildContext context,String? orderId})async {
    emit(state.copyWith(driverInfoStateNew: BaseState(isLoading: true)));
    await _getDriverInfoUsecase.call(orderId: orderId,context: context).then((event) {
      switch(event){
        case SuccessResponse<DriverInfoToModel?>():
        
          emit(state.copyWith(driverInfoStateNew: BaseState(success: event.data,isLoading: false)));
          
        case ErrorResponse<DriverInfoToModel?>():
          emit(state.copyWith(driverInfoStateNew: BaseState(error: event.error,isLoading: false)));
        
      }
    });
  }
  
  void _addNewOrderDocumentToFirebase({required BuildContext context,String? orderId})async{
    emit(state.copyWith(orderStateNew: BaseState(isLoading: true)));
    await _addNewOrderDocumentToFirebaseUsecase.call(context: context,orderId: orderId).then((event) {
      switch(event){
        case SuccessResponse<String>():
          
          return;
        case ErrorResponse<String>():
          emit(state.copyWith(orderStateNew: BaseState(error: event.error,isLoading: false)));
        
      }
    });
  }

  int? editOrderState(String? state){
    print(state);
    if(state=="Pending"){
      return 0;
    }else if (state=="Accepted"){
      return 0;
    }else if(state=="Picked"){
      return 1;
    }else if(state=="Out For Delivery"){
      return 2;
    }else if(state=="Arrived"){
      return 2;
    }else if(state=="Delivered"){
      return 3;
    }
    return null;
  }
  String getFormattedNow() {
  final now = DateTime.now();
  final formatter = DateFormat('dd MMM yyyy - h:mm');
  return formatter.format(now);
  }
  String getFormattedEstimated() {
  final now = DateTime.now().add(Duration(hours:3 ));
  final formatter = DateFormat('dd MMM yyyy - h:mm');
  return formatter.format(now);
  }
}