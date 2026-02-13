import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/data/repos/check_out_repo_impl.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_repo_impl_test.mocks.dart';

@GenerateMocks([CheckOutRepoImpl])
void main() {
  late CheckOutRepoImpl checkOutRepoImpl;

  setUpAll(() {
    checkOutRepoImpl = MockCheckOutRepoImpl();
    provideDummy<BaseResponse<List<AddressModel>>>(SuccessResponse<List<AddressModel>>(data: []));
    provideDummy<BaseResponse<CashOnDeliveryModel>>(SuccessResponse<CashOnDeliveryModel>(data: CashOnDeliveryModel()));
    provideDummy<BaseResponse<CreditCardModel>>(SuccessResponse<CreditCardModel>(data: CreditCardModel()));
  });

  group("Testing get user addresses function", () {
    test("Testing get user addresses function with success response", () async {
      when(checkOutRepoImpl.getUserAddresses()).thenAnswer(
        (_) async {
          return SuccessResponse<List<AddressModel>>(
            data: [
              AddressModel(
                city: "Cairo",
                street: "123 Main St",
                lat: "30.0444",
                long: "31.2357",
                id: "1",
              ),
              AddressModel(
                city: "Giza",
                street: "456 Elm St",
                lat: "30.0444",
                long: "31.2357",
                id: "2",
              )
            ]
          );
        }
      );

      BaseResponse<List<AddressModel>> response = await checkOutRepoImpl.getUserAddresses();
      expect((response as SuccessResponse<List<AddressModel>>).data, isNotNull);
      expect(response.data.length, equals(2));
      expect(response, isA<SuccessResponse<List<AddressModel>>>());
    });

    test("Testing get user addresses function with error response", () async {
      when(checkOutRepoImpl.getUserAddresses()).thenAnswer(
        (_) async {
          return ErrorResponse<List<AddressModel>>(
            error: Exception("Failed to get user addresses")
          );
        }
      );

      var response = await checkOutRepoImpl.getUserAddresses();
      expect(response, isA<ErrorResponse<List<AddressModel>>>());
      expect((response as ErrorResponse<List<AddressModel>>).error, isA<Exception>());
    });
  });

  group("Testing checkout with cash on delivery function", () {
    test("Testing checkout with cash on delivery function with success response", () async {
      when(checkOutRepoImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<CashOnDeliveryModel>(
            data: CashOnDeliveryModel()
          );
        }
      );

      var response = await checkOutRepoImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      );

      expect(response, isA<SuccessResponse<CashOnDeliveryModel>>());
    });

    test("Testing checkout with cash on delivery function with error response", () async {
      when(checkOutRepoImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<CashOnDeliveryModel>(
            error: Exception("Failed to checkout with cash on delivery")
          );
        }
      );

      var response = await checkOutRepoImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      );

      expect(response, isA<ErrorResponse<CashOnDeliveryModel>>());
      expect((response as ErrorResponse<CashOnDeliveryModel>).error, isA<Exception>());
    });
  });

  group("Testing checkout with credit card function", () {
    test("Testing checkout with credit card function with success response", () async {
      when(checkOutRepoImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<CreditCardModel>(
            data: CreditCardModel(url: "https://example.com/checkout")
          );
        }
      );

      final response = await checkOutRepoImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      );

      expect((response as SuccessResponse<CreditCardModel>).data.url, isNotNull);
      expect(response, isA<SuccessResponse<CreditCardModel>>());
    });

    test("Testing checkout with credit card function with error response", () async {
      when(checkOutRepoImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<CreditCardModel>(
            error: Exception("Failed to checkout with credit card")
          );
        }
      );

      var response = await checkOutRepoImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      );

      expect(response, isA<ErrorResponse<CreditCardModel>>());
      expect((response as ErrorResponse<CreditCardModel>).error, isA<Exception>());
    });
  });
}