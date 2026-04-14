import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/app/feature/orders/data/models/order_model.dart';

void main() {
  group('OrderModel', () {
    test('creates from JSON correctly', () {
      final json = {
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
      };

      final model = OrderModel.fromJson(json);

      expect(model.id, '123');
      expect(model.user, 'user123');
      expect(model.totalPrice, 600);
      expect(model.paymentMethod, 'cash');
      expect(model.isPaid, false);
      expect(model.isDelivered, false);
      expect(model.version, 0);
    });

    test('converts to JSON correctly', () {
      final model = OrderModel(
        id: '123',
        user: 'user123',
        totalPrice: 600,
        paymentMethod: 'cash',
        isPaid: false,
        isDelivered: false,
      );

      final json = model.toJson();

      expect(json['_id'], '123');
      expect(json['user'], 'user123');
      expect(json['totalPrice'], 600);
      expect(json['paymentMethod'], 'cash');
    });

    test('handles delivered order', () {
      final model = OrderModel(
        isDelivered: true,
        deliveredAt: '2024-09-03T10:00:00.000Z',
      );

      expect(model.isDelivered, true);
      expect(model.deliveredAt, isNotNull);
    });

    test('handles active order', () {
      final model = OrderModel(isDelivered: false);

      expect(model.isDelivered, false);
    });

    test('handles null values', () {
      final model = OrderModel();

      expect(model.id, null);
      expect(model.isDelivered, null);
      expect(model.deliveredAt, null);
    });
  });
}
