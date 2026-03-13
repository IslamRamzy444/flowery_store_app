
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'order_details_model_test.mocks.dart';
@GenerateMocks([DocumentSnapshot])
void main() {
  group('OrderDetailsModel', () {
    const testClientLat = '26.8206';
    const testClientLong = '30.8025';
    const testDriverLat = '26.8356';
    const testDriverLong = '30.8175';
    const testStoreLat = '26.8506';
    const testStoreLong = '30.8325';
    const testDriverName = 'John Doe';
    const testDriverPhone = '+1234567890';
    const testDriverPhoto = 'assets/images/driver.jpg';
    const testOrderState = 'in_progress';
    late MockDocumentSnapshot mockDoc;
    setUp(() {
      mockDoc=MockDocumentSnapshot();
    },);
    test('collectionName should be "orderDetails"', () {
      expect(OrderDetailsModel.collectionName, 'orderDetails');
    });
    group('Constructor and properties', () {
      test('should create instance with all fields', () {
        final model = OrderDetailsModel(
          clientLat: testClientLat,
          clientLong: testClientLong,
          driverLat: testDriverLat,
          driverLong: testDriverLong,
          driverName: testDriverName,
          driverPhoneNumber: testDriverPhone,
          driverPhoto: testDriverPhoto,
          storeLat: testStoreLat,
          storeLong: testStoreLong,
          orderState: testOrderState,
        );
        expect(model.clientLat, testClientLat);
        expect(model.clientLong, testClientLong);
        expect(model.driverLat, testDriverLat);
        expect(model.driverLong, testDriverLong);
        expect(model.driverName, testDriverName);
        expect(model.driverPhoneNumber, testDriverPhone);
        expect(model.driverPhoto, testDriverPhoto);
        expect(model.storeLat, testStoreLat);
        expect(model.storeLong, testStoreLong);
        expect(model.orderState, testOrderState);
      },);
      test('should create instance with null fields', () {
        final model = OrderDetailsModel();
        expect(model.clientLat, isNull);
        expect(model.clientLong, isNull);
        expect(model.driverLat, isNull);
        expect(model.driverLong, isNull);
        expect(model.driverName, isNull);
        expect(model.driverPhoneNumber, isNull);
        expect(model.driverPhoto, isNull);
        expect(model.storeLat, isNull);
        expect(model.storeLong, isNull);
        expect(model.orderState, isNull);
      },);
    },);
    group('fromFireStore', () {
      test('should create model from valid DocumentSnapshot', () {
        final mockData = {
          'clientLat': testClientLat,
          'clientLong': testClientLong,
          'driverLat': testDriverLat,
          'driverLong': testDriverLong,
          'driverName': testDriverName,
          'driverPhoneNumber': testDriverPhone,
          'driverPhoto': testDriverPhoto,
          'storeLat': testStoreLat,
          'storeLong': testStoreLong,
          'orderState': testOrderState,
        };
        when(mockDoc.data()).thenReturn(mockData);
        when(mockDoc.get('clientLat')).thenReturn(testClientLat);
        when(mockDoc.get('clientLong')).thenReturn(testClientLong);
        when(mockDoc.get('driverLat')).thenReturn(testDriverLat);
        when(mockDoc.get('driverLong')).thenReturn(testDriverLong);
        when(mockDoc.get('driverName')).thenReturn(testDriverName);
        when(mockDoc.get('driverPhoneNumber')).thenReturn(testDriverPhone);
        when(mockDoc.get('driverPhoto')).thenReturn(testDriverPhoto);
        when(mockDoc.get('storeLat')).thenReturn(testStoreLat);
        when(mockDoc.get('storeLong')).thenReturn(testStoreLong);
        when(mockDoc.get('orderState')).thenReturn(testOrderState);
        final model = OrderDetailsModel.fromFireStore(mockDoc);
        expect(model.clientLat, testClientLat);
        expect(model.clientLong, testClientLong);
        expect(model.driverLat, testDriverLat);
        expect(model.driverLong, testDriverLong);
        expect(model.driverName, testDriverName);
        expect(model.driverPhoneNumber, testDriverPhone);
        expect(model.driverPhoto, testDriverPhoto);
        expect(model.storeLat, testStoreLat);
        expect(model.storeLong, testStoreLong);
        expect(model.orderState, testOrderState);
        verify(mockDoc.data()).called(1);
      },);
      test('should handle numeric values conversion', () {
        final mockData = {
          'clientLat': 26.8206, 
          'clientLong': 30.8025, 
          'driverLat': 26.8356, 
          'driverLong': 30.8175, 
        };
        when(mockDoc.data()).thenReturn(mockData);
        when(mockDoc.get('clientLat')).thenReturn(26.8206);
        when(mockDoc.get('clientLong')).thenReturn(30.8025);
        when(mockDoc.get('driverLat')).thenReturn(26.8356);
        when(mockDoc.get('driverLong')).thenReturn(30.8175);
        final model = OrderDetailsModel.fromFireStore(mockDoc);
        expect(model.clientLat, '26.8206');
        expect(model.clientLong, '30.8025');
        expect(model.driverLat, '26.8356');
        expect(model.driverLong, '30.8175');
      },);
      test('should handle missing fields with null values', () {
        final mockData = <String, dynamic>{};
        when(mockDoc.data()).thenReturn(mockData);
        when(mockDoc.get(any)).thenReturn(null);
        final model = OrderDetailsModel.fromFireStore(mockDoc);
        expect(model.clientLat, isNull);
        expect(model.clientLong, isNull);
        expect(model.driverLat, isNull);
        expect(model.driverLong, isNull);
        expect(model.driverName, isNull);
        expect(model.driverPhoneNumber, isNull);
        expect(model.driverPhoto, isNull);
        expect(model.storeLat, isNull);
        expect(model.storeLong, isNull);
        expect(model.orderState, isNull);
      },);
    },);
    group('location getters', () {
      test('clientLocation should return LatLng when coordinates are valid', () {
        final model = OrderDetailsModel(
          clientLat: testClientLat,
          clientLong: testClientLong,
        );
        final location = model.clientLocation;
        expect(location, isNotNull);
        expect(location!.latitude, 26.8206);
        expect(location.longitude, 30.8025);
      },);
      test('clientLocation should return null when coordinates are null', () {
        final model = OrderDetailsModel();
        expect(model.clientLocation, isNull);
      });
      test('clientLocation should return null when coordinates are invalid', () {
        final model = OrderDetailsModel(
          clientLat: 'invalid',
          clientLong: 'invalid',
        );
        expect(model.clientLocation, isNull);
      });
      test('driverLocation should return LatLng when coordinates are valid', () {
        final model = OrderDetailsModel(
          driverLat: testDriverLat,
          driverLong: testDriverLong,
        );
        final location = model.driverLocation;
        expect(location, isNotNull);
        expect(location!.latitude, 26.8356);
        expect(location.longitude, 30.8175);
      });
      test('driverLocation should return null when coordinates are null', () {
        final model = OrderDetailsModel();
        expect(model.driverLocation, isNull);
      });
      test('storeLocation should return LatLng when coordinates are valid', () {
        final model = OrderDetailsModel(
          storeLat: testStoreLat,
          storeLong: testStoreLong,
        );
        final location = model.storeLocation;
        expect(location, isNotNull);
        expect(location!.latitude, 26.8506);
        expect(location.longitude, 30.8325);
      });
      test('storeLocation should return null when coordinates are null', () {
        final model = OrderDetailsModel();
        expect(model.storeLocation, isNull);
      });
    },);
    group('hasDriver', () {
      test('should return true when driver name and location exist', () {
        final model = OrderDetailsModel(
          driverName: testDriverName,
          driverLat: testDriverLat,
          driverLong: testDriverLong,
        );
        expect(model.hasDriver, true);
      });
      test('should return false when driver name is null', () {
        final model = OrderDetailsModel(
          driverLat: testDriverLat,
          driverLong: testDriverLong,
        );
        expect(model.hasDriver, false);
      });
      test('should return false when driver location is null', () {
        final model = OrderDetailsModel(
          driverName: testDriverName,
        );
        expect(model.hasDriver, false);
      });
      test('should return false when driver location is invalid', () {
        final model = OrderDetailsModel(
          driverName: testDriverName,
          driverLat: 'invalid',
          driverLong: 'invalid',
        );
        expect(model.hasDriver, false);
      });
      test('should return false when all driver fields are null', () {
        final model = OrderDetailsModel();
        expect(model.hasDriver, false);
      });
    },);
    group('hasValidLocations', () {
      test('should return true when client and store locations exist', () {
        final model = OrderDetailsModel(
          clientLat: testClientLat,
          clientLong: testClientLong,
          storeLat: testStoreLat,
          storeLong: testStoreLong,
        );
        expect(model.hasValidLocations, true);
      });
      test('should return true when all locations exist', () {
        final model = OrderDetailsModel(
          clientLat: testClientLat,
          clientLong: testClientLong,
          driverLat: testDriverLat,
          driverLong: testDriverLong,
          storeLat: testStoreLat,
          storeLong: testStoreLong,
        );
        expect(model.hasValidLocations, true);
      });
      test('should return false when only client location exists', () {
        final model = OrderDetailsModel(
          clientLat: testClientLat,
          clientLong: testClientLong,
        );
        expect(model.hasValidLocations, false);
      });
      test('should return false when only store location exists', () {
        final model = OrderDetailsModel(
          storeLat: testStoreLat,
          storeLong: testStoreLong,
        );
        expect(model.hasValidLocations, false);
      });
      test('should return false when no locations exist', () {
        final model = OrderDetailsModel();
        expect(model.hasValidLocations, false);
      });
      test('should return false when locations are invalid', () {
        final model = OrderDetailsModel(
          clientLat: 'invalid',
          clientLong: 'invalid',
          storeLat: 'invalid',
          storeLong: 'invalid',
        );
        expect(model.hasValidLocations, false);
      });
    },);
    group('Edge Cases', () {
      test('should handle empty string coordinates', () {
        final model = OrderDetailsModel(
          clientLat: '',
          clientLong: '',
        );
        expect(model.clientLocation, isNull);
      });
      test('should handle whitespace coordinates', () {
        final model = OrderDetailsModel(
          clientLat: '  ',
          clientLong: '  ',
        );
        expect(model.clientLocation, isNull);
      });
      test('should handle coordinates with leading/trailing spaces', () {
        final model = OrderDetailsModel(
          clientLat: ' 26.8206 ',
          clientLong: ' 30.8025 ',
        );
        final location = model.clientLocation;
        expect(location, isNotNull);
        expect(location!.latitude, 26.8206);
        expect(location.longitude, 30.8025);
      });
    },);
  },);
}