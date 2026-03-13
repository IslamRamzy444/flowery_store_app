
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_product_model.dart';

class CartItemModel {
  CartProductModel? cartProductModel;
  int? price;
  int? quantity;
  String? id;
  CartItemModel({this.cartProductModel,this.id,this.price,this.quantity});
}