import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';

class CartItemModel {
  ProductDetailsModel? product;
  int? price;
  int? quantity;
  String? id;
  CartItemModel({this.product,this.id,this.price,this.quantity});
}