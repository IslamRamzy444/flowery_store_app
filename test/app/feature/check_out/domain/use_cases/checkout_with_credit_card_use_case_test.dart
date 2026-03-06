import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/data/repos/check_out_repo_impl.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/checkout_with_credit_card_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'checkout_with_credit_card_use_case_test.mocks.dart';

@GenerateMocks([CheckOutRepoImpl])
void main() {
  late CheckoutWithCreditCardUseCase cardUseCase;
  late MockCheckOutRepoImpl mockCheckOutRepoImpl;
  setUpAll(() {
    provideDummy<BaseResponse<CreditCardModel>>(SuccessResponse<CreditCardModel>(data: CreditCardModel()));
    mockCheckOutRepoImpl=MockCheckOutRepoImpl();
    cardUseCase=CheckoutWithCreditCardUseCase(mockCheckOutRepoImpl);
  },);
  group('CheckoutWithCreditCardUseCase test cases', () {
    test('making sure that call() working properly', () async{
      final dummyModel=CreditCardModel(
        error: "error1",
        message: "message1",
        url: "url1"
      );
      when(mockCheckOutRepoImpl.checkOutWithCreditCardMethod()).thenAnswer(
        (_) async=> SuccessResponse<CreditCardModel>(data: dummyModel),
      );
      final result=await cardUseCase.call();
      expect(result, isA<SuccessResponse<CreditCardModel>>());
      expect((result as SuccessResponse<CreditCardModel>).data.error, equals(dummyModel.error));
      expect(result.data.message, equals(dummyModel.message));
      expect(result.data.url, equals(dummyModel.url));
      verify(mockCheckOutRepoImpl.checkOutWithCreditCardMethod()).called(1);
    },);
    test('failure case with error response', () async{
      final dummyException=Exception("Network Error");
      when(mockCheckOutRepoImpl.checkOutWithCreditCardMethod()).thenAnswer(
        (_) async=> ErrorResponse<CreditCardModel>(error: dummyException),
      );
      final result=await cardUseCase.call();
      expect(result, isA<ErrorResponse<CreditCardModel>>());
      expect((result as ErrorResponse<CreditCardModel>).error.toString(), equals(dummyException.toString()));
      verify(mockCheckOutRepoImpl.checkOutWithCreditCardMethod()).called(1);
    },);
  },);
}