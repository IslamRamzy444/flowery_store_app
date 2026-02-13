import 'package:flower_app/app/feature/address_details/data/models/cities_dto.dart';
import 'package:flower_app/app/feature/address_details/data/models/countres_dto.dart';
import 'package:flower_app/app/feature/address_details/data/models/states_dto.dart';

abstract class AddressDetailsLocalDataSourceContract {
  Future<CitiesDto> getCities();
  Future<StatesDto> getStates();
  Future<CountresDto> getCountries();
}