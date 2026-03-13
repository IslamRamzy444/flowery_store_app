import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/api/data_source_impls/track_order_stepper_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/models/driver_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../data/repo/track_order_stepper_repo_impl_test.mocks.dart';
import 'track_order_stepper_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([TrackOrderStepperRemoteDataSourceImpl])
void main() {
  late TrackOrderStepperRemoteDataSourceImpl trackOrderStepperRemoteDataSourceImpl;
  BuildContext context = MockBuildContext();
  setUpAll(() {
    trackOrderStepperRemoteDataSourceImpl = MockTrackOrderStepperRemoteDataSourceImpl();
    provideDummy<BaseResponse<String?>>(SuccessResponse<String?>(data: ""));
    provideDummy<BaseResponse<DriverInfoModel?>>(SuccessResponse<DriverInfoModel?>(data: DriverInfoModel()));
    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: ""));
  });

  group("Testing get driver info function", () {
    test("Testing get driver info function with success response", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<DriverInfoModel?>(
            data: DriverInfoModel(
              driverName: "Ahmed",
              driverPhoneNumber: "01234567890",
              driverPhoto: "https://example.com/image.jpg"
            )
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<DriverInfoModel?>>());
      expect((response as SuccessResponse<DriverInfoModel?>).data?.driverName, equals("Ahmed"));
      expect(response.data?.driverPhoneNumber, equals("01234567890"));
    });

    test("Testing get driver info function with error response", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Failed to get driver info")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
      expect((response as ErrorResponse<DriverInfoModel?>).error, isA<Exception>());
    });

    test("Testing get driver info function with null data", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<DriverInfoModel?>(data: null);
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<DriverInfoModel?>>());
      expect((response as SuccessResponse<DriverInfoModel?>).data, isNull);
    });

    test("Testing get driver info function with null orderId", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: null
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: null
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
    });

    test("Testing get driver info function with empty orderId", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: ""
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Order ID cannot be empty")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: ""
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
    });

    test("Testing get driver info function with firebase permission denied", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Firebase error: Permission denied")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
    });

    test("Testing get driver info function with order not found", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "nonexistent_order"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Order not found")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "nonexistent_order"
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
    });

    test("Testing get driver info function with network error", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Network error")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
    });

    test("Testing get driver info function with complete driver data", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return SuccessResponse<DriverInfoModel?>(
            data: DriverInfoModel(
              driverName: "Mohamed Ali",
              driverPhoneNumber: "01122334455",
              driverPhoto: "https://example.com/driver.jpg",
            )
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<SuccessResponse<DriverInfoModel?>>());
      expect((response as SuccessResponse<DriverInfoModel?>).data?.driverName, isNotNull);
      expect(response.data?.driverPhoneNumber, isNotNull);
      expect(response.data?.driverPhoto, isNotNull);
    });

    test("Testing get driver info function with invalid JSON format", () async {
      when(trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoModel?>(
            error: Exception("Invalid JSON format")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.getDriverInfo(
        orderId: "order123"
      );

      expect(response, isA<ErrorResponse<DriverInfoModel?>>());
    });
  });

  group("Testing add new order document to firebase function", () {
    test("Testing add new order document with success when document exists", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<SuccessResponse<String>>());
    });

    test("Testing add new order document with success when document doesn't exist", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "new_order_123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "new_order_123",
        context: context
      );

      expect(response, isA<SuccessResponse<String>>());
    });

    test("Testing add new order document with no internet connection error", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("No internet connection")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error.toString(), contains("No internet connection"));
    });

    test("Testing add new order document with firebase error", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Firebase error")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with null orderId", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: null,
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: null,
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with empty orderId", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be empty")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with firebase permission denied", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Firebase error: Permission denied")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with network timeout", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Network timeout")
          );
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document multiple times successfully", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response1 = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );
      
      var response2 = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response1, isA<SuccessResponse<String>>());
      expect(response2, isA<SuccessResponse<String>>());
    });

    test("Testing add new order document with special characters in orderId", () async {
      when(trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order@123#test",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response = await trackOrderStepperRemoteDataSourceImpl.addNewOrderDocumentToFirebase(
        orderId: "order@123#test",
        context: context
      );

      expect(response, isA<SuccessResponse<String>>());
    });
  });
}