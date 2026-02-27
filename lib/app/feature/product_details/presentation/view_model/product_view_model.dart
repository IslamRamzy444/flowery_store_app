import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_details_states.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_event.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_intent.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/custom_cubit.dart';
import '../../../home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import '../../domain/use_cases/add_product_to_cart_use_case.dart';
import '../../domain/use_cases/get_product_details_usecase.dart';
@injectable
class ProductDetailsViewModel
    extends CustomCubit<ProductEvent, ProductDetailsStates> {
  ProductDetailsViewModel(this._getProductDetailsUseCase,
      this._addProductToCartUsecase)
      :super(ProductDetailsStates());
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final AddProductToCartUsecase _addProductToCartUsecase;


  void doIntent(ProductIntent intent) {
    switch (intent) {
      case GetProductDetailsAction():
        _getProductDetails(intent.productId);
        break;
      case NavigateToProductDetailsAction():
        streamController.add(
            NavigateToProductDetailsEvent(productId: intent.productId ?? ''));
        break;
      case AddProductToCartEvent():
        _addProductToCart(intent.productId, intent.quantity);
        break;
    }
  }

  void _getProductDetails(String productId)async{
    emit(state.copyWith(productDetailsStateParam: BaseState(isLoading: true)));
    var response = await _getProductDetailsUseCase.call(productId);
    switch(response){
      case SuccessResponse<ProductDetailsModel>():
        emit(state.copyWith(productDetailsStateParam: BaseState(isLoading: false,success: response.data)));
        break;
      case ErrorResponse<ProductDetailsModel>():
        emit(state.copyWith(productDetailsStateParam: BaseState(isLoading: false,error: response.error)));
        break;
    }
  }

  void _addProductToCart(String productId, int quantity) async {
    emit(
        state.copyWith(addProductToCartStateParam: BaseState(isLoading: true)));
    var response = await _addProductToCartUsecase.call(
        productId: productId, quantity: quantity);
    switch (response) {
      case SuccessResponse<UpdateCartModel>():
        emit(state.copyWith(addProductToCartStateParam: BaseState(
            isLoading: false, success: response.data)));
        break;
      case ErrorResponse<UpdateCartModel>():
        emit(state.copyWith(addProductToCartStateParam: BaseState(
            isLoading: false, error: response.error)));
        break;

    }
  }
}