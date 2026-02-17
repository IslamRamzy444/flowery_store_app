import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:test/test.dart';

void main() {
 test('making sure that converter map all relevant fields', () {
   final addressModel=AddressModel(
    city: 'city1',
    id: 'id1',
    lat: 'lat1',
    long: 'long1',
    phone: 'phone1',
    street: 'street1',
    username: 'username1'
   );
   final convertedEntity=addressModel.converter();
   expect(convertedEntity.addressId, equals(addressModel.id));
   expect(convertedEntity.city, equals(addressModel.city));
   expect(convertedEntity.lat, equals(addressModel.lat));
   expect(convertedEntity.long, equals(addressModel.long));
   expect(convertedEntity.phone, equals(addressModel.phone));
   expect(convertedEntity.userName, equals(addressModel.username));
 },);
}