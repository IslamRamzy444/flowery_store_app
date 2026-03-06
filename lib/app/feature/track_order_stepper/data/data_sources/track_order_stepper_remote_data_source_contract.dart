import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/models/driver_info_model.dart';
import 'package:flutter/material.dart';


abstract class TrackOrderStepperRemoteDataSourceContract {
  Stream<BaseResponse<String?>> getOrderStatus({String? orderId,required BuildContext context});
  Future<BaseResponse<DriverInfoModel?>> getDriverInfo({String? orderId});
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({required BuildContext context,String? orderId});
}