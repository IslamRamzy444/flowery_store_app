import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/data/models/add_and_update_addresses_dto.dart';

abstract class AddressDetailsRemoteDataSourceContract {
  Future<BaseResponse<AddAndUpdateAddressesDto>> addAddress({String? street,String? phone,String? city,String? lat,String? long,String? username});
  Future<BaseResponse<AddAndUpdateAddressesDto>> updateAddress({String? addressId, String? street, String? phone, String? city, String? lat, String? long, String? username});
}