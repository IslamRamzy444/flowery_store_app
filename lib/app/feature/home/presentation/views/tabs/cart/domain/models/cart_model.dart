import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_item_model.dart';

class CartModel {
  List<CartItemModel>? cartItems;
  List<dynamic>? appliedCoupons;
  double? totalPrice;
  String? user;
  String? id;
  CartModel({this.cartItems,this.appliedCoupons,this.totalPrice,this.id,this.user});
}