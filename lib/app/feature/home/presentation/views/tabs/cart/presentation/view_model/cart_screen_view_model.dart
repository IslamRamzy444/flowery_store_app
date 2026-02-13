import 'dart:async';

import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/clear_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/use_cases/cleare_cart_use_case.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/use_cases/get_logged_user_cart_use_case.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/use_cases/remove_specific_item_from_cart_use_case.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/use_cases/update_cart_product_quantity_use_case.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_events.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_states.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartScreenViewModel extends Cubit<CartScreenStates>{
  CartScreenViewModel(this._getLoggedUserCartUseCase,this._updateCartProductQuantityUseCase,this._cleareCartUseCase,this._removeSpecificItemFromCartUseCase):super(CartScreenStates());
  final GetLoggedUserCartUseCase _getLoggedUserCartUseCase;
  final UpdateCartProductQuantityUseCase _updateCartProductQuantityUseCase;
  final RemoveSpecificItemFromCartUseCase _removeSpecificItemFromCartUseCase;
  final CleareCartUseCase _cleareCartUseCase;
  final StreamController<CartScreenUiEvents> _cartScreenUiEvents = StreamController.broadcast();

  Stream<CartScreenUiEvents> cartScreenUiEvents(){
    return _cartScreenUiEvents.stream;
  }
  

  void doIntent(CartScreenEvents event){
    switch(event){
      
      case GetLoggedUserCartEvent():
        _getLoggedUserCart();

      case RemoveItemFromCartEvent():
        _removeSpecificItemFromCart(productId: event.productId);

      case ClearCartEvent():
        _cleareCart();

      case IncreaseItemQuantityEvent():
      int newQuantity = event.quantity+1;
        _updateCartProductQuantity(productId: event.productId,quantity: newQuantity);

      case DecreaseItemQuantityEvent():
      int newQuantity = event.quantity-1;
        _updateCartProductQuantity(productId: event.productId,quantity: newQuantity);
    }

  }



  void _getLoggedUserCart()async{

   emit(state.copyWith(
   
   cartItemsNew: BaseState(isLoading: true),
   
   ));

   var response =await _getLoggedUserCartUseCase.cartRepoContract.getUserCart();
   
   switch(response){

     case SuccessResponse<UpdateCartModel>():
      emit(state.copyWith(
       numOfCartItemsNew: BaseState(isLoading: false,success: response.data.numOfCartItems),
       cartItemsNew: BaseState(isLoading: false,success: response.data.cart?.cartItems),
       totalPriceNew: BaseState(isLoading: false ,success: response.data.cart?.totalPrice)
      ));
     case ErrorResponse<UpdateCartModel>():
      emit(state.copyWith(
       numOfCartItemsNew: BaseState(isLoading: false,error: response.error),
       cartItemsNew: BaseState(isLoading: false,error: response.error),
       totalPriceNew: BaseState(isLoading: false ,error: response.error)
      ));
   }
  }

  void _updateCartProductQuantity({String? productId,int? quantity})async{
    
   
   var response = await _updateCartProductQuantityUseCase.cartRepoContract.updatedCartProductQuantity(productId: productId,quantity: quantity);
   
   switch(response){

     case SuccessResponse<UpdateCartModel>():
      emit(state.copyWith(
        numOfCartItemsNew: BaseState(isLoading: false,success: response.data.numOfCartItems),
        totalPriceNew: BaseState(isLoading: false,success: response.data.cart?.totalPrice),
        cartItemsNew: BaseState(isLoading: false,success: response.data.cart?.cartItems),

      ));
     case ErrorResponse<UpdateCartModel>():
      _cartScreenUiEvents.add(ShowErrorDialog(response.error.toString()));
      
   }
  }

  void _removeSpecificItemFromCart({String? productId})async{
    //emit(state.copyWith(
    //   numOfCartItemsNew: BaseState(isLoading: true),
    //   cartItemsNew: BaseState(isLoading: true),
    //   totalPriceNew: BaseState(isLoading: true )
    //   ));
   var response =await _removeSpecificItemFromCartUseCase.cartRepoContract.removeSpecificItemFromCart(productId: productId);
   switch(response){
    
     case SuccessResponse<UpdateCartModel>():
       emit(state.copyWith(
       numOfCartItemsNew: BaseState(isLoading: false,success: response.data.numOfCartItems),
       cartItemsNew: BaseState(isLoading: false,success: response.data.cart?.cartItems),
       totalPriceNew: BaseState(isLoading: false ,success: response.data.cart?.totalPrice)
       ));
     case ErrorResponse<UpdateCartModel>():
       _cartScreenUiEvents.add(ShowErrorDialog(response.error.toString()));
   }
  }

  void _cleareCart()async{
    emit(state.copyWith(
        
        cartItemsNew: BaseState(isLoading: true),
      ));
    var response =await _cleareCartUseCase.cartRepoContract.clearUserCart();
    switch(response){
      case SuccessResponse<ClearCartModel>():
      emit(state.copyWith(
       numOfCartItemsNew: BaseState(isLoading: false,success: 0),
       cartItemsNew: BaseState(isLoading: false,success: null),
       totalPriceNew: BaseState(isLoading: false ,success: 0)
      ));
      case ErrorResponse<ClearCartModel>():
        _cartScreenUiEvents.add(ShowErrorDialog(response.error.toString()));
   }
  }

}