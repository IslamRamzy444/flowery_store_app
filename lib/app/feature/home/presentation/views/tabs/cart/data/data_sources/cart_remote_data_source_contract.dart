import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/clear_user_cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';

abstract class CartRemoteDataSourceContract {
  Future<BaseResponse<UpdateCartResponse>> addProductToCart({String? productId,int? quantity});
  Future<BaseResponse<UpdateCartResponse>> updatedCartProductQuantity({String? productId,int? quantity});
  Future<BaseResponse<UpdateCartResponse>> removeSpecificItemFromCart({String? productId});
  Future<BaseResponse<UpdateCartResponse>> getUserCart();
  Future<BaseResponse<ClearUserCartDto>> clearUserCart();
}