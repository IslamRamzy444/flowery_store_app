import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/products_entity.dart';
import 'package:flower_app/app/feature/product_details/domain/repo/product_details_repo_contract.dart';
import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flower_app/app/feature/product_details/data/data_sources/product_details_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:flower_app/app/feature/product_details/data/models/products/products_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRepoContract)
class ProductDetailsRepoImpl implements ProductDetailsRepoContract {
  final ProductDetailsRemoteDataSourceContract remoteDataSource;

  ProductDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<ProductDetailsModel>> getProductDetails(String productId) async {
    final response = await remoteDataSource.getProductDetails(productId);
    switch (response) {
      case SuccessResponse<ProductDetailsDto>():
        return SuccessResponse<ProductDetailsModel>(data: response.data.toModel());
      case ErrorResponse<ProductDetailsDto>():
        return ErrorResponse<ProductDetailsModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<UpdateCartModel>> addProductToCart({String? productId, int? quantity}) async {
    final response = await remoteDataSource.addProductToCart(productId: productId, quantity: quantity);
    switch (response) {
      case SuccessResponse<UpdateCartResponse>():
        return SuccessResponse<UpdateCartModel>(data: response.data.toModel());
      case ErrorResponse<UpdateCartResponse>():
        return ErrorResponse<UpdateCartModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ProductsEntity>> getQueryProducts(QueryProductRequest queryProductRequest) async {
    final response = await remoteDataSource.getQueryProducts(queryProductRequest);
    switch (response) {
      case SuccessResponse<ProductsResponse>():
        return SuccessResponse<ProductsEntity>(data: response.data.toProductsEntity());
      case ErrorResponse<ProductsResponse>():
        return ErrorResponse<ProductsEntity>(error: response.error);
    }
  }
}
