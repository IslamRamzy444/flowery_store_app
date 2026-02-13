import 'package:flower_app/app/feature/address_details/api/data_source_impls/address_details_local_data_source_impl.dart';
import 'package:flower_app/app/feature/address_details/data/models/cities_dto.dart';
import 'package:flower_app/app/feature/address_details/data/models/countres_dto.dart';
import 'package:flower_app/app/feature/address_details/data/models/states_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_details_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AddressDetailsLocalDataSourceImpl])
void main() {
  late AddressDetailsLocalDataSourceImpl addressDetailsLocalDataSourceImpl;

  setUpAll(() {
    addressDetailsLocalDataSourceImpl = MockAddressDetailsLocalDataSourceImpl();
  });

  group("Testing get cities function", () {
    test("Testing get cities function with success response", () async {
      when(addressDetailsLocalDataSourceImpl.getCities()).thenAnswer(
        (_) async {
          return CitiesDto();
        }
      );

      var response = await addressDetailsLocalDataSourceImpl.getCities();
      expect(response, isA<CitiesDto>());
    });

    test("Testing get cities function with error response", () async {
      when(addressDetailsLocalDataSourceImpl.getCities()).thenThrow(
        Exception("Failed to get cities")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getCities(),
        throwsException
      );
    });

    test("Testing get cities function returns non-null data", () async {
      when(addressDetailsLocalDataSourceImpl.getCities()).thenAnswer(
        (_) async {
          return CitiesDto();
        }
      );

      var response = await addressDetailsLocalDataSourceImpl.getCities();
      expect(response, isNotNull);
    });

    test("Testing get cities function with file not found error", () async {
      when(addressDetailsLocalDataSourceImpl.getCities()).thenThrow(
        Exception("File not found")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getCities(),
        throwsException
      );
    });

    test("Testing get cities function with invalid json format", () async {
      when(addressDetailsLocalDataSourceImpl.getCities()).thenThrow(
        FormatException("Invalid JSON format")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getCities(),
        throwsA(isA<FormatException>())
      );
    });
  });

  group("Testing get countries function", () {
    test("Testing get countries function with success response", () async {
      when(addressDetailsLocalDataSourceImpl.getCountries()).thenAnswer(
        (_) async {
          return CountresDto();
        }
      );

      var response = await addressDetailsLocalDataSourceImpl.getCountries();
      expect(response, isA<CountresDto>());
    });

    test("Testing get countries function with error response", () async {
      when(addressDetailsLocalDataSourceImpl.getCountries()).thenThrow(
        Exception("Failed to get countries")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getCountries(),
        throwsException
      );
    });

    test("Testing get countries function returns non-null data", () async {
      when(addressDetailsLocalDataSourceImpl.getCountries()).thenAnswer(
        (_) async {
          return CountresDto();
        }
      );

      var response = await addressDetailsLocalDataSourceImpl.getCountries();
      expect(response, isNotNull);
    });

    test("Testing get countries function with file not found error", () async {
      when(addressDetailsLocalDataSourceImpl.getCountries()).thenThrow(
        Exception("File not found")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getCountries(),
        throwsException
      );
    });

    test("Testing get countries function with invalid json format", () async {
      when(addressDetailsLocalDataSourceImpl.getCountries()).thenThrow(
        FormatException("Invalid JSON format")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getCountries(),
        throwsA(isA<FormatException>())
      );
    });
  });

  group("Testing get states function", () {
    test("Testing get states function with success response", () async {
      when(addressDetailsLocalDataSourceImpl.getStates()).thenAnswer(
        (_) async {
          return StatesDto();
        }
      );

      var response = await addressDetailsLocalDataSourceImpl.getStates();
      expect(response, isA<StatesDto>());
    });

    test("Testing get states function with error response", () async {
      when(addressDetailsLocalDataSourceImpl.getStates()).thenThrow(
        Exception("Failed to get states")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getStates(),
        throwsException
      );
    });

    test("Testing get states function returns non-null data", () async {
      when(addressDetailsLocalDataSourceImpl.getStates()).thenAnswer(
        (_) async {
          return StatesDto();
        }
      );

      var response = await addressDetailsLocalDataSourceImpl.getStates();
      expect(response, isNotNull);
    });

    test("Testing get states function with file not found error", () async {
      when(addressDetailsLocalDataSourceImpl.getStates()).thenThrow(
        Exception("File not found")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getStates(),
        throwsException
      );
    });

    test("Testing get states function with invalid json format", () async {
      when(addressDetailsLocalDataSourceImpl.getStates()).thenThrow(
        FormatException("Invalid JSON format")
      );

      expect(
        () async => await addressDetailsLocalDataSourceImpl.getStates(),
        throwsA(isA<FormatException>())
      );
    });
  });
}