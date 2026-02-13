import 'dart:convert';
import 'package:flower_app/app/feature/address_details/data/data_sources/address_details_local_data_source_contract.dart';
import 'package:flower_app/app/feature/address_details/data/models/cities_dto.dart';
import 'package:flower_app/app/feature/address_details/data/models/countres_dto.dart';
import 'package:flower_app/app/feature/address_details/data/models/states_dto.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsLocalDataSourceContract)
class  AddressDetailsLocalDataSourceImpl extends AddressDetailsLocalDataSourceContract {
  @override
  Future<CitiesDto> getCities() async {
    var response =await rootBundle.loadString('assets/jsonFiles/cities.json');
    var jsonList = jsonDecode(response);
    var jsonTable = jsonList.firstWhere((e) => e['type'] == 'table' && e['name'] == 'governorates',);
    return CitiesDto.fromJson(jsonTable);
  }

  @override
  Future<CountresDto> getCountries() async {
    var response = await rootBundle.loadString('assets/jsonFiles/country.json');
    var jsonList = jsonDecode(response);
    var jsonTable = jsonList.firstWhere((e) => e['type'] == 'table' && e['name'] == 'governorates',);
    return CountresDto.fromJson(jsonTable);
  }

  @override
  Future<StatesDto> getStates() async {
    var response = await rootBundle.loadString('assets/jsonFiles/states.json');
    var jsonList = jsonDecode(response);
    var jsonTable = jsonList.firstWhere((e) => e['type'] == 'table' && e['name'] == 'cities',);
    return StatesDto.fromJson(jsonTable);
  }

}