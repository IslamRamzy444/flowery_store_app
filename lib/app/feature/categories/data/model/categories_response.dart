import 'package:flower_app/app/core/model/meta_data/meta_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/categories_entity.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "categories")
  final List<Categories>? categories;

  CategoriesResponse({this.message, this.metadata, this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesResponseToJson(this);
  }

  CategoriesEntity toAllCategoriesEntity() {
    List<CategoryEntity>? allCategories = [];
    allCategories = List.generate(categories!.length, (index) {
      return CategoryEntity(
        id: categories?[index].id ?? '',
        title: categories?[index].name ?? '',
      );
    });
    return CategoriesEntity(categoriesEntity: allCategories);
  }
}

@JsonSerializable()
class Categories {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "productsCount")
  final int? productsCount;

  Categories({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.productsCount,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return _$CategoriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesToJson(this);
  }
}
