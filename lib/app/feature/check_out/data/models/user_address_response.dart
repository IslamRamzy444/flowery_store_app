import 'package:flower_app/app/feature/check_out/data/models/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_address_response.g.dart';

@JsonSerializable()
class UserAddressResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "addresses")
    List<AddressDTO>? addresses;

    UserAddressResponse({
        this.message,
        this.addresses,
    });

    factory UserAddressResponse.fromJson(Map<String, dynamic> json) => _$UserAddressResponseFromJson(json);

    Map<String, dynamic> toJson() => _$UserAddressResponseToJson(this);
}