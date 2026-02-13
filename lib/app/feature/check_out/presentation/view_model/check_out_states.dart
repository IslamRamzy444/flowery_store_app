import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';

class CheckOutStates {
  BaseState<List<AddressModel>>? getAddressesState;
  BaseState<CashOnDeliveryModel>? payCashState;
  BaseState<CreditCardModel>? payCreditState;
  CheckOutStates({this.getAddressesState,this.payCashState,this.payCreditState});
  CheckOutStates copyWith({
    BaseState<List<AddressModel>>? getAddressesState,
    BaseState<CashOnDeliveryModel>? payCashState,
    BaseState<CreditCardModel>? payCreditState
    }){
    return CheckOutStates(
      getAddressesState: getAddressesState ?? this.getAddressesState,
      payCashState: payCashState ?? this.payCashState,
      payCreditState: payCreditState ?? this.payCreditState
    );
  }
}