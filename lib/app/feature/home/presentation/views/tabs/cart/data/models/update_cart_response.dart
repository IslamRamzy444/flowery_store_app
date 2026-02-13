import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_cart_response.g.dart';

@JsonSerializable()
class UpdateCartResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "error")
    String? error;
    @JsonKey(name: "numOfCartItems")
    int? numOfCartItems;
    @JsonKey(name: "cart")
    CartDto? cart;

    UpdateCartResponse({
        this.message,
        this.numOfCartItems,
        this.cart,
    });

    UpdateCartModel toModel(){
      return UpdateCartModel(
        cart: cart?.toModel(),
        error: error,
        message: message,
        numOfCartItems: numOfCartItems
      );
    }

    factory UpdateCartResponse.fromJson(Map<String, dynamic> json) => _$UpdateCartResponseFromJson(json);

    Map<String, dynamic> toJson() => _$UpdateCartResponseToJson(this);
}



