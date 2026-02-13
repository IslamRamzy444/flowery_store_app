import 'package:flower_app/app/config/api_utils/api_utils.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:flower_app/app/feature/product_details/api/api_client/api_client.dart';
import 'package:flower_app/app/feature/product_details/data/data_sources/product_details_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRemoteDataSourceContract)
class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSourceContract{
  ProductDetailsApiClient apiClient;
  ProductDetailsRemoteDataSourceImpl(this.apiClient);
  @override
  Future<BaseResponse<ProductDetailsDto>> getProductDetails(String productId)async {
    try{
      var response = await apiClient.getProductDetails(productId);
      return SuccessResponse<ProductDetailsDto>(data: response);
    }catch(e){
      return ErrorResponse(error: e as Exception);
    }
  }

  @override
  Future<BaseResponse<UpdateCartResponse>> addProductToCart({String? productId, int? quantity})async {
     return await executeApi(() =>apiClient.addProductToCart({
     "product": productId,
     "quantity":quantity
    }));
  }

  

}