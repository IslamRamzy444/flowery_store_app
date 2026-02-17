import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/data/repos/check_out_repo_impl.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/use_cases/get_user_addresses_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_user_addresses_use_case_test.mocks.dart';

@GenerateMocks([CheckOutRepoImpl])
void main() {
  late GetUserAddressesUseCase getUserAddressesUseCase;
  late MockCheckOutRepoImpl mockCheckOutRepoImpl;
  setUpAll(() {
    provideDummy<BaseResponse<List<AddressModel>>>(SuccessResponse<List<AddressModel>>(data: []));
    mockCheckOutRepoImpl=MockCheckOutRepoImpl();
    getUserAddressesUseCase=GetUserAddressesUseCase(mockCheckOutRepoImpl);
  },);
  group('GetUserAddressesUseCase test cases', () {
    test('making sure that is working properly', () async{
      final dummyAddresses=[
        AddressModel(id: 'id1',username: 'username1',city: 'city1'),
        AddressModel(id: 'id2',username: 'username2',city: 'city2'),
      ];
      when(mockCheckOutRepoImpl.getUserAddresses()).thenAnswer(
        (_) async=> SuccessResponse<List<AddressModel>>(data: dummyAddresses),
      );
      final result=await getUserAddressesUseCase.call();
      expect(result, isA<SuccessResponse<List<AddressModel>>>());
      expect((result as SuccessResponse<List<AddressModel>>).data.length, equals(dummyAddresses.length));
      expect(result.data[0].id, equals(dummyAddresses[0].id));
      expect(result.data[0].username, equals(dummyAddresses[0].username));
      expect(result.data[0].city, equals(dummyAddresses[0].city));
      expect(result.data[1].id, equals(dummyAddresses[1].id));
      expect(result.data[1].username, equals(dummyAddresses[1].username));
      expect(result.data[1].city, equals(dummyAddresses[1].city));
      verify(mockCheckOutRepoImpl.getUserAddresses()).called(1);
    },);
    test('failure case with error response', () async{
      final dummyException=Exception("Network Error");
      when(mockCheckOutRepoImpl.getUserAddresses()).thenAnswer(
        (_) async=> ErrorResponse<List<AddressModel>>(error: dummyException),
      );
      final result=await getUserAddressesUseCase.call();
      expect(result, isA<ErrorResponse<List<AddressModel>>>());
      expect((result as ErrorResponse<List<AddressModel>>).error.toString(), equals(dummyException.toString()));
      verify(mockCheckOutRepoImpl.getUserAddresses()).called(1);
    },);
  },);
}