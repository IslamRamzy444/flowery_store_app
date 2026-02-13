import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/clear_cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clear_user_cart_dto.g.dart';

@JsonSerializable()
class ClearUserCartDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "error")
    String? error;

    ClearUserCartDto({
        this.message,
        this.error,
    });

    ClearCartModel toModel(){
      return ClearCartModel(error: error,message: message);
    }

    factory ClearUserCartDto.fromJson(Map<String, dynamic> json) => _$ClearUserCartDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ClearUserCartDtoToJson(this);
}
