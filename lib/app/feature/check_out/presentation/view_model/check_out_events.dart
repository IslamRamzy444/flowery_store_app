sealed class CheckOutEvents {}
class GetUserAddressesEvent extends CheckOutEvents{}
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