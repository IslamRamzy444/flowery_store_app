import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_address_response.g.dart';

@JsonSerializable()
class UserAddressResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<AddressesDto>? addresses;

  UserAddressResponse({this.message, this.addresses});

  factory UserAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$UserAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserAddressResponseToJson(this);
  }

  UserAddressEntity toUserAddressEntity(AddressesDto address) {
    return UserAddressEntity(
      street: address.street,
      city: address.city,
      lat: address.lat,
      long: address.long,
      addressId: address.id,
      phone: address.phone,
      userName: address.username,
    );
  }
}

@JsonSerializable()
class AddressesDto {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "_id")
  final String? id;

  AddressesDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AddressesDto.fromJson(Map<String, dynamic> json) {
    return _$AddressesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressesDtoToJson(this);
  }
}
