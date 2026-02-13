import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';
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
  CheckOutViewModel(this._checkOutUseCase,this._cashOnDeliveryUsecase,this._cardUseCase):super(CheckOutStates());
  void doIntent(CheckOutEvents event){
    switch(event){
      
      case GetUserAddressesEvent():
        _getUserAddresses();
      case PayCashEvent():
        _payCash(street: event.street,phone: event.phone,city: event.city,long: event.long,lat: event.lat);
      case PayCreditEvent():
        _payCredit(street: event.street,phone: event.phone,city: event.city,long: event.long,lat: event.lat);
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
        emit(state.copyWith(
          getAddressesState: BaseState<List<AddressModel>>(
            isLoading: false,
            success: res.data
          )
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
}