import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/repo/track_order_stepper_repo_contract.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddNewOrderDocumentToFirebaseUsecase {
  final TrackOrderStepperRepoContract repo;

  AddNewOrderDocumentToFirebaseUsecase({required this.repo});

  Future<BaseResponse<String>> call({required BuildContext context,String? orderId})async {
    return await repo.addNewOrderDocumentToFirebase(context: context,orderId: orderId);
  }
}