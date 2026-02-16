import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';

sealed class CheckOutEvents {}
class GetUserAddressesEvent extends CheckOutEvents{}
class SelectAddressEvent extends CheckOutEvents{
  final AddressModel? address;
  SelectAddressEvent(this.address);
}
class SelectPaymentMethodEvent extends CheckOutEvents {
  final String paymentMethodKey;
  SelectPaymentMethodEvent(this.paymentMethodKey);
}
class PayCashEvent extends CheckOutEvents{
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  PayCashEvent({this.street,this.phone,this.city,this.lat,this.long});
}
class PayCreditEvent extends CheckOutEvents{
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  PayCreditEvent({this.street,this.phone,this.city,this.lat,this.long});
}