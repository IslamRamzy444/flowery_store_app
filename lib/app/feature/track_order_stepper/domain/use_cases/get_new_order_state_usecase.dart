import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/repo/track_order_stepper_repo_contract.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNewOrderStateUsecase {
  TrackOrderStepperRepoContract trackOrderStepperRepoContract;
  GetNewOrderStateUsecase(this.trackOrderStepperRepoContract);

  Stream<BaseResponse<String?>> call({String? orderId,required BuildContext context}) {
    return trackOrderStepperRepoContract.getOrderStatus(orderId: orderId,context: context);
  }
}