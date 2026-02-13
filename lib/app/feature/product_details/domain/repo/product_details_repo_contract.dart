import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';

abstract class ProductDetailsRepoContract {
  Future<BaseResponse<ProductDetailsModel>> getProductDetails(String productId);
  Future<BaseResponse<UpdateCartModel>> addProductToCart({String? productId,int? quantity});
}