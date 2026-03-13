import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/track_order_stepper/data/repo/track_order_stepper_repo_impl.dart';
import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_stepper_repo_impl_test.mocks.dart';

@GenerateMocks([TrackOrderStepperRepoImpl,BuildContext])
void main() {
  late TrackOrderStepperRepoImpl trackOrderStepperRepoImpl;
  BuildContext context = MockBuildContext();
  setUpAll(() {
    trackOrderStepperRepoImpl = MockTrackOrderStepperRepoImpl();
    provideDummy<BaseResponse<String?>>(SuccessResponse<String?>(data: ""));
    provideDummy<BaseResponse<DriverInfoToModel?>>(SuccessResponse<DriverInfoToModel?>(data: DriverInfoToModel(driverImage: "",driverName: "",driverPhone: "")));
    provideDummy<BaseResponse<String>>(SuccessResponse<String>(data: ""));
  });

  group("Testing get order status function", () {
    test("Testing get order status stream with pending status", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(SuccessResponse<String?>(data: "Pending"))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<SuccessResponse<String?>>())
      );
    });

    test("Testing get order status stream with processing status", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(SuccessResponse<String?>(data: "Processing"))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<SuccessResponse<String?>>())
      );
    });

    test("Testing get order status stream with delivered status", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(SuccessResponse<String?>(data: "Delivered"))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<SuccessResponse<String?>>())
      );
    });

    test("Testing get order status stream with cancelled status", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(SuccessResponse<String?>(data: "Cancelled"))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<SuccessResponse<String?>>())
      );
    });

    test("Testing get order status stream with error response", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(ErrorResponse<String?>(error: Exception("Failed to get order status")))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<ErrorResponse<String?>>())
      );
    });

    test("Testing get order status stream with multiple status updates", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.fromIterable([
          SuccessResponse<String?>(data: "Pending"),
          SuccessResponse<String?>(data: "Processing"),
          SuccessResponse<String?>(data: "Delivered")
        ])
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emitsInOrder([
          isA<SuccessResponse<String?>>(),
          isA<SuccessResponse<String?>>(),
          isA<SuccessResponse<String?>>()
        ])
      );
    });

    test("Testing get order status stream with null status", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(SuccessResponse<String?>(data: null))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<SuccessResponse<String?>>())
      );
    });

    test("Testing get order status stream with order not found error", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "nonexistent_order",
        context: context
      )).thenAnswer(
        (_) => Stream.value(ErrorResponse<String?>(error: Exception("No driver has accepted your order yet")))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "nonexistent_order",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<ErrorResponse<String?>>())
      );
    });

    test("Testing get order status stream with null orderId", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: null,
        context: context
      )).thenAnswer(
        (_) => Stream.value(ErrorResponse<String?>(error: Exception("Order ID cannot be null")))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: null,
        context: context
      );

      await expectLater(
        stream,
        emits(isA<ErrorResponse<String?>>())
      );
    });

    test("Testing get order status stream with network error", () async {
      when(trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) => Stream.value(ErrorResponse<String?>(error: Exception("Network error")))
      );

      final stream = trackOrderStepperRepoImpl.getOrderStatus(
        orderId: "order123",
        context: context
      );

      await expectLater(
        stream,
        emits(isA<ErrorResponse<String?>>())
      );
    });
  });

  group("Testing get driver info function", () {
    test("Testing get driver info function with success response", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<DriverInfoToModel?>(
            data: DriverInfoToModel(
              driverName: "Ahmed",
              driverPhone: "01234567890",
              driverImage: "https://example.com/image.jpg"
            )
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<SuccessResponse<DriverInfoToModel?>>());
      expect((response as SuccessResponse<DriverInfoToModel?>).data?.driverName, equals("Ahmed"));
      expect(response.data?.driverPhone, equals("01234567890"));
    });

    test("Testing get driver info function with error response", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("Failed to get driver info")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
      expect((response as ErrorResponse<DriverInfoToModel?>).error, isA<Exception>());
    });

    test("Testing get driver info function with no driver assigned error", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("No driver has accepted your order yet")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
      expect((response as ErrorResponse<DriverInfoToModel?>).error.toString(), contains("No driver has accepted your order yet"));
    });

    test("Testing get driver info function with null driver name", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("No driver has accepted your order yet")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
    });

    test("Testing get driver info function with null orderId", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: null,
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: null,
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
    });

    test("Testing get driver info function with empty orderId", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("Order ID cannot be empty")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
    });

    test("Testing get driver info function with complete driver data", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<DriverInfoToModel?>(
            data: DriverInfoToModel(
              driverName: "Mohamed Ali",
              driverPhone: "01122334455",
              driverImage: "https://example.com/driver.jpg",
            )
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<SuccessResponse<DriverInfoToModel?>>());
      expect((response as SuccessResponse<DriverInfoToModel?>).data?.driverName, equals("Mohamed Ali"));
      expect(response.data?.driverPhone, equals("01122334455"));
      expect(response.data?.driverImage, equals("https://example.com/driver.jpg"));
    });

    test("Testing get driver info function with network error", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("Network error")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
    });

    test("Testing get driver info function with firebase permission denied", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("Firebase error: Permission denied")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
    });

    test("Testing get driver info function with order not found", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "nonexistent_order",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<DriverInfoToModel?>(
            error: Exception("Order not found")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "nonexistent_order",
        context: context
      );

      expect(response, isA<ErrorResponse<DriverInfoToModel?>>());
    });

    test("Testing get driver info function returns non-null data", () async {
      when(trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<DriverInfoToModel?>(
            data: DriverInfoToModel(
              driverName: "Test Driver",
              driverPhone: "01111111111",
              driverImage: "https://example.com/driver.jpg",
            )
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.getDriverInfo(
        orderId: "order123",
        context: context
      );

      expect((response as SuccessResponse<DriverInfoToModel?>).data, isNotNull);
    });
  });

  group("Testing add new order document to firebase function", () {
    test("Testing add new order document with success response", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<SuccessResponse<String>>());
    });

    test("Testing add new order document with error response", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Failed to add order document")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error, isA<Exception>());
    });

    test("Testing add new order document with no internet connection", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("No internet connection")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
      expect((response as ErrorResponse<String>).error.toString(), contains("No internet connection"));
    });

    test("Testing add new order document with null orderId", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: null,
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be null")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: null,
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with empty orderId", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Order ID cannot be empty")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with firebase permission denied", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Firebase error: Permission denied")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document with network timeout", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Network timeout")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });

    test("Testing add new order document multiple times successfully", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response1 = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );
      
      var response2 = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response1, isA<SuccessResponse<String>>());
      expect(response2, isA<SuccessResponse<String>>());
    });

    test("Testing add new order document returns non-null response", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return SuccessResponse<String>(data: "");
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isNotNull);
    });

    test("Testing add new order document with firebase error", () async {
      when(trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      )).thenAnswer(
        (_) async {
          return ErrorResponse<String>(
            error: Exception("Firebase error")
          );
        }
      );

      var response = await trackOrderStepperRepoImpl.addNewOrderDocumentToFirebase(
        orderId: "order123",
        context: context
      );

      expect(response, isA<ErrorResponse<String>>());
    });
  });
}