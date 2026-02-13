import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/address_details/domain/models/cities_model.dart';
import 'package:flower_app/app/feature/address_details/domain/models/states_model.dart';

abstract class AddressDetailsRepoContract {
  Future<BaseResponse<String>> addAddress({String? street,String? phone,String? city,String? lat,String? long,String? username});
  Future<BaseResponse<String>> updateAddress({String? addressId, String? street, String? phone, String? city, String? lat, String? long, String? username});
  Future<List<CitiesModel>> getCities();
  Future<List<StatesModel>> getStates();
  //Future<CountriesModel> getCountry({});
}
