import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/domain/repo/address_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUsecase {
  AddressDetailsRepoContract addressDetailsRepoContract;
  UpdateAddressUsecase(this.addressDetailsRepoContract);

  Future<BaseResponse<String>> call({String? addressId, String? street, String? phone, String? city, String? lat, String? long, String? username}) {
    return addressDetailsRepoContract.updateAddress(
      addressId: addressId,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username
    );
  }
}