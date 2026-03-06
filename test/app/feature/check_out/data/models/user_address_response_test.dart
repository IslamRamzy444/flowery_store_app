import 'package:flower_app/app/feature/check_out/data/models/user_address_response.dart';
import 'package:test/test.dart';

void main() {
  group('UserAddressResponse test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "message":"message1",
        "addresses":[]
      };
      final dto=UserAddressResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
      expect(dto.addresses, equals(json['addresses']));
    },);
    test('toJson should serialize all fields', () {
      final dto=UserAddressResponse(
        addresses: [],
        message: "message 1"
      );
      final json=dto.toJson();
      expect(json['addresses'], equals(dto.addresses));
      expect(json['message'], equals(dto.message));
    },);
  },);
}