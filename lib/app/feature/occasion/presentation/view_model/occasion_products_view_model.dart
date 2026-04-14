import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/config/base_state/custom_cubit.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/occasion/data/models/product_model.dart';
import 'package:flower_app/app/feature/occasion/domain/use_cases/get_products_by_occasion_use_case.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_products_events.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_products_states.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_temp_events.dart';
import 'package:flower_app/app/feature/product_details/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionProductsViewModel extends CustomCubit<OccasionTempEvents,OccasionProductsStates> {
  final GetProductsByOccasionUseCase _getProductsByOccasionUseCase;
  final AddProductToCartUsecase _addProductToCartUsecase;
  OccasionProductsViewModel(this._getProductsByOccasionUseCase,this._addProductToCartUsecase)
    : super(OccasionProductsStates(productsState: BaseState()));

  void doIntent(OccasionProductsEvents event) {
    switch (event) {
      case GetProductsForOccasionEvent():
        _getProducts(event.occasionId);
        break;
      case AddProductToCartEvent():
        _addProductToCart(productId: event.productId, quantity: event.quantity);
        break;
    }
  }

  Future<void> _getProducts(String occasionId) async {
    if (occasionId.isEmpty) return;

    emit(
      state.copyWith(
        productsState: BaseState<List<ProductModel>>(isLoading: true),
      ),
    );

    final response = await _getProductsByOccasionUseCase(occasionId);

    switch (response) {
      case SuccessResponse<List<ProductModel>>():
        emit(
          state.copyWith(
            productsState: BaseState<List<ProductModel>>(
              isLoading: false,
              success: response.data,
            ),
          ),
        );
      case ErrorResponse<List<ProductModel>>():
        emit(
          state.copyWith(
            productsState: BaseState<List<ProductModel>>(
              isLoading: false,
              error: response.error,
            ),
          ),
        );
    }
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
}
