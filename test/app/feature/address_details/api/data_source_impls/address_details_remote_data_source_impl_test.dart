import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/api/data_source_impls/address_details_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/address_details/data/models/add_and_update_addresses_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_details_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AddressDetailsRemoteDataSourceImpl])
void main() {
  late AddressDetailsRemoteDataSourceImpl addressDetailsRemoteDataSourceImpl;
  
  setUpAll(() {
    addressDetailsRemoteDataSourceImpl = MockAddressDetailsRemoteDataSourceImpl();
    provideDummy<BaseResponse<AddAndUpdateAddressesDto>>(SuccessResponse<AddAndUpdateAddressesDto>(data: AddAndUpdateAddressesDto()));
  });

  group("Testing add address function", () {
    test("Testing add address function with success response", () async {
      when(addressDetailsRemoteDataSourceImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<AddAndUpdateAddressesDto>(
            data: AddAndUpdateAddressesDto(message: "success")
          );
        }
      );

      var response = await addressDetailsRemoteDataSourceImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      );
      
      expect(response, isA<SuccessResponse<AddAndUpdateAddressesDto>>());
      expect((response as SuccessResponse<AddAndUpdateAddressesDto>).data.message, equals("success"));
    });

    test("Testing add address function with error response", () async {
      when(addressDetailsRemoteDataSourceImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<AddAndUpdateAddressesDto>(
            error: Exception("Failed to add address")
          );
        }
      );

      var response = await addressDetailsRemoteDataSourceImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      );
      
      expect(response, isA<ErrorResponse<AddAndUpdateAddressesDto>>());
      expect((response as ErrorResponse<AddAndUpdateAddressesDto>).error, isA<Exception>());
    });
  });

  group("Testing update address function", () {
    test("Testing update address function with success response", () async {
      when(addressDetailsRemoteDataSourceImpl.updateAddress(
        addressId: "abc123",
        street: "456 New St",
        phone: "01116668917",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<AddAndUpdateAddressesDto>(
            data: AddAndUpdateAddressesDto(message: "success")
          );
        }
      );

      var response = await addressDetailsRemoteDataSourceImpl.updateAddress(
        addressId: "abc123",
        street: "456 New St",
        phone: "01116668917",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187",
        username: "momen haitham"
      );
      
      expect(response, isA<SuccessResponse<AddAndUpdateAddressesDto>>());
      expect((response as SuccessResponse<AddAndUpdateAddressesDto>).data.message, equals("success"));
    });

    test("Testing update address function with error response", () async {
      when(addressDetailsRemoteDataSourceImpl.updateAddress(
        addressId: "abc123",
        street: "456 New St",
        phone: "01116668917",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<AddAndUpdateAddressesDto>(
            error: Exception("Failed to update address")
          );
        }
      );

      var response = await addressDetailsRemoteDataSourceImpl.updateAddress(
        addressId: "abc123",
        street: "456 New St",
        phone: "01116668917",
        city: "Alexandria",
        lat: "31.2001",
        long: "29.9187",
        username: "momen haitham"
      );
      
      expect(response, isA<ErrorResponse<AddAndUpdateAddressesDto>>());
      expect((response as ErrorResponse<AddAndUpdateAddressesDto>).error, isA<Exception>());
    });
  });
}