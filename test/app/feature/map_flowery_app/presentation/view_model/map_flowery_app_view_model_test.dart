import 'dart:async';

import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/domain/use_cases/map_flowery_app_use_case.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_events.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_states.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_view_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'map_flowery_app_view_model_test.mocks.dart';

@GenerateMocks([MapFloweryAppUseCase])
void main() {
  late MapFloweryAppViewModel mapFloweryAppViewModel;
  late MockMapFloweryAppUseCase mockMapFloweryAppUseCase;
  setUp(() {
    provideDummy<BaseResponse<Stream<OrderDetailsModel?>>>(SuccessResponse<Stream<OrderDetailsModel?>>(data: Stream.empty()));
    mockMapFloweryAppUseCase=MockMapFloweryAppUseCase();
    mapFloweryAppViewModel=MapFloweryAppViewModel(mockMapFloweryAppUseCase);
  },);
  tearDown(() {
    mapFloweryAppViewModel.close();
  },);
  test('initial state should have default values', () {
    expect(mapFloweryAppViewModel.state.isMapReady, false);
    expect(mapFloweryAppViewModel.state.trackingState?.isLoading, null);
    expect(mapFloweryAppViewModel.state.switchTrackingState?.success, null);
    expect(mapFloweryAppViewModel.state.mapCenter, null);
  });
  group('StartTrackingEvent test cases', () {
    String testOrderId = 'test_order_123';
    final testOrderDetails = OrderDetailsModel(
      clientLat: '26.8206',
      clientLong: '30.8025',
      driverLat: '26.8356',
      driverLong: '30.8175',
      driverName: 'Test Driver',
      driverPhoneNumber: '+1234567890',
      storeLat: '26.8506',
      storeLong: '30.8325',
      orderState: 'Accepted',
    );
    final testOrderDetailsInProgress = OrderDetailsModel(
      clientLat: '26.8206',
      clientLong: '30.8025',
      driverLat: '26.8356',
      driverLong: '30.8175',
      driverName: 'Test Driver',
      orderState: 'InProgress',
    );
    final testDriverLocation = LatLng(26.8356, 30.8175);
    test('Success case - should emit loading then success with data (Accepted state)', () async{
      final controller = StreamController<OrderDetailsModel?>();
      when(mockMapFloweryAppUseCase.call(testOrderId)).thenAnswer(
        (_) =>SuccessResponse<Stream<OrderDetailsModel?>>(data: controller.stream) ,
      );
      expectLater(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==true,
          ),
          predicate<MapFloweryAppStates>(
            (state) =>state.trackingState?.isLoading==false
            && state.trackingState?.success==testOrderDetails
            && state.mapCenter==testDriverLocation
          ),
          predicate<MapFloweryAppStates>(
            (state) => state.switchTrackingState?.success==1
            && state.trackingState?.success==testOrderDetails,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(StartTrackingEvent(testOrderId));
      await Future.delayed(Duration.zero);
      controller.add(testOrderDetails);
      await Future.delayed(Duration.zero);
      await controller.close();
    },);
    test('Success case with InProgress state - should set switchTrackingState to 2', () async{
      final controller=StreamController<OrderDetailsModel?>();
      when(mockMapFloweryAppUseCase.call(testOrderId)).thenAnswer(
        (_) =>SuccessResponse<Stream<OrderDetailsModel?>>(data: controller.stream) ,
      );
      expect(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==true,
          ),
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==false
            && state.trackingState?.success==testOrderDetailsInProgress
          ),
          predicate<MapFloweryAppStates>(
            (state) => state.switchTrackingState?.success==2
            && state.trackingState?.success==testOrderDetailsInProgress,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(StartTrackingEvent(testOrderId));
      await Future.delayed(Duration.zero);
      controller.add(testOrderDetailsInProgress);
      await Future.delayed(Duration.zero);
      await controller.close();
    },);
    test('Failure case - should emit loading then error when use case returns error', () {
      final testError = Exception('Failed to get tracking data');
      final errorResponse = ErrorResponse<Stream<OrderDetailsModel?>>(error: testError);
      when(mockMapFloweryAppUseCase.call(testOrderId)).thenAnswer(
        (_) => errorResponse,
      );
      expectLater(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==true,
          ),
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==false
            && state.trackingState?.error==testError,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(StartTrackingEvent(testOrderId));
    },);
    test('Stream error case - should handle stream error emission', () async{
      final controller=StreamController<OrderDetailsModel?>();
      final testError = Exception('Stream connection error');
      when(mockMapFloweryAppUseCase.call(testOrderId)).thenAnswer(
        (_) => SuccessResponse<Stream<OrderDetailsModel?>>(data: controller.stream),
      );
      expectLater(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==true,
          ),
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==false
            && state.trackingState?.error==testError,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(StartTrackingEvent(testOrderId));
      await Future.delayed(Duration.zero);
      controller.addError(testError);
      await Future.delayed(Duration.zero);
      await controller.close();
    },);
    test('Null data case - should emit error when stream emits null', () async{
      final controller=StreamController<OrderDetailsModel?>();
      when(mockMapFloweryAppUseCase.call(testOrderId)).thenAnswer(
        (_) => SuccessResponse<Stream<OrderDetailsModel?>>(data: controller.stream),
      );
      expectLater(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==true,
          ),
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==false
            && state.trackingState?.error.toString().contains('No tracking data found')==true,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(StartTrackingEvent(testOrderId));
      await Future.delayed(Duration.zero);
      controller.add(null);
      await Future.delayed(Duration.zero);
      await controller.close();
    },);
  },);
  group('UpdateTrackingDataEvent test cases',() {
    final testOrderDetails = OrderDetailsModel(
      driverLat: '26.8356',
      driverLong: '30.8175',
      orderState: 'InProgress',
    );
    final testDriverLocation = LatLng(26.8356, 30.8175);
    test('Should update state with new tracking data when data is not null', () {
      expectLater(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==false
            && state.trackingState?.success==testOrderDetails
            && state.mapCenter==testDriverLocation,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(UpdateTrackingDataEvent(testOrderDetails));
    },);
    test('Should emit error state when update data is null', () {
      expectLater(
        mapFloweryAppViewModel.stream, 
        emitsInOrder([
          predicate<MapFloweryAppStates>(
            (state) => state.trackingState?.isLoading==false
            && state.trackingState?.error!=null
            && state.trackingState?.error.toString().contains('No tracking data found')==true,
          )
        ])
      );
      mapFloweryAppViewModel.doIntent(UpdateTrackingDataEvent(null));
    },);
  });
  group('StopTrackingEvent test cases', () {
    final testOrderDetails = OrderDetailsModel(
      driverLat: '26.8356',
      driverLong: '30.8175',
      orderState: 'InProgress',
    );
    test('Should cancel stream subscription and stop emitting', () async{
      final controller = StreamController<OrderDetailsModel?>();
      when(mockMapFloweryAppUseCase.call(any)).thenAnswer(
        (_) => SuccessResponse<Stream<OrderDetailsModel?>>(data: controller.stream),
      );
      mapFloweryAppViewModel.doIntent(StartTrackingEvent('test_id'));
      await Future.delayed(Duration.zero);
      final emittedStates = <MapFloweryAppStates>[];
      final subscription = mapFloweryAppViewModel.stream.listen(emittedStates.add);
      mapFloweryAppViewModel.doIntent(StopTrackingEvent());
      emittedStates.clear();
      controller.add(testOrderDetails);
      await Future.delayed(Duration(milliseconds: 100));
      expect(emittedStates, isEmpty);
      await subscription.cancel();
      await controller.close();
    },);
  },);
  group('MapReadyEvent test cases', () {
    test('Should set isMapReady to true', () {
      expectLater(
        mapFloweryAppViewModel.stream, 
        emits(
          predicate<MapFloweryAppStates>(
            (state) => state.isMapReady==true,
          )
        )
      );
      mapFloweryAppViewModel.doIntent(MapReadyEvent());
    },);
  },);
  group('Location priority tests', () {
    test('Should prioritize driverLocation over others', () {
      final orderWithAllLocations = OrderDetailsModel(
        clientLat: '26.8206',
        clientLong: '30.8025',
        driverLat: '26.8356',
        driverLong: '30.8175',
        storeLat: '26.8506',
        storeLong: '30.8325',
      );
      expectLater(
        mapFloweryAppViewModel.stream, 
        emits(
          predicate<MapFloweryAppStates>(
            (state) => state.mapCenter==LatLng(26.8356, 30.8175),
          )
        )
      );
      mapFloweryAppViewModel.doIntent(UpdateTrackingDataEvent(orderWithAllLocations));
    },);
    test('Should use clientLocation when driverLocation is null', () async{
      final orderWithStoreAndClient = OrderDetailsModel(
        clientLat: '26.8206',
        clientLong: '30.8025',
        storeLat: '26.8506',
        storeLong: '30.8325',
      );
      final emittedStates = <MapFloweryAppStates>[];
      final subscription = mapFloweryAppViewModel.stream.listen(emittedStates.add);
      mapFloweryAppViewModel.doIntent(UpdateTrackingDataEvent(orderWithStoreAndClient));
      await Future.delayed(Duration(milliseconds: 100));
      await subscription.cancel();
      expect(emittedStates.isNotEmpty, true);
      final lastState = emittedStates.last;
      expect(lastState.mapCenter, isNotNull);
      expect(lastState.mapCenter!.latitude, equals(26.8206));
      expect(lastState.mapCenter!.longitude, equals(30.8025));
    },);
    test('Should use storeLocation when driverLocation and clientLocation are null', () {
      final orderWithOnlyStore = OrderDetailsModel(
        storeLat: '26.8506',
        storeLong: '30.8325',
      );
      expectLater(
        mapFloweryAppViewModel.stream, 
        emits(
          predicate<MapFloweryAppStates>(
            (state) => state.mapCenter==LatLng(26.8506, 30.8325),
          )
        )
      );
      mapFloweryAppViewModel.doIntent(UpdateTrackingDataEvent(orderWithOnlyStore));
    },);
  },);
}