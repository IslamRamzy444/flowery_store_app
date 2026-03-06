import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/repo/track_order_stepper_repo_contract.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDriverInfoUsecase {
  TrackOrderStepperRepoContract trackOrderStepperRepoContract;
  GetDriverInfoUsecase(this.trackOrderStepperRepoContract);

  Future<BaseResponse<DriverInfoToModel?>> call({required BuildContext context,String? orderId}) async{
    return await trackOrderStepperRepoContract.getDriverInfo(orderId: orderId,context: context);
  }
}