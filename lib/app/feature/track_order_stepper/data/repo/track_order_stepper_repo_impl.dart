import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/data_sources/track_order_stepper_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/models/driver_info_model.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/repo/track_order_stepper_repo_contract.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderStepperRepoContract)
class TrackOrderStepperRepoImpl extends TrackOrderStepperRepoContract{
  TrackOrderStepperRemoteDataSourceContract remoteDataSource;
  TrackOrderStepperRepoImpl(this.remoteDataSource);
  @override
  Stream<BaseResponse<String?>> getOrderStatus({String? orderId,required BuildContext context}) {
    return remoteDataSource.getOrderStatus(orderId: orderId,context: context);
  }
  
  @override
  Future<BaseResponse<DriverInfoToModel?>> getDriverInfo({required BuildContext context,String? orderId})async {
    var response = await remoteDataSource.getDriverInfo(orderId: orderId);
    switch(response){
      case SuccessResponse<DriverInfoModel?>():
        if(response.data?.driverName!=null){
          return SuccessResponse(data: response.data!.toDriverInfoToModel());
        }else{
          //print(Exception("Driver Not Found")) ;
          if(context.mounted){
            return ErrorResponse(error: Exception(AppLocale(context).no_driver_has_accepted_you_order_yet));
          }else{
            return ErrorResponse(error: Exception("No driver has accepted your order yet"));
          }
          
          
        }
      case ErrorResponse<DriverInfoModel?>():
        return ErrorResponse(error: response.error);
    } 
  }
  
  @override
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({required BuildContext context, String? orderId}) {
    return remoteDataSource.addNewOrderDocumentToFirebase(context: context,orderId: orderId);
  }

}