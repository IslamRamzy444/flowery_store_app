import 'package:flower_app/app/feature/address_details/domain/models/states_model.dart';
import 'package:flower_app/app/feature/address_details/domain/repo/address_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetStatesUsecase {
  AddressDetailsRepoContract addressDetailsRepoContract;
  GetStatesUsecase(this.addressDetailsRepoContract);

  Future<List<StatesModel>> call() {
    return addressDetailsRepoContract.getStates();
  }
}