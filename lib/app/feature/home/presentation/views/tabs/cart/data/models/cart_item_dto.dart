import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_item_model.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItemDto {
    @JsonKey(name: "product")
    Product? product;
    @JsonKey(name: "price")
    int? price;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "_id")
    String? id;

    CartItemDto({
        this.product,
        this.price,
        this.quantity,
        this.id,
    });

    CartItemModel toModel (){
      return CartItemModel(
        id: id,
        price: price,
        quantity: quantity,
        product: product?.toModel()
      );
    }

    factory CartItemDto.fromJson(Map<String, dynamic> json) => _$CartItemDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);
}