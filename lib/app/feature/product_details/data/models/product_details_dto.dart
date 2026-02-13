import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_dto.g.dart';

@JsonSerializable()
class ProductDetailsDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "product")
    Product? product;

    ProductDetailsDto({
        this.message,
        this.product,
    });

    factory ProductDetailsDto.fromJson(Map<String, dynamic> json) => _$ProductDetailsDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ProductDetailsDtoToJson(this);

    ProductDetailsModel toModel(){
      return ProductDetailsModel(
        message: message,
        description: product?.description,
        id: product?.id,
        images: product?.images,
        price: product?.price,
        priceAfterDiscount: product?.priceAfterDiscount,
        quantity: product?.quantity,
        rateAvg: product?.rateAvg,
        rateCount: product?.rateCount,
        sold: product?.sold,
        title: product?.title
      );
    }


}

@JsonSerializable()
class Product {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "slug")
    String? slug;
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "imgCover")
    String? imgCover;
    @JsonKey(name: "images")
    List<String?>? images;
    @JsonKey(name: "price")
    double? price;
    @JsonKey(name: "priceAfterDiscount")
    double? priceAfterDiscount;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "category")
    String? category;
    @JsonKey(name: "occasion")
    String? occasion;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;
    @JsonKey(name: "isSuperAdmin")
    bool? isSuperAdmin;
    @JsonKey(name: "sold")
    int? sold;
    @JsonKey(name: "rateAvg")
    double? rateAvg;
    @JsonKey(name: "rateCount")
    int? rateCount;
    @JsonKey(name: "favoriteId")
    dynamic favoriteId;
    @JsonKey(name: "isInWishlist")
    bool? isInWishlist;

    Product({
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
        this.v,
        this.isSuperAdmin,
        this.sold,
        this.rateAvg,
        this.rateCount,
        this.favoriteId,
        this.isInWishlist,
    });

    ProductDetailsModel toModel(){
      return ProductDetailsModel(
        description: description,
        id: id,
        images: images,
        price: price,
        priceAfterDiscount: priceAfterDiscount,
        quantity: quantity,
        rateAvg: rateAvg,
        rateCount: rateCount,
        sold: sold,
        title: title,
        coverImage: imgCover
      );
    }

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

    Map<String, dynamic> toJson() => _$ProductToJson(this);
}
