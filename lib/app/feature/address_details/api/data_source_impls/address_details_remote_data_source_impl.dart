import 'package:flower_app/app/config/api_utils/api_utils.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/api/api_client/api_client.dart';
import 'package:flower_app/app/feature/address_details/data/data_sources/address_details_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/address_details/data/models/add_and_update_addresses_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsRemoteDataSourceContract)
class AddressDetailsRemoteDataSourceImpl implements AddressDetailsRemoteDataSourceContract{
  AddressDetailsApiClient apiClient;
  AddressDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<AddAndUpdateAddressesDto>> addAddress({String? street, String? phone, String? city, String? lat, String? long, String? username})async {
    return await executeApi(()=>apiClient.addAddresses({
      "street":street,
      "phone":phone,
      "city":city,
      "lat":lat,
      "long":long,
      "username":username
    })
    );
  }

  
  @override
  Future<BaseResponse<AddAndUpdateAddressesDto>> updateAddress({String? addressId, String? street, String? phone, String? city, String? lat, String? long, String? username})async {
    return await executeApi(()=>apiClient.updateAddress(addressId: addressId, body: {
      "street":street,
      "phone":phone,
      "city":city,
      "lat":lat,
      "long":long,
      "username":username
    })
    );


  }

}