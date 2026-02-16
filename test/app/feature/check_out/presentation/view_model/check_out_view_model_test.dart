import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/core/consts/app_consts.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/checkout_with_cash_on_delivery_usecase.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/checkout_with_credit_card_use_case.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/get_user_addresses_use_case.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_events.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_states.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'check_out_view_model_test.mocks.dart';

@GenerateMocks([GetUserAddressesUseCase,CheckoutWithCashOnDeliveryUsecase,CheckoutWithCreditCardUseCase])
void main() {
  late CheckOutViewModel checkOutViewModel;
  late MockCheckoutWithCashOnDeliveryUsecase mockCheckoutWithCashOnDeliveryUsecase;
  late MockGetUserAddressesUseCase mockGetUserAddressesUseCase;
  late MockCheckoutWithCreditCardUseCase mockCheckoutWithCreditCardUseCase;
  setUp(() {
    provideDummy<BaseResponse<List<AddressModel>>>(SuccessResponse<List<AddressModel>>(data: []));
    provideDummy<BaseResponse<CashOnDeliveryModel>>(SuccessResponse<CashOnDeliveryModel>(data: CashOnDeliveryModel()));
    provideDummy<BaseResponse<CreditCardModel>>(SuccessResponse<CreditCardModel>(data: CreditCardModel()));
    mockCheckoutWithCashOnDeliveryUsecase=MockCheckoutWithCashOnDeliveryUsecase();
    mockGetUserAddressesUseCase=MockGetUserAddressesUseCase();
    mockCheckoutWithCreditCardUseCase=MockCheckoutWithCreditCardUseCase();
    checkOutViewModel=CheckOutViewModel(mockGetUserAddressesUseCase, mockCheckoutWithCashOnDeliveryUsecase, mockCheckoutWithCreditCardUseCase);
  },);
  tearDownAll(() {
    checkOutViewModel.close();
  },);
  test('initial state should have first payment method selected', () {
    expect(checkOutViewModel.state.selectedPaymentMethod, equals(checkOutViewModel.paymentMethods.first.key));
  });
  group('GetUserAddressesEvent test cases', () {
    test('success case with success response with making sure that the first address will be selected as default', () {
      final dummyAddresses=[AddressModel(id: 'id1',city: 'city1'),AddressModel(id: 'id2',city: 'city2')];
      when(mockGetUserAddressesUseCase.call()).thenAnswer(
        (_) async=>SuccessResponse<List<AddressModel>>(data: dummyAddresses) ,
      );
      expectLater(
        checkOutViewModel.stream,
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) => state.getAddressesState?.isLoading==true,
          ),
          predicate<CheckOutStates>(
            (state) =>state.getAddressesState?.isLoading==false && state.getAddressesState?.success==dummyAddresses && state.selectedAddress==dummyAddresses.first,
          )
        ])
      );
      checkOutViewModel.doIntent(GetUserAddressesEvent());
    },);
    test('should handle empty address list', () {
      when(mockGetUserAddressesUseCase.call()).thenAnswer(
        (_) async => SuccessResponse<List<AddressModel>>(data: []),
      );
      expectLater(
        checkOutViewModel.stream,
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) => state.getAddressesState?.isLoading == true
          ),
          predicate<CheckOutStates>(
            (state) => state.getAddressesState?.isLoading == false && state.getAddressesState?.success?.isEmpty == true && state.selectedAddress == null
          )
        ])
      );
      checkOutViewModel.doIntent(GetUserAddressesEvent());
});
    test('failure case with error response',(){
      final dummyException=Exception("Network Error");
      when(mockGetUserAddressesUseCase.call()).thenAnswer(
        (_) async=>ErrorResponse<List<AddressModel>>(error: dummyException) ,
      );
      expectLater(
        checkOutViewModel.stream, 
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) => state.getAddressesState?.isLoading==true,
          ),
          predicate<CheckOutStates>(
            (state) => state.getAddressesState?.isLoading==false && state.getAddressesState?.error==dummyException,
          )
        ])
      );
      checkOutViewModel.doIntent(GetUserAddressesEvent());
    });
  },);
  group('PayCashEvent test cases', () {
    test('success case with success response', () {
      final dummyModel=CashOnDeliveryModel(
        error: "error 1",
        message: "message 1",
        orderNumber: "order no 1",
        paymentType: "cash"
      );
      String dummyCity="city1";
      String dummyPhone="phone1";
      String dummyLat="lat1";
      String dummyLong="long1";
      String dummyStreet="street1";
      when(mockCheckoutWithCashOnDeliveryUsecase.call(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet)).thenAnswer(
        (_) async=>SuccessResponse<CashOnDeliveryModel>(data: dummyModel) ,
      );
      expectLater(
        checkOutViewModel.stream, 
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) =>state.payCashState?.isLoading==true ,
          ),
          predicate<CheckOutStates>(
            (state) =>state.payCashState?.isLoading==false && state.payCashState?.success==dummyModel ,
          )
        ])
      );
      checkOutViewModel.doIntent(PayCashEvent(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet));
    },);
    test('failure case with error response', () {
      final dummyException=Exception("Dummy Error");
      String dummyCity="city1";
      String dummyPhone="phone1";
      String dummyLat="lat1";
      String dummyLong="long1";
      String dummyStreet="street1";
      when(mockCheckoutWithCashOnDeliveryUsecase.call(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet)).thenAnswer(
        (_) async=>ErrorResponse<CashOnDeliveryModel>(error: dummyException) ,
      );
      expectLater(
        checkOutViewModel.stream, 
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) =>state.payCashState?.isLoading==true ,
          ),
          predicate<CheckOutStates>(
            (state) =>state.payCashState?.isLoading==false && state.payCashState?.error==dummyException ,
          )
        ])
      );
      checkOutViewModel.doIntent(PayCashEvent(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet));
    },);
  },);
  group('PayCreditEvent test cases', () {
    test('success case with success response', () {
      final dummyModel=CreditCardModel(
        error: "error 1",
        message: "message 1",
        url: "url 1"
      );
      String dummyCity="city1";
      String dummyPhone="phone1";
      String dummyLat="lat1";
      String dummyLong="long1";
      String dummyStreet="street1";
      when(mockCheckoutWithCreditCardUseCase.call(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet)).thenAnswer(
        (_) async=>SuccessResponse<CreditCardModel>(data: dummyModel) ,
      );
      expectLater(
        checkOutViewModel.stream, 
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) =>state.payCreditState?.isLoading==true ,
          ),
          predicate<CheckOutStates>(
            (state) =>state.payCreditState?.isLoading==false && state.payCreditState?.success==dummyModel ,
          )
        ])
      );
      checkOutViewModel.doIntent(PayCreditEvent(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet));
    },);
    test('error case with error response', () {
      final dummyException=Exception("Dummy Error");
      String dummyCity="city1";
      String dummyPhone="phone1";
      String dummyLat="lat1";
      String dummyLong="long1";
      String dummyStreet="street1";
      when(mockCheckoutWithCreditCardUseCase.call(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet)).thenAnswer(
        (_) async=>ErrorResponse<CreditCardModel>(error: dummyException) ,
      );
      expectLater(
        checkOutViewModel.stream, 
        emitsInOrder([
          predicate<CheckOutStates>(
            (state) =>state.payCreditState?.isLoading==true ,
          ),
          predicate<CheckOutStates>(
            (state) =>state.payCreditState?.isLoading==false && state.payCreditState?.error==dummyException ,
          )
        ])
      );
      checkOutViewModel.doIntent(PayCreditEvent(city: dummyCity,lat: dummyLat,long: dummyLong,phone: dummyPhone,street: dummyStreet));
    },);
  },);
  group('SelectAddressEvent test cases', () {
    test('making sure address selected is mutated with state', () {
      final selectedDummyAddress=AddressModel(id: 'id1',city: 'city1');
      expectLater(
        checkOutViewModel.stream, 
        emits(
          predicate<CheckOutStates>(
            (state) =>state.selectedAddress==selectedDummyAddress ,
          )
        )
      );
      checkOutViewModel.doIntent(SelectAddressEvent(selectedDummyAddress));
    },);
  },);
  group('SelectPaymentMethodEvent test cases', () {
    test('making sure that payment method selected is mutated with state', () {
      String paymentMethod=AppConsts.cashOptionKey;
      expectLater(
        checkOutViewModel.stream, 
        emits(
          predicate<CheckOutStates>(
            (state) =>state.selectedPaymentMethod==paymentMethod ,
          )
        )
      );
      checkOutViewModel.doIntent(SelectPaymentMethodEvent(paymentMethod));
    },);
  },);
}