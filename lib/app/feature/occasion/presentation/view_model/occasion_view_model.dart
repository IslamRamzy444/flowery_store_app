import 'package:flower_app/app/config/base_state/custom_cubit.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_temp_events.dart';
import 'package:flower_app/app/feature/product_details/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/occasion/data/models/occasion_model.dart';
import 'package:flower_app/app/feature/occasion/domain/use_cases/get_all_occasions_use_case.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_events.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionViewModel extends CustomCubit<OccasionTempEvents,OccasionStates> {
  final GetAllOccasionsUseCase _getAllOccasionsUseCase;
  final AddProductToCartUsecase _addProductToCartUsecase;
  OccasionViewModel(this._getAllOccasionsUseCase,this._addProductToCartUsecase)
    : super(const OccasionStates());

  void doIntent(OccasionEvents event) {
    switch (event) {
      case GetAllOccasionsEvent():
        _getAllOccasions();
        break;
      case SelectTabEvent():
        _selectTab(event.index);
        break;
      case AddProductToCartEventOccasion():
        _addProductToCart(productId: event.productId, quantity: event.quantity);
    }
  }

  Future<void> _getAllOccasions() async {
    emit(state.copyWith(occasionsState: BaseState(isLoading: true)));

    final response = await _getAllOccasionsUseCase();

    switch (response) {
      case SuccessResponse<List<OccasionModel>>():
        emit(
          state.copyWith(
            occasionsState: BaseState(isLoading: false, success: response.data),
          ),
        );
        break;
      case ErrorResponse<List<OccasionModel>>():
        emit(
          state.copyWith(
            occasionsState: BaseState(
              isLoading: false,
              error: Exception(response.error.toString()),
            ),
          ),
        );
        break;
    }
  }

  void _selectTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }
  void _addProductToCart({String? productId, int? quantity}) async {
    
    var response = await _addProductToCartUsecase.call(
        productId: productId, quantity: quantity);
    switch (response) {
      case SuccessResponse<UpdateCartModel>():
        streamController.add(ShowDialogTempEvent(message: response.data.message));
        break;
      case ErrorResponse<UpdateCartModel>():
        streamController.add(ShowDialogTempEvent(message: response.error.toString()));
        break;

    }
  }

  OccasionModel? get selectedOccasion {
    final occasions = state.occasionsState?.success ?? [];
    if (occasions.isEmpty || state.selectedTabIndex >= occasions.length) {
      return null;
    }
    return occasions[state.selectedTabIndex];
  }
}
