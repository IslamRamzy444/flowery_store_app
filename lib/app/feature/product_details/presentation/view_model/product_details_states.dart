import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';

class ProductDetailsStates {
  BaseState<ProductDetailsModel>? productDetailsState;
  BaseState<UpdateCartModel>? addProductToCartState;
  ProductDetailsStates({this.productDetailsState,this.addProductToCartState});

  ProductDetailsStates copyWith({BaseState<ProductDetailsModel>? productDetailsStateParam, BaseState<UpdateCartModel>? addProductToCartStateParam}){
    
    return ProductDetailsStates(productDetailsState: productDetailsStateParam??this.productDetailsState, 
    addProductToCartState: addProductToCartStateParam??this.addProductToCartState);
    
  }
}