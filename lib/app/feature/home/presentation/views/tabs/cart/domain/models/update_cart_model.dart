import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_model.dart';

class UpdateCartModel {
  String? message;
  String? error;
  int? numOfCartItems;
  CartModel? cart;
  UpdateCartModel({this.cart,this.error,this.message,this.numOfCartItems});
}