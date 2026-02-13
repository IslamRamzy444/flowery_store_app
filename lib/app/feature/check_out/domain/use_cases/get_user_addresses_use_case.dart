import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/repos/check_out_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetUserAddressesUseCase {
  final CheckOutRepoContract _checkOutRepoContract;
  GetUserAddressesUseCase(this._checkOutRepoContract);
  Future<BaseResponse<List<AddressModel>>> call()async{
    return _checkOutRepoContract.getUserAddresses();
  }
}