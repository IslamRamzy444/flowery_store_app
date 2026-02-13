import 'package:flower_app/app/feature/address_details/domain/models/cities_model.dart';
import 'package:flower_app/app/feature/address_details/domain/repo/address_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCitiesUsecase {
  AddressDetailsRepoContract addressDetailsRepoContract;
  GetCitiesUsecase(this.addressDetailsRepoContract);

  Future<List<CitiesModel>> call() {
    return addressDetailsRepoContract.getCities();
  }

}