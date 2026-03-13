import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/orders/data/api_client/orders_api_client.dart';
import 'package:flower_app/app/feature/orders/data/data_sources/orders_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/orders/data/models/orders_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_remote_data_source_test.mocks.dart';

@GenerateMocks([OrdersApiClient])
void main() {
  late MockOrdersApiClient mockApiClient;
  late OrdersRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockOrdersApiClient();
    dataSource = OrdersRemoteDataSourceImpl(mockApiClient);
  });

  group('OrdersRemoteDataSource', () {
    final mockResponse = {
      'message': 'success',
      'results': 1,
      'metadata': {'currentPage': 1, 'numberOfPages': 1, 'limit': 40},
      'data': [
        {
          '_id': '123',
          'user': 'user123',
          'orderItems': [],
          'totalPrice': 600,
          'paymentMethod': 'cash',
          'isPaid': false,
          'paidAt': null,
          'isDelivered': false,
          'deliveredAt': null,
          'createdAt': '2024-09-03T10:00:00.000Z',
          'updatedAt': '2024-09-03T10:00:00.000Z',
          '__v': 0,
        },
      ],
    };

    test('returns SuccessResponse when API call succeeds', () async {
      when(mockApiClient.getUserOrders()).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getUserOrders();

      expect(result, isA<SuccessResponse<OrdersResponseModel>>());
      final successResponse = result as SuccessResponse<OrdersResponseModel>;
      expect(successResponse.data.message, 'success');
      expect(successResponse.data.data?.length, 1);
      verify(mockApiClient.getUserOrders()).called(1);
    });

    test('parses order data correctly', () async {
      when(mockApiClient.getUserOrders()).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getUserOrders();
      final successResponse = result as SuccessResponse<OrdersResponseModel>;
      final firstOrder = successResponse.data.data?.first;

      expect(firstOrder?.id, '123');
      expect(firstOrder?.totalPrice, 600);
      expect(firstOrder?.paymentMethod, 'cash');
      expect(firstOrder?.isDelivered, false);
    });

    test('returns ErrorResponse when API call throws exception', () async {
      when(mockApiClient.getUserOrders()).thenThrow(Exception('Network error'));

      final result = await dataSource.getUserOrders();

      expect(result, isA<ErrorResponse<OrdersResponseModel>>());
      verify(mockApiClient.getUserOrders()).called(1);
    });

    test('handles empty orders list', () async {
      final emptyResponse = {
        'message': 'success',
        'results': 0,
        'metadata': {'currentPage': 1, 'numberOfPages': 1, 'limit': 40},
        'data': [],
      };

      when(
        mockApiClient.getUserOrders(),
      ).thenAnswer((_) async => emptyResponse);

      final result = await dataSource.getUserOrders();
      final successResponse = result as SuccessResponse<OrdersResponseModel>;

      expect(successResponse.data.data, isEmpty);
    });
  });
}
