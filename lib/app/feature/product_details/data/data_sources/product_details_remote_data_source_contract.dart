import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';

abstract class ProductDetailsRemoteDataSourceContract {
  Future<BaseResponse<ProductDetailsDto>> getProductDetails(String productId);
  Future<BaseResponse<UpdateCartResponse>> addProductToCart({String? productId,int? quantity});
}