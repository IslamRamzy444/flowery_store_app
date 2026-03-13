import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/cart_product_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_item_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItemDto {
  
  @JsonKey(name: "product")
  ProductCartDto? cartProductDto;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_id")
  String? id;

    CartItemDto({
        this.cartProductDto,
        this.price,
        this.quantity,
        this.id,
    });

    CartItemModel toModel (){
      for(int i=0; i<=4;i++){
        print(id);
      }
      
      return CartItemModel(
        id: id,
        price: price,
        quantity: quantity,
        cartProductModel: cartProductDto?.toModel()
      );
    }

    factory CartItemDto.fromJson(Map<String, dynamic> json) => _$CartItemDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);
}