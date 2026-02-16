import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_dto.g.dart';
@JsonSerializable()
class AddressDTO {
    @JsonKey(name: "street")
    String? street;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "city")
    String? city;
    @JsonKey(name: "lat")
    String? lat;
    @JsonKey(name: "long")
    String? long;
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "_id")
    String? id;

    AddressDTO({
        this.street,
        this.phone,
        this.city,
        this.lat,
        this.long,
        this.username,
        this.id,
    });

    factory AddressDTO.fromJson(Map<String, dynamic> json) => _$AddressDTOFromJson(json);

    Map<String, dynamic> toJson() => _$AddressDTOToJson(this);
    AddressModel toDomain(){
      return AddressModel(
        city: city,
        street: street,
        id: id,
        lat: lat,
        long: long,
        phone: phone,
        username: username
      );
    }
}