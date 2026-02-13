import 'package:json_annotation/json_annotation.dart';

part 'add_and_update_addresses_dto.g.dart';

@JsonSerializable()
class AddAndUpdateAddressesDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "address")
    List<Address>? address;

    AddAndUpdateAddressesDto({
        this.message,
        this.address,
    });

    factory AddAndUpdateAddressesDto.fromJson(Map<String, dynamic> json) => _$AddAndUpdateAddressesDtoFromJson(json);

    Map<String, dynamic> toJson() => _$AddAndUpdateAddressesDtoToJson(this);
}

@JsonSerializable()
class Address {
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

    Address({
        this.street,
        this.phone,
        this.city,
        this.lat,
        this.long,
        this.username,
        this.id,
    });

    factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

    Map<String, dynamic> toJson() => _$AddressToJson(this);
}
