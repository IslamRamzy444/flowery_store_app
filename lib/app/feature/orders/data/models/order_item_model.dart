import 'package:json_annotation/json_annotation.dart';
import 'order_product_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final OrderProductModel? product;
  final int? quantity;
  final num? price;
  @JsonKey(name: '_id')
  final String? id;

  OrderItemModel({this.product, this.quantity, this.price, this.id});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
