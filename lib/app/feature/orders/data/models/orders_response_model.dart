import 'package:json_annotation/json_annotation.dart';
import 'metadata_model.dart';
import 'order_model.dart';

part 'orders_response_model.g.dart';

@JsonSerializable()
class OrdersResponseModel {
  final String? message;
  final int? results;
  final MetadataModel? metadata;
  final List<OrderModel>? data;

  OrdersResponseModel({this.message, this.results, this.metadata, this.data});

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseModelToJson(this);
}
