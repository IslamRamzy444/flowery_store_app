import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/app/config/base_error/custom_exceptions.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:flower_app/app/feature/address/domain/use_case/delete_user_address_use_case.dart';
import 'package:flower_app/app/feature/address/domain/use_case/get_user_addresses_use_case.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_event.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_intent.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_state.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_view_model_test.mocks.dart';
@GenerateMocks([GetUserAddressesUseCase, DeleteUserAddressUseCase])
void main() {
  late GetUserAddressesUseCase getUserAddressesUseCase;
  late DeleteUserAddressUseCase deleteUserAddressUseCase;
  late UserAddressEntity userAddressEntity;
  late AddressViewModel addressViewModel;
  setUpAll(() {
    getUserAddressesUseCase = MockGetUserAddressesUseCase();
    deleteUserAddressUseCase = MockDeleteUserAddressUseCase();
    userAddressEntity = UserAddressEntity();
  });
  setUp(() {
    addressViewModel = AddressViewModel(
      getUserAddressesUseCase,
      deleteUserAddressUseCase,
    );
  });

  group('get addresses', () {
    blocTest(
      'when calling dointent with get user addresses   action it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<UserAddressEntity>>>(
          SuccessResponse(data: [userAddressEntity]),
        );
        when(getUserAddressesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [userAddressEntity]));
        });
      },
      build: () => addressViewModel,
      act: (bloc) {
        addressViewModel.doIntent(GetUserAddressesAction());
      },
      expect: () {
        var state = AddressState(addressState: BaseState());
        return [
          state.copyWith(addressState: BaseState(isLoading: true)),
          state.copyWith(
            addressState: BaseState(
              isLoading: false,
              success: [userAddressEntity],
            ),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with get user addresses action with error it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<UserAddressEntity>>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(getUserAddressesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
      },
      build: () => addressViewModel,
      act: (bloc) {
        addressViewModel.doIntent(GetUserAddressesAction());
      },
      expect: () {
        var state = AddressState(addressState: BaseState());
        return [
          state.copyWith(addressState: BaseState(isLoading: true)),
          state.copyWith(addressState: BaseState(error: UnexpectedError())),
        ];
      },
    );
  });
  group('delete address', () {
    blocTest(
      'when calling dointent with delete user address   action it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<UserAddressEntity>>>(
          SuccessResponse(data: [userAddressEntity]),
        );
        when(getUserAddressesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [userAddressEntity]));
    });
        when(deleteUserAddressUseCase.invoke('1')).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [userAddressEntity]));
        });
      },
      build: () => addressViewModel,
      act: (bloc) {
        addressViewModel.doIntent(DeleteUserAddressAction('1'));
      },
      expect: () {
        var state = AddressState(addressState: BaseState());
        return [
          state.copyWith(addressState: BaseState(isLoading: true)),
          state.copyWith(
            addressState: BaseState(
              isLoading: false,
              success: [userAddressEntity],
            ),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with delete user address action with error it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<List<UserAddressEntity>>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(getUserAddressesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: [userAddressEntity]));
        });
        when(deleteUserAddressUseCase.invoke('1')).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
      },
      build: () => addressViewModel,
      act: (bloc) {
        addressViewModel.doIntent(DeleteUserAddressAction('1'));
      },
      expect: () {
        var state = AddressState(addressState: BaseState());
        return [
          state.copyWith(addressState: BaseState(isLoading: true)),
          state.copyWith(addressState: BaseState(error: UnexpectedError())),
        ];
      },
    );
  });

  test('Navigation to update address emits event (broadcast)', () async {
    final future = expectLater(
      addressViewModel.streamController.stream,
      emits(isA<NavigateToUpdateAddressEvent>()),
    );

    addressViewModel.doIntent(UpdateUserAddressAction());

    await future;
  });
}
