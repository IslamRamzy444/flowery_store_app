import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/api/data_sources/remote/check_out_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/check_out/data/models/address_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/cash_on_delivery_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/credit_card_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/user_address_response.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_out_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CheckOutRemoteDataSourceImpl])
void main() {
  late CheckOutRemoteDataSourceImpl checkOutRemoteDataSourceImpl;

  setUpAll(() {
    checkOutRemoteDataSourceImpl = MockCheckOutRemoteDataSourceImpl();
    provideDummy<BaseResponse<UserAddressResponse>>(SuccessResponse<UserAddressResponse>(data: UserAddressResponse()));
    provideDummy<BaseResponse<CashOnDeliveryDto>>(SuccessResponse<CashOnDeliveryDto>(data: CashOnDeliveryDto()));
    provideDummy<BaseResponse<CreditCardDto>>(SuccessResponse<CreditCardDto>(data: CreditCardDto()));
  });

  group("Testing get user addresses function", () {
    test("Testing get user addresses function with success response", () async {
      when(checkOutRemoteDataSourceImpl.getUserAddressesResponse()).thenAnswer(
        (_) async {
          return SuccessResponse<UserAddressResponse>(
            data: UserAddressResponse(addresses: [
              AddressDTO(
              city: "Cairo",
              street: "123 Main St",
              lat: "30.0444",
              long: "31.2357",
              id: "1",
              phone: "01234567890"),
              AddressDTO(
              city: "Giza",
              street: "456 Elm St",
              lat: "30.0444",
              long: "31.2357",
              id: "2",              
              phone: "01234567890"
              )
              ])
          );
        }
      );

      BaseResponse<UserAddressResponse> response = await checkOutRemoteDataSourceImpl.getUserAddressesResponse();
      expect((response as SuccessResponse<UserAddressResponse>).data.addresses, isNotNull);
      expect(response, isA<SuccessResponse<UserAddressResponse>>());
    });

    test("Testing get user addresses function with error response", () async {
      when(checkOutRemoteDataSourceImpl.getUserAddressesResponse()).thenAnswer(
        (_) async {
          return ErrorResponse<UserAddressResponse>(
            error: Exception("Failed to get user addresses")
          );
        }
      );

      var response = await checkOutRemoteDataSourceImpl.getUserAddressesResponse();
      expect(response, isA<ErrorResponse<UserAddressResponse>>());
      expect((response as ErrorResponse<UserAddressResponse>).error, isA<Exception>());
    });
  });

  group("Testing checkout with cash on delivery function", () {
    test("Testing checkout with cash on delivery function with success response", () async {
      when(checkOutRemoteDataSourceImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<CashOnDeliveryDto>(
            data: CashOnDeliveryDto()
          );
        }
      );

      var response = await checkOutRemoteDataSourceImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      );
      
      expect(response, isA<SuccessResponse<CashOnDeliveryDto>>());
    });

    test("Testing checkout with cash on delivery function with error response", () async {
      when(checkOutRemoteDataSourceImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<CashOnDeliveryDto>(
            error: Exception("Failed to checkout with cash on delivery")
          );
        }
      );

      var response = await checkOutRemoteDataSourceImpl.checkOutWithCashOnDeliveryMethod(
        street: "123 Main St",
        phone: "01234567890",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357"
      );
      
      expect(response, isA<ErrorResponse<CashOnDeliveryDto>>());
      expect((response as ErrorResponse<CashOnDeliveryDto>).error, isA<Exception>());
    });
  });

  group("Testing checkout with credit card function", () {
    test("Testing checkout with credit card function with success response", () async {
      when(checkOutRemoteDataSourceImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      )).thenAnswer(
        (_) async {
          return await SuccessResponse<CreditCardDto>(
            data: CreditCardDto(session: Session(url: "https://example.com/checkout"))
          );
        }
      );

      final response =await  checkOutRemoteDataSourceImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      );
      
      expect((response as SuccessResponse<CreditCardDto>).data.session?.url, isNotNull);
      expect(response, isA<SuccessResponse<CreditCardDto>>());
    });

    test("Testing checkout with credit card function with error response", () async {
      when(checkOutRemoteDataSourceImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<CreditCardDto>(
            error: Exception("Failed to checkout with credit card")
          );
        }
      );

      var response = await checkOutRemoteDataSourceImpl.checkOutWithCreditCardMethod(
        street: "456 New St",
        phone: "01987654321",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187"
      );
      
      expect(response, isA<ErrorResponse<CreditCardDto>>());
      expect((response as ErrorResponse<CreditCardDto>).error, isA<Exception>());
    });
  });
}