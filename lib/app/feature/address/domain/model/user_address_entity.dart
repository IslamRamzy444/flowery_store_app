import 'package:equatable/equatable.dart';

class UserAddressEntity extends Equatable {
  final String? addressId;
  final String? city;
  final String? phone;
  final String? lat;
  final String? long;
  final String? userName;

  const UserAddressEntity(
      {this.city, this.phone, this.lat, this.long, this.addressId, this.userName});

  @override
  List<Object?> get props => [addressId, city, phone, lat, long, userName];
}
