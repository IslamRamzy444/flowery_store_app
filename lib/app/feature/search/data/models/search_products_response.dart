import 'package:json_annotation/json_annotation.dart';
import 'metadata_dto.dart';
import 'product_dto.dart';

part 'search_products_response.g.dart';

@JsonSerializable()
class SearchProductsResponse {
  final String? message;
  final MetadataDto? metadata;
  final List<ProductDto>? products;

  SearchProductsResponse({this.message, this.metadata, this.products});

  factory SearchProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductsResponseToJson(this);
}
