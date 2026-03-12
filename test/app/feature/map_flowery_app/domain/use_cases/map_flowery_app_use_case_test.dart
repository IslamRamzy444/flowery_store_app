import 'dart:async';

import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/repos/map_flowery_app_repo_impl.dart';
import 'package:flower_app/app/feature/map_flowery_app/domain/use_cases/map_flowery_app_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'map_flowery_app_use_case_test.mocks.dart';

@GenerateMocks([MapFloweryAppRepoImpl])
void main() {
  late MapFloweryAppUseCase mapFloweryAppUseCase;
  late MockMapFloweryAppRepoImpl mockMapFloweryAppRepoImpl;
  setUp(() {
    provideDummy<BaseResponse<Stream<OrderDetailsModel?>>>(SuccessResponse<Stream<OrderDetailsModel?>>(data: Stream.empty()));
    mockMapFloweryAppRepoImpl=MockMapFloweryAppRepoImpl();
    mapFloweryAppUseCase=MapFloweryAppUseCase(mockMapFloweryAppRepoImpl);
  },);
  group('MapFloweryAppUseCase test cases', () {
    test('should return ErrorResponse when orderId is empty', () {
      final emptyResult = mapFloweryAppUseCase.call('');
      expect(emptyResult, isA<ErrorResponse<Stream<OrderDetailsModel?>>>());
      expect((emptyResult as ErrorResponse<Stream<OrderDetailsModel?>>).error.toString(),contains('Order ID cannot be empty'),);
      verifyNever(mockMapFloweryAppRepoImpl.getOrderTrackingStream(any));
    },);
    test('should call repo with valid orderId and return its response', () {
      const validOrderId = 'order_123';
      final mockStream = Stream<OrderDetailsModel?>.empty();
      final successResponse = SuccessResponse<Stream<OrderDetailsModel?>>(data: mockStream);
      final errorResponse = ErrorResponse<Stream<OrderDetailsModel?>>(error: Exception('Repo error'),);
      when(mockMapFloweryAppRepoImpl.getOrderTrackingStream(validOrderId)).thenReturn(successResponse);
      final successResult = mapFloweryAppUseCase.call(validOrderId);
      expect(successResult, successResponse);
      verify(mockMapFloweryAppRepoImpl.getOrderTrackingStream(validOrderId)).called(1);
      when(mockMapFloweryAppRepoImpl.getOrderTrackingStream(validOrderId)).thenReturn(errorResponse);
      final errorResult = mapFloweryAppUseCase.call(validOrderId);
      expect(errorResult, errorResponse);
      verify(mockMapFloweryAppRepoImpl.getOrderTrackingStream(validOrderId)).called(1);
    },);
    test('should work with stream that emits values', () async{
      const validOrderId = 'order_stream';
      final controller = StreamController<OrderDetailsModel?>();
      final testModel = OrderDetailsModel(
        clientLat: '26.8206',
        clientLong: '30.8025',
        driverName: 'Test Driver',
      );
      final successResponse = SuccessResponse<Stream<OrderDetailsModel?>>(data: controller.stream);
      when(mockMapFloweryAppRepoImpl.getOrderTrackingStream(validOrderId)).thenReturn(successResponse);
      final result = mapFloweryAppUseCase.call(validOrderId);
      final resultStream = (result as SuccessResponse).data;
      controller.add(testModel);
      controller.close();
      await expectLater(resultStream, emits(testModel));
      verify(mockMapFloweryAppRepoImpl.getOrderTrackingStream(validOrderId)).called(1);
    },);
  },);
}