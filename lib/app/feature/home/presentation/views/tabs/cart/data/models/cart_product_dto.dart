import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_product_dto.g.dart';



@JsonSerializable()
class ProductCartDto {
    
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "slug")
    String? slug;
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "imgCover")
    String? imgCover;
    @JsonKey(name: "images")
    List<String>? images;
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
    int? rateAvg;
    @JsonKey(name: "rateCount")
    int? rateCount;
    @JsonKey(name: "id")
    String? productId;

    ProductCartDto({
        this.productId,
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
    });
    
    CartProductModel? toModel(){
      return CartProductModel(
        id: productId,
        description: description,
        imgCover: imgCover,
        price: price,
        quantity: quantity,
        title: title,
        priceAfterDiscount: priceAfterDiscount,
      );
    }

    factory ProductCartDto.fromJson(Map<String, dynamic> json) => _$ProductCartDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ProductCartDtoToJson(this);
}
