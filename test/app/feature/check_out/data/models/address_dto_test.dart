import 'package:flower_app/app/feature/check_out/data/models/address_dto.dart';
import 'package:test/test.dart';
void main() {
  group('AddressDTO test cases',() {
    test('fromJson should parse all fields', () {
      final json = {
        '_id': '123',
        'username': 'test-user-name',
        'street': 'test-street',
        'phone':'test-phone',
        'city':'test-city',
        'lat':'test-lat',
        'long':'test-long',
      };
      final dto=AddressDTO.fromJson(json);
      expect(dto.id, equals(json['_id']));
      expect(dto.username, equals(json['username']));
      expect(dto.street, equals(json['street']));
      expect(dto.city, equals(json['city']));
      expect(dto.lat, equals(json['lat']));
      expect(dto.long, equals(json['long']));
      expect(dto.phone, equals(json['phone']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=AddressDTO(
        id: 'id1',
        city: 'city1',
        lat: 'lat1',
        long: 'long1',
        phone: 'phone1',
        street: 'street1',
        username: 'username1'
      );
      final model=dto.toDomain();
      expect(model.id, equals(dto.id));
      expect(model.city, equals(dto.city));
      expect(model.lat, equals(dto.lat));
      expect(model.long, equals(dto.long));
      expect(model.phone, equals(dto.phone));
      expect(model.username, equals(dto.username));
    },);
    test('toJson should serialized all fields', () {
      final dto=AddressDTO(
        id: 'id1',
        city: 'city1',
        lat: 'lat1',
        long: 'long1',
        phone: 'phone1',
        street: 'street1',
        username: 'username1'
      );
      final json=dto.toJson();
      expect(json['_id'],equals(dto.id));
      expect(json['city'],equals(dto.city));
      expect(json['lat'],equals(dto.lat));
      expect(json['long'],equals(dto.long));
      expect(json['phone'],equals(dto.phone));
      expect(json['street'],equals(dto.street));
      expect(json['username'],equals(dto.username));
    },);
  },);
}