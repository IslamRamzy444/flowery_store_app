import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_item_model.dart';

class CartScreenStates {
  BaseState<int>? numOfCartItems;
  BaseState<List<CartItemModel>>? cartItems;
  BaseState<double>? totalPrice;
  CartScreenStates({this.numOfCartItems,this.cartItems,this.totalPrice});

  CartScreenStates copyWith({
    BaseState<int>? numOfCartItemsNew,
    BaseState<List<CartItemModel>>? cartItemsNew,
    BaseState<double>? totalPriceNew}){

      return CartScreenStates(
        numOfCartItems: numOfCartItemsNew??numOfCartItems,
        cartItems: cartItemsNew??cartItems,
        totalPrice: totalPriceNew??totalPrice
      );

  }
}