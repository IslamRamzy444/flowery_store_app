import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/repos/map_flowery_app_repo_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'map_flowery_app_repo_impl_test.mocks.dart';

@GenerateMocks([FirebaseFirestore,CollectionReference<Map<String, dynamic>>,DocumentReference<Map<String, dynamic>>,DocumentSnapshot<Map<String, dynamic>>])
void main() {
  late MapFloweryAppRepoImpl mapFloweryAppRepoImpl;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late CollectionReference<Map<String, dynamic>> mockCollectionReference;
  late DocumentReference<Map<String, dynamic>> mockDocumentReference;
  late DocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  setUp(() {
    provideDummy<BaseResponse<Stream<OrderDetailsModel?>>>(SuccessResponse<Stream<OrderDetailsModel?>>(data: Stream.empty()));
    mockFirebaseFirestore=MockFirebaseFirestore();
    mockCollectionReference=MockCollectionReference();
    mockDocumentReference=MockDocumentReference();
    mockDocumentSnapshot=MockDocumentSnapshot();
    mapFloweryAppRepoImpl=MapFloweryAppRepoImpl(mockFirebaseFirestore);
  },);
  group('MapFloweryAppRepoImpl test cases', () {
    test('success case with success response', () async{
      String dummyOrderId='order_id';
      final testData = {
        'clientLat': '26.8206',
        'clientLong': '30.8025',
        'driverLat': '26.8356',
        'driverLong': '30.8175',
        'driverName': 'John Doe',
        'driverPhoneNumber': '+1234567890',
        'driverPhoto': 'assets/images/driver.jpg',
        'storeLat': '26.8506',
        'storeLong': '30.8325',
        'orderState': 'in_progress',
      };
      final stream = Stream<DocumentSnapshot<Map<String, dynamic>>>.value(mockDocumentSnapshot);
      when(mockFirebaseFirestore.collection(OrderDetailsModel.collectionName)).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(dummyOrderId)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.snapshots()).thenAnswer((_) => stream,);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(testData);
      final result = mapFloweryAppRepoImpl.getOrderTrackingStream(dummyOrderId);
      expect(result, isA<SuccessResponse<Stream<OrderDetailsModel?>>>());
       final resultStream = (result as SuccessResponse).data as Stream<OrderDetailsModel?>;
       await expectLater(
         resultStream,
         emits(
           predicate<OrderDetailsModel?>((model) {
             return model != null && 
               model.clientLat == '26.8206' && 
               model.driverName == 'John Doe';
           }),
         ),
       );
      verify(mockFirebaseFirestore.collection(OrderDetailsModel.collectionName)).called(1);
      verify(mockCollectionReference.doc(dummyOrderId)).called(1);
      verify(mockDocumentReference.snapshots()).called(1);
    },);
    test('success case with null when document does not exist', () async {
      const dummyOrderId = 'order_id';
      final stream = Stream<DocumentSnapshot<Map<String, dynamic>>>.value(mockDocumentSnapshot);
      when(mockFirebaseFirestore.collection(OrderDetailsModel.collectionName)).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(dummyOrderId)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.snapshots()).thenAnswer((_) => stream,);
      when(mockDocumentSnapshot.exists).thenReturn(false);
      final result = mapFloweryAppRepoImpl.getOrderTrackingStream(dummyOrderId);
      expect(result, isA<SuccessResponse<Stream<OrderDetailsModel?>>>());
      final resultStream = (result as SuccessResponse).data as Stream<OrderDetailsModel?>;
      await expectLater(resultStream, emits(null));
    });
    test('error case should return ErrorResponse', () {
      const dummyOrderId = 'order_id';
      when(mockFirebaseFirestore.collection(OrderDetailsModel.collectionName)).thenThrow(Exception('Firestore error'));
      final result = mapFloweryAppRepoImpl.getOrderTrackingStream(dummyOrderId);
      expect(result, isA<ErrorResponse<Stream<OrderDetailsModel?>>>());
      expect((result as ErrorResponse).error, isA<Exception>());
    });
  },);
}