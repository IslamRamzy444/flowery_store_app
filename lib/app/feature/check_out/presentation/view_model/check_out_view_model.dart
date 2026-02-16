import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/core/consts/app_consts.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/payment_method_model.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/checkout_with_cash_on_delivery_usecase.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/checkout_with_credit_card_use_case.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/get_user_addresses_use_case.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_events.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class CheckOutViewModel extends Cubit<CheckOutStates>{
  final GetUserAddressesUseCase _checkOutUseCase;
  final CheckoutWithCashOnDeliveryUsecase _cashOnDeliveryUsecase;
  final CheckoutWithCreditCardUseCase _cardUseCase;
  final List<PaymentMethodModel> paymentMethods=[
    PaymentMethodModel(key: AppConsts.cashOptionKey,name: 'Cash on delivery'),
    PaymentMethodModel(key: AppConsts.creditOptionKey,name: 'Credit card')
  ];
  CheckOutViewModel(this._checkOutUseCase,this._cashOnDeliveryUsecase,this._cardUseCase):super(CheckOutStates()){
    if (paymentMethods.isNotEmpty) {
      emit(state.copyWith(
        selectedPaymentMethod: paymentMethods.first.key,
      ));
    }
  }
  Future<void> doIntent(CheckOutEvents event)async{
    switch(event){
      
      case GetUserAddressesEvent():
        _getUserAddresses();
      case PayCashEvent():
        _payCash(street: event.street,phone: event.phone,city: event.city,long: event.long,lat: event.lat);
      case PayCreditEvent():
        _payCredit(street: event.street,phone: event.phone,city: event.city,long: event.long,lat: event.lat);
      case SelectAddressEvent():
        _selectAddress(event.address);
      case SelectPaymentMethodEvent():
        _selectPaymentMethod(event.paymentMethodKey);
    }
  }
  Future<void> _getUserAddresses() async{
    emit(state.copyWith(
      getAddressesState: BaseState<List<AddressModel>>(
        isLoading: true
      )
    ));
    final res=await _checkOutUseCase.call();
    switch(res){
      
      case SuccessResponse<List<AddressModel>>():
        AddressModel? selectedAddress = state.selectedAddress;
        if (selectedAddress == null && res.data.isNotEmpty) {
          selectedAddress = res.data.first;
        }
        emit(state.copyWith(
          getAddressesState: BaseState<List<AddressModel>>(
            isLoading: false,
            success: res.data
          ),
          selectedAddress: selectedAddress
        ));
      case ErrorResponse<List<AddressModel>>():
        emit(state.copyWith(
          getAddressesState: BaseState<List<AddressModel>>(
            isLoading: false,
            error: res.error
          )
        ));
    }
  }
  Future<void> _payCash({String? street,String? phone,String? city,String? lat,String? long}) async{
    emit(state.copyWith(
      payCashState: BaseState<CashOnDeliveryModel>(
        isLoading: true
      )
    ));
    final res=await _cashOnDeliveryUsecase.call(street: street,phone: phone,city: city,lat: lat,long: long);
    switch(res){
      
      case SuccessResponse<CashOnDeliveryModel>():
        emit(state.copyWith(
          payCashState: BaseState<CashOnDeliveryModel>(
            isLoading: false,
            success: res.data
          )
        ));
      case ErrorResponse<CashOnDeliveryModel>():
        emit(state.copyWith(
          payCashState: BaseState<CashOnDeliveryModel>(
            isLoading: false,
            error: res.error
          )
        ));
    }
  }
  Future<void> _payCredit({String? street,String? phone,String? city,String? lat,String? long}) async{
    emit(state.copyWith(
      payCreditState: BaseState<CreditCardModel>(
        isLoading: true
      )
    ));
    final res=await _cardUseCase.call(street: street,phone: phone,city: city,lat: lat,long: long);
    switch(res){
      
      case SuccessResponse<CreditCardModel>():
        emit(state.copyWith(
          payCreditState: BaseState<CreditCardModel>(
            isLoading: false,
            success: res.data
          )
        ));
      case ErrorResponse<CreditCardModel>():
        emit(state.copyWith(
          payCreditState: BaseState<CreditCardModel>(
            isLoading: false,
            error: res.error
          )
        ));
    }
  }
  Future<void> _selectAddress(AddressModel? address)async{
    emit(state.copyWith(
      selectedAddress: address
    ));
  }
   Future<void> _selectPaymentMethod(String paymentMethodKey) async{ 
    emit(state.copyWith(
      selectedPaymentMethod: paymentMethodKey,
    ));
  }
}