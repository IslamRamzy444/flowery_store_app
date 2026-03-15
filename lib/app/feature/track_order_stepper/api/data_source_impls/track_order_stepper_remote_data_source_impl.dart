
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/data_sources/track_order_stepper_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/models/driver_info_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@Injectable(as: TrackOrderStepperRemoteDataSourceContract)
class TrackOrderStepperRemoteDataSourceImpl implements TrackOrderStepperRemoteDataSourceContract{
  @override
  Stream<BaseResponse<String?>> getOrderStatus({String? orderId,required BuildContext context}) {
    return FirebaseFirestore.instance
      .collection('orderDetails')
      .doc(orderId)
      .snapshots()
      .map<BaseResponse<String?>>((event) {
        
        if (!event.exists) {
          if(context.mounted){
            return ErrorResponse<String?>(
              error: Exception(AppLocale(context).no_driver_has_accepted_you_order_yet));
          }
          
        }

        final newEvent = event.data()?['orderState'] as String?;
        return SuccessResponse<String?>(data: newEvent);
      })
      .handleError((error) {
        return ErrorResponse<String?>(error: error);
      });
    
  }

  Future<BaseResponse<DriverInfoModel?>> getDriverInfo({String? orderId})async{
    try{
     return await FirebaseFirestore.instance
      .collection('orderDetails')
      .doc(orderId).get()
      .then((value) {
        return SuccessResponse<DriverInfoModel?>(data: DriverInfoModel.fromJson(value.data()??{}));
      });
      
    }catch(error){
      return ErrorResponse<DriverInfoModel?>(error: error as Exception);
    }
    
  }


  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({required BuildContext context,String? orderId})async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      try{
     var response = await FirebaseFirestore.instance.collection('orderDetails').doc(orderId).update({
      'orderId': orderId,
      
     })
     .then((value) => SuccessResponse<String>(data: ""));
      return response;
    }catch(error){
      //print(error.toString());
      if(error.toString() == "[cloud_firestore/not-found] Some requested document was not found."){
         var response = await FirebaseFirestore.instance.collection('orderDetails').doc(orderId).set({
        'orderId': orderId,
        'orderState': 'Pending',
      })
     .then((value) => SuccessResponse<String>(data: ""));
     return response;
    }
      return ErrorResponse<String>(error: error as Exception);
    }
    } else {
      if(context.mounted){
        return ErrorResponse<String>(error: Exception(AppLocale(context).no_internet_connection));
      }else{
        if(context.mounted){
          return ErrorResponse<String>(error: Exception(AppLocale(context).no_internet_connection));
        }else{
          return ErrorResponse<String>(error: Exception("No internet connection"));
        }
      }
      
    }
    
  }

}