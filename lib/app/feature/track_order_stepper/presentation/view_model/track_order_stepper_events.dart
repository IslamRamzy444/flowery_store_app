import 'package:flutter/material.dart';

sealed class TrackOrderStepperEvents {}

class GetOrderStateEvent extends TrackOrderStepperEvents {
  String? orderId;
  BuildContext context;
  GetOrderStateEvent({this.orderId,required this.context});
}

class GetDriverInfoEvent extends TrackOrderStepperEvents {
  BuildContext context;
  String? orderId;
  GetDriverInfoEvent({required this.context,this.orderId});
}

class AddNewOrderDocumentToFirebaseEvent extends TrackOrderStepperEvents {
  String? orderId;
  BuildContext context;
  AddNewOrderDocumentToFirebaseEvent({this.orderId,required this.context});
}