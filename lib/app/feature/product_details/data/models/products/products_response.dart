import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/model/meta_data/meta_data_dto.dart';
import '../../../domain/models/products_entity.dart';
import '../product_details_dto.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "products")
  final List<Product>? products;

  ProductsResponse({this.message, this.metadata, this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsResponseToJson(this);
  }

  ProductsEntity toProductsEntity() {
    List<ProductDetailsModel>? productsEntity = products?.map((e) {
      return ProductDetailsModel(
        imgCover: e.imgCover,
        title: e.title,
        price: e.price,
        priceAfterDiscount: e.priceAfterDiscount,
        id: e.id,
      );
    }).toList();
    return ProductsEntity(product: productsEntity);
  }
}
