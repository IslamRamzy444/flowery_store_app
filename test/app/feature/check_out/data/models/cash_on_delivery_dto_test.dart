import 'package:flower_app/app/feature/check_out/data/models/cash_on_delivery_dto.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';
import 'package:test/test.dart';

void main() {
  group('CashOnDeliveryDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "message":"test-message",
      };
      final dto=CashOnDeliveryDto.fromJson(json);
      expect(dto.message, equals(json['message']));
    },);
    test('toModel should parse relative fields', () {
      final dto=CashOnDeliveryDto(
        message: 'message1',
        order: Order(id: 'id1',orderNumber: 'number1')
      );
      final model=dto.toModel();
      expect(model.message, equals(dto.message));
      expect(model.orderNumber, equals(dto.order?.orderNumber));
    },);
    test('toJson should serialize all fields', () {
      final dto=CashOnDeliveryDto(
        message: 'message1',
        order: Order(id: 'id1',orderNumber: 'number1')
      );
      final json=dto.toJson();
      expect(json['message'], equals(dto.message));
      expect(json['order'], equals(dto.order));
    },);
  },);
  group('order test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "user":"user1",
        "orderItems":[],
        "totalPrice":0,
        "_id":"id1"
      };
      final dto=Order.fromJson(json);
      expect(dto.user, equals(json["user"]));
      expect(dto.orderItems, equals(json["orderItems"]));
      expect(dto.totalPrice, equals(json["totalPrice"]));
      expect(dto.id, equals(json["_id"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=Order(
        user: 'user1',
        orderItems: [],
        totalPrice: 0,
        id: 'id1'
      );
      final json=dto.toJson();
      expect(json["user"], equals(dto.user));
      expect(json["orderItems"], equals(dto.orderItems));
      expect(json["totalPrice"], equals(dto.totalPrice));
      expect(json["_id"], equals(dto.id));
    },);
  },);
  group('OrderItem test cases',(){
    test('fromJson should parse all fields',(){
      final json={
        "_id":"id1",
        "price":300,
        "quantity":2
      };
      final dto=OrderItem.fromJson(json);
      expect(dto.id, equals(json["_id"]));
      expect(dto.price, equals(json["price"]));
      expect(dto.quantity, equals(json["quantity"]));
    });
    test('toJson should serialize all fields', () {
      final dto=OrderItem(
        id: 'id1',
        price: 300,
        product: Product(id: 'product_id1'),
        quantity: 2
      );
      final json=dto.toJson();
      expect(json["_id"], equals(dto.id));
      expect(json["price"], equals(dto.price));
      expect(json["product"], equals(dto.product));
      expect(json["quantity"], equals(dto.quantity));
    },);
  });
}