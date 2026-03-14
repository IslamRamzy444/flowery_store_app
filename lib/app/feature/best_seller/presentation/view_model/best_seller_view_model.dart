import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/config/base_state/custom_cubit.dart';
import 'package:flower_app/app/feature/best_seller/domain/models/best_seller_model.dart';
import 'package:flower_app/app/feature/best_seller/domain/use_cases/best_seller_use_case.dart';
import 'package:flower_app/app/feature/best_seller/presentation/view_model/best_seller_events.dart';
import 'package:flower_app/app/feature/best_seller/presentation/view_model/best_seller_states.dart';
import 'package:flower_app/app/feature/best_seller/presentation/view_model/best_seller_temp_events.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/product_details/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:injectable/injectable.dart';
@injectable
class BestSellerViewModel extends CustomCubit<BestSellerTempEvents,BestSellerStates>{
  final BestSellerUseCase _bestSellerUseCase;
  final AddProductToCartUsecase _addProductToCartUsecase;
  BestSellerViewModel(this._bestSellerUseCase,this._addProductToCartUsecase):super(BestSellerStates());
  void doIntent(BestSellerEvents event){
    switch(event){
      
      case GetBestSellersEvent():
        _getBestSellers();
      case AddProductToCartEvent():
        _addProductToCart(productId: event.productId, quantity: event.quantity);
    }
  }
  Future<void> _getBestSellers() async{
    emit(state.copyWith(
      getBestSellersState: BaseState<List<BestSellerModel>>(
        isLoading: true
      )
    ));
    final response=await _bestSellerUseCase.call();
    switch (response){
      
      case SuccessResponse<List<BestSellerModel>>():
        emit(state.copyWith(
          getBestSellersState: BaseState<List<BestSellerModel>>(
            isLoading: false,
            success: response.data
          )
        ));
      case ErrorResponse<List<BestSellerModel>>():
        emit(state.copyWith(
          getBestSellersState: BaseState<List<BestSellerModel>>(
            isLoading: false,
            error: response.error
          )
        ));
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