import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/data/repo/address_details_repo_impl.dart';
import 'package:flower_app/app/feature/address_details/domain/models/cities_model.dart';
import 'package:flower_app/app/feature/address_details/domain/models/states_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_details_repo_impl_test.mocks.dart';



@GenerateMocks([AddressDetailsRepoImpl])
void main() {
  AddressDetailsRepoImpl addressDetailsRepoImpl = MockAddressDetailsRepoImpl();
  setUpAll(() {
    
    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: "Address added successfully"));  
  });

  group("testing addAddress function", () {
    test("testing addAddress function with success response", () async{

      when(addressDetailsRepoImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Address added successfully");
        }
      );

      var response = await addressDetailsRepoImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      );
      
      expect(response, isA<SuccessResponse<String>>());
      expect(response, isNotNull);
      expect((response as SuccessResponse<String>).data, equals("Address added successfully"));

    },);

    test("testing addAddress function with error response", ()async {
      when(addressDetailsRepoImpl.addAddress(
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(error: Exception("Failed to add address"));
        }
      );

      var response =await addressDetailsRepoImpl.addAddress(
         street: "123 Main St",
          phone: "01116668917",
          city: "Cairo",
          lat: "30.0444",
          long: "31.2357",
          username: "momen haitham"
      );

      expect(
        response,
        isA<ErrorResponse<String>>()
      );
    },);

  },
);
  
  group("testing updateAddress function", (){
        test("testing updateAddress function with success response", () async{

      when(addressDetailsRepoImpl.updateAddress(
        addressId: "dwqrsd1432214321efds21",
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "Address updated successfully");
        }
      );

      var response = await addressDetailsRepoImpl.updateAddress(
        addressId: "dwqrsd1432214321efds21",
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      );
      
      expect(response, isA<SuccessResponse<String>>());
      expect(response, isNotNull);
      expect((response as SuccessResponse<String>).data, equals("Address updated successfully"));

    },);

    test("testing updateAddress function with error response", ()async {
      when(addressDetailsRepoImpl.updateAddress(
        addressId: "dwqrsd1432214321efds21",
        street: "123 Main St",
        phone: "01116668917",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
        username: "momen haitham"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(error: Exception("Failed to update address"));
        }
      );

      var response =await addressDetailsRepoImpl.updateAddress(
        addressId: "dwqrsd1432214321efds21",
         street: "123 Main St",
          phone: "01116668917",
          city: "Cairo",
          lat: "30.0444",
          long: "31.2357",
          username: "momen haitham"
      );

      expect(
        response,
        isA<ErrorResponse<String>>()
      );
    },);

  }
 );

  group("Testing get cities function", () {
    test("Testing get cities function with success response", () async {
      when(addressDetailsRepoImpl.getCities()).thenAnswer(
        (_) async {
          return [
            CitiesModel(id: "1", governorateNameEn: "Cairo",governorateNameAr: "القاهره"),
            CitiesModel(id: "1", governorateNameEn: "Alexandria",governorateNameAr: "الاسكندريه"),
          ];
        }
      );

      var response = await addressDetailsRepoImpl.getCities();
      expect(response, isA<List<CitiesModel>>());
      expect(response.length, equals(2));
      expect(response[0].governorateNameEn, equals("Cairo"));
      expect(response, isNotNull);
      expect(response[1].governorateNameEn, equals("Alexandria"));
    });

    test("Testing get cities function with empty list", () async {
      when(addressDetailsRepoImpl.getCities()).thenAnswer(
        (_) async {
          return [];
        }
      );

      var response = await addressDetailsRepoImpl.getCities();
      expect(response, isA<List<CitiesModel>>());
      expect(response.length, equals(0));
      expect(response.isEmpty, isTrue);
    });

    test("Testing get cities function with error response", () async {
      when(addressDetailsRepoImpl.getCities()).thenThrow(
        Exception("Failed to get cities")
      );

      expect(
        () async => await addressDetailsRepoImpl.getCities(),
        throwsException
      );
    });
  });

  group("Testing get states function", () {
    test("Testing get states function with success response", () async {
      when(addressDetailsRepoImpl.getStates()).thenAnswer(
        (_) async {
          return [
            StatesModel(id: "1", cityNameEn: "Nasr City",cityNameAr: "مدينه نصر",governorateId: "1"),
            StatesModel(id: "1", cityNameEn: "Maadi",cityNameAr: "المعادي",governorateId: "2"),
          ];
        }
      );

      var response = await addressDetailsRepoImpl.getStates();
      expect(response, isA<List<StatesModel>>());
      expect(response.length, equals(2));
      expect(response, isNotNull);
      expect(response[0].cityNameEn, equals("Nasr City"));
      expect(response[1].cityNameEn, equals("Maadi"));
    });

    test("Testing get states function with empty list", () async {
      when(addressDetailsRepoImpl.getStates()).thenAnswer(
        (_) async {
          return [];
        }
      );

      var response = await addressDetailsRepoImpl.getStates();
      expect(response, isA<List<StatesModel>>());
      expect(response.length, equals(0));
      expect(response.isEmpty, isTrue);
    });

    test("Testing get states function with error response", () async {
      when(addressDetailsRepoImpl.getStates()).thenThrow(
        Exception("Failed to get states")
      );

      expect(
        () async => await addressDetailsRepoImpl.getStates(),
        throwsException
      );
    });

    
  });
}
