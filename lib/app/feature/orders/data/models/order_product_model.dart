import 'package:json_annotation/json_annotation.dart';
part 'order_product_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final bool? isSuperAdmin;
  final int? sold;
  final num? rateAvg;
  final int? rateCount;

  OrderProductModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}
