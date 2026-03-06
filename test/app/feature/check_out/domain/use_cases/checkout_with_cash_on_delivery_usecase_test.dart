import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/data/repos/check_out_repo_impl.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/checkout_with_cash_on_delivery_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'checkout_with_cash_on_delivery_usecase_test.mocks.dart';

@GenerateMocks([CheckOutRepoImpl])
void main() {
  late CheckoutWithCashOnDeliveryUsecase cashOnDeliveryUsecase;
  late MockCheckOutRepoImpl mockCheckOutRepoImpl;
  setUpAll(() {
    provideDummy<BaseResponse<CashOnDeliveryModel>>(SuccessResponse<CashOnDeliveryModel>(data: CashOnDeliveryModel()));
    mockCheckOutRepoImpl=MockCheckOutRepoImpl();
    cashOnDeliveryUsecase=CheckoutWithCashOnDeliveryUsecase(mockCheckOutRepoImpl);
  },);
  group('CheckoutWithCashOnDeliveryUsecase test cases', () {
    test('making sure that call() works properly', () async{
      final dummyModel=CashOnDeliveryModel(
        error: "error 1",
        message: "message 1",
        orderNumber: "order no1",
        paymentType: "cash"
      );
      when(mockCheckOutRepoImpl.checkOutWithCashOnDeliveryMethod()).thenAnswer(
        (_) async=>SuccessResponse<CashOnDeliveryModel>(data: dummyModel) ,
      );
      final result=await cashOnDeliveryUsecase.call();
      expect(result, isA<SuccessResponse<CashOnDeliveryModel>>());
      expect((result as SuccessResponse<CashOnDeliveryModel>).data.error, equals(dummyModel.error));
      expect(result.data.message, equals(dummyModel.message));
      expect(result.data.orderNumber, equals(dummyModel.orderNumber));
      expect(result.data.paymentType, equals(dummyModel.paymentType));
      verify(mockCheckOutRepoImpl.checkOutWithCashOnDeliveryMethod()).called(1);
    },);
    test('failure case with error response', () async{
      final dummyError=Exception("Network Error");
      when(mockCheckOutRepoImpl.checkOutWithCashOnDeliveryMethod()).thenAnswer(
        (_) async=>ErrorResponse<CashOnDeliveryModel>(error: dummyError) ,
      );
      final result=await cashOnDeliveryUsecase.call();
      expect(result, isA<ErrorResponse<CashOnDeliveryModel>>());
      expect((result as ErrorResponse<CashOnDeliveryModel>).error.toString(), equals(dummyError.toString()));
      verify(mockCheckOutRepoImpl.checkOutWithCashOnDeliveryMethod()).called(1);
    },);
  },);
}