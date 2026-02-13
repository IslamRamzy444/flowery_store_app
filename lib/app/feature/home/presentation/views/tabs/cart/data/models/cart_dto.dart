import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/cart_item_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_dto.g.dart';



@JsonSerializable()
class CartDto {
    @JsonKey(name: "user")
    String? user;
    @JsonKey(name: "cartItems")
    List<CartItemDto>? cartItems;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "appliedCoupons")
    List<dynamic>? appliedCoupons;
    @JsonKey(name: "totalPrice")
    double? totalPrice;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;

    CartDto({
        this.user,
        this.cartItems,
        this.id,
        this.appliedCoupons,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    CartModel toModel(){
      return CartModel(
        appliedCoupons: appliedCoupons,
        cartItems: cartItems?.map((e){return e.toModel();}).toList(),
        id: id,
        totalPrice: totalPrice,
        user: user
      );
    }

    factory CartDto.fromJson(Map<String, dynamic> json) => _$CartDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}