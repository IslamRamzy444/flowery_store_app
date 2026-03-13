import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/app/feature/orders/data/models/metadata_model.dart';
import 'package:flower_app/app/feature/orders/data/models/order_model.dart';
import 'package:flower_app/app/feature/orders/data/models/orders_response_model.dart';

void main() {
  group('OrdersResponseModel', () {
    test('creates from JSON correctly', () {
      final json = {
        'message': 'success',
        'results': 2,
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

      final model = OrdersResponseModel.fromJson(json);

      expect(model.message, 'success');
      expect(model.results, 2);
      expect(model.metadata, isA<MetadataModel>());
      expect(model.data, isA<List<OrderModel>>());
      expect(model.data?.length, 1);
    });

    test('converts to JSON correctly', () {
      final model = OrdersResponseModel(
        message: 'success',
        results: 2,
        metadata: MetadataModel(currentPage: 1, numberOfPages: 1, limit: 40),
        data: [OrderModel(id: '123', totalPrice: 600, isDelivered: false)],
      );

      final json = model.toJson();

      expect(json['message'], 'success');
      expect(json['results'], 2);
      expect(json['metadata'], isNotNull);
      expect(json['data'], isA<List>());
    });

    test('handles empty orders list', () {
      final model = OrdersResponseModel(
        message: 'success',
        results: 0,
        data: [],
      );

      expect(model.data, isEmpty);
    });
  });
}
