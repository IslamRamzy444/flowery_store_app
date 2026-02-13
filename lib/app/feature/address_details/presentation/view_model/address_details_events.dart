sealed class AddressDetailsEvents {}
class AddAddressEvent extends AddressDetailsEvents {
  String street;
  String phone;
  String city;
  String lat;
  String long;
  String username;

  AddAddressEvent({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });
}

class UpdateAddressEvent extends AddressDetailsEvents {
  String addressId;
  String street;
  String phone;
  String city;
  String lat;
  String long;
  String username;

  UpdateAddressEvent({
    required this.addressId,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });
}

class GetAddressFromCoordinatesEvent extends AddressDetailsEvents {
  double latitude;
  double longitude;

  GetAddressFromCoordinatesEvent({
    required this.latitude,
    required this.longitude,
  });
}

class GetFilteredStatesEvent extends AddressDetailsEvents {
  String? selectedCityId;

  GetFilteredStatesEvent({this.selectedCityId});
}

class GetCitiesAndStatesEvent extends AddressDetailsEvents {}
