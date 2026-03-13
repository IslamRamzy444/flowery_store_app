import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? user;
  final List<OrderItemModel>? orderItems;
  final num? totalPrice;
  final String? paymentMethod;
  final bool? isPaid;
  final String? paidAt;
  final bool? isDelivered;
  final String? deliveredAt;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  OrderModel({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentMethod,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
