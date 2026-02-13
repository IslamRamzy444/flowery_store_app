
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/address_details/domain/models/cities_model.dart';
import 'package:flower_app/app/feature/address_details/domain/models/states_model.dart';
import 'package:flower_app/app/feature/address_details/domain/use_cases/add_address_usecase.dart';
import 'package:flower_app/app/feature/address_details/domain/use_cases/get_cities_usecase.dart';
import 'package:flower_app/app/feature/address_details/domain/use_cases/get_states_usecase.dart';
import 'package:flower_app/app/feature/address_details/domain/use_cases/update_address_usecase.dart';
import 'package:flower_app/app/feature/address_details/presentation/view_model/address_details_events.dart';
import 'package:flower_app/app/feature/address_details/presentation/view_model/address_details_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDetailsViewmodel extends Cubit<AddressDetailsStates>{
  AddressDetailsViewmodel(this._addAddressUsecase,this._updateAddressUsecase,this._getCitiesUsecase,this._getStatesUsecase):super(AddressDetailsStates());

  final AddAddressUsecase _addAddressUsecase;
  final UpdateAddressUsecase _updateAddressUsecase;
  final GetCitiesUsecase _getCitiesUsecase;
  final GetStatesUsecase _getStatesUsecase;
  String? address;
  String? latitude;
  String? longitude;
  String? phone;
  String? city;
  String? area;
  String? selectedCityId;
  String? selectedAreaId;
  String? recipientName;
  TextEditingController addressController = TextEditingController() ;
  List<StatesModel>? areasList ;
  List<CitiesModel>? citiesList ;
  List<StatesModel>? filteredAreasList ;
  List<CitiesModel>? filteredCitiesList ;

  void doIntent(AddressDetailsEvents event){
    switch (event) {
      case AddAddressEvent():
        _addAddress(
          street: event.street,
          phone: event.phone,
          city: event.city,
          lat: event.lat,
          long: event.long,
          username: event.username
        );
      case UpdateAddressEvent():
        _updateAddress(
          addressId: event.addressId,
          street: event.street,
          phone: event.phone,
          city: event.city,
          lat: event.lat,
          long: event.long,
          username: event.username
        );
      case GetAddressFromCoordinatesEvent():
        _getAddressFromCoordinates(
          lat: event.latitude,
          lng: event.longitude
        );

      
      case GetCitiesAndStatesEvent():
        _getCitiesAndStates();

      case GetFilteredStatesEvent():
        _getFilteredStates(
          selectedCityId: event.selectedCityId
        );
    }

  }


  void _addAddress({String? street,String? phone,String? city,String? lat,String? long,String? username}) async {
    emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: true)));
    var response = await _addAddressUsecase.call(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username
    );
   switch (response){
      case SuccessResponse<String>():
        emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: false,success: response.data)));
      case ErrorResponse<String>():
        emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: false,error: response.error)));
    }
    
  }

  void _updateAddress({String? addressId, String? street, String? phone, String? city, String? lat, String? long, String? username}) async {
    emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: true)));
    var response = await _updateAddressUsecase.call(
      addressId: addressId,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username
    );
   switch (response){
      case SuccessResponse<String>():
        emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: false,success: response.data)));
      case ErrorResponse<String>():
        emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: false,error: response.error)));
    }
    
  }

  void _getAddressFromCoordinates({required double lat, required double lng}) async {
    emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: true)));
    try{
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    address = '${placemarks[0].street}';
    addressController.text=address??"";
    latitude = lat.toString();
    longitude = lng.toString();
    emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: false,)));

    }catch(e){
      emit(state.copyWith(addressDetailsStateNew: BaseState(isLoading: false,error: e as Exception)));
    }
    
  }

  void _getCitiesAndStates() async {
    emit(state.copyWith(firstBuildStateNew: BaseState(isLoading: true)));
    areasList = await _getStatesUsecase.call();
    citiesList = await _getCitiesUsecase.call();
    emit(state.copyWith(
      firstBuildStateNew: BaseState(isLoading: false),
    ));
  }

  void _getFilteredStates({String? selectedCityId}) async {
    emit(state.copyWith(
      addressDetailsStateNew: BaseState(isLoading: true),
    ));
    filteredAreasList = areasList?.where((area) => area.governorateId == selectedCityId).toList(); 
    emit(state.copyWith(
      addressDetailsStateNew: BaseState(isLoading: false),
    ));
  }
  
}
