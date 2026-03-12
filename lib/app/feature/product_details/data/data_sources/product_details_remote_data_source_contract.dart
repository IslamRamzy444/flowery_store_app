import 'package:flower_app/app/config/base_response/base_response.dart';

import '../../../home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import '../../domain/request/query_product_request.dart';
import '../models/product_details_dto.dart';
import '../models/products/products_response.dart';

abstract class ProductDetailsRemoteDataSourceContract {
  Future<BaseResponse<ProductDetailsDto>> getProductDetails(String productId);

  Future<BaseResponse<UpdateCartResponse>> addProductToCart(
      {String? productId, int? quantity});
  Future<BaseResponse<ProductsResponse>> getQueryProducts(
      QueryProductRequest queryProductRequest);
}


