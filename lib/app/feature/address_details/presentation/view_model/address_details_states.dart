import 'package:flower_app/app/config/base_state/base_state.dart';


class AddressDetailsStates {
  BaseState<String>? addressDetailsState;
  BaseState<String>? firstBuildState;

  AddressDetailsStates({this.addressDetailsState,this.firstBuildState});

  AddressDetailsStates copyWith({BaseState<String>? addressDetailsStateNew,BaseState<String>? firstBuildStateNew}) {
    return AddressDetailsStates(
      addressDetailsState: addressDetailsStateNew ?? addressDetailsState,
      firstBuildState: firstBuildStateNew ?? firstBuildState,
    );
  }
}