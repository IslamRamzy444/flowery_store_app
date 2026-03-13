import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';

class TrackOrderStepperStates {
  BaseState<int?>? orderState;
  BaseState<DriverInfoToModel?>? driverInfoState;
  TrackOrderStepperStates({this.orderState,this.driverInfoState});

  TrackOrderStepperStates copyWith({BaseState<int?>? orderStateNew,BaseState<DriverInfoToModel?>? driverInfoStateNew}){
    return TrackOrderStepperStates(
      orderState: orderStateNew ?? orderState,
      driverInfoState: driverInfoStateNew ?? driverInfoState
    );
  }
}