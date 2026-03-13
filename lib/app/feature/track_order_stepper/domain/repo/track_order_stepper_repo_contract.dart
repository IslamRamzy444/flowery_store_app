import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';
import 'package:flutter/material.dart';

abstract class TrackOrderStepperRepoContract {
  Stream<BaseResponse<String?>> getOrderStatus({String? orderId,required BuildContext context});
  Future<BaseResponse<DriverInfoToModel?>> getDriverInfo({required BuildContext context,String? orderId});
  Future<BaseResponse<String>> addNewOrderDocumentToFirebase({required BuildContext context,String? orderId});
}