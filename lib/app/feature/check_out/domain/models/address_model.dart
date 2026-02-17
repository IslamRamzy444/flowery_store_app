import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';

class AddressModel{
  String? street;
  String? city;
  String? lat;
  String? long;
  String? id;
  String? phone;
  String? username;
  AddressModel({this.street,this.city,this.lat,this.long,this.id,this.phone,this.username});
  UserAddressEntity converter(){
    return UserAddressEntity(
      addressId: id,
      city: city,
      lat: lat,
      long: long,
      phone: phone,
      userName: username
    );
  }
}