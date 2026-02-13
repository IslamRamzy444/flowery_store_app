import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/domain/repo/address_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUsecase {
  AddressDetailsRepoContract addressDetailsRepoContract;
  AddAddressUsecase(this.addressDetailsRepoContract);
  
  Future<BaseResponse<String>> call({String? street,String? phone,String? city,String? lat,String? long,String? username}) {
    return addressDetailsRepoContract.addAddress(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username
    );
  }
}