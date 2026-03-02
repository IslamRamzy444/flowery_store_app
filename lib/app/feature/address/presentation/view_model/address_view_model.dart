import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/custom_cubit.dart';
import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:flower_app/app/feature/address/domain/use_case/delete_user_address_use_case.dart';
import 'package:flower_app/app/feature/address/domain/use_case/get_user_addresses_use_case.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_event.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_intent.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import 'address_state.dart';

@injectable
class AddressViewModel extends CustomCubit<AddressEvent, AddressState> {
  final GetUserAddressesUseCase _getAddressUseCase;
  final DeleteUserAddressUseCase _deleteAddressUseCase;

  AddressViewModel(this._getAddressUseCase, this._deleteAddressUseCase)
    : super(AddressState(addressState: BaseState()));

  Future<void> _getUserAddresses() async {
    emit(state.copyWith(addressState: BaseState(isLoading: true)));
    final response = await _getAddressUseCase.invoke();
    switch (response) {
      case SuccessResponse<List<UserAddressEntity>>():
        emit(state.copyWith(
            addressState: BaseState(isLoading: false, success: response.data)));
        break;
      case ErrorResponse<List<UserAddressEntity>>():
        emit(state.copyWith(
            addressState: BaseState(isLoading: false, error: response.error)));
        break;
    }
  }

  Future<void> _deleteUserAddress(String id) async {

    final response = await _deleteAddressUseCase.invoke(id);
    switch (response) {
      case SuccessResponse<List<UserAddressEntity>>():
        _getUserAddresses();

        break;
      case ErrorResponse<List<UserAddressEntity>>():
        emit(state.copyWith(
            addressState: BaseState(isLoading: false, error: response.error)));
        break;
    }
  }

  void doIntent(AddressIntent intent) {
    switch (intent) {
      case GetUserAddressesAction():
        _getUserAddresses();
        break;
      case DeleteUserAddressAction():
        _deleteUserAddress(intent.id);
        break;
      case UpdateUserAddressAction():
        streamController.add(
          NavigateToUpdateAddressEvent(address: intent.address),
        );
        break;
      case BackToProfileScreenAction():
        streamController.add(NavigateBackToProfileEvent());
        break;
    }
  }
}
