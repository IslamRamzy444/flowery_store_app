import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/clear_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';

abstract class CartRepoContract {
  Future<BaseResponse<UpdateCartModel>> addProductToCart({String? productId,int? quantity});
  Future<BaseResponse<UpdateCartModel>> updatedCartProductQuantity({String? productId,int? quantity});
  Future<BaseResponse<UpdateCartModel>> removeSpecificItemFromCart({String? productId});
  Future<BaseResponse<UpdateCartModel>> getUserCart();
  Future<BaseResponse<ClearCartModel>>  clearUserCart();
}