import 'package:flower_app/app/config/api_utils/api_utils.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/api/api_client/api_client.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/clear_user_cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract{
  CartApiClient apiClient;
  CartRemoteDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<UpdateCartResponse>> addProductToCart({String? productId, int? quantity})async {
    return await executeApi(() =>apiClient.addProductToCart({
      "product_details": productId,
     "quantity":quantity
    }));
  }
  
  @override
  Future<BaseResponse<UpdateCartResponse>> updatedCartProductQuantity({String? productId, int? quantity})async {
     return await executeApi(() => apiClient.updatedCartProductQuantity(body:{"quantity":quantity},productId: productId));
  }
  
  @override
  Future<BaseResponse<UpdateCartResponse>> removeSpecificItemFromCart({String? productId})async {
    return await executeApi(()=> apiClient.removeSpecificItemFromCart(productId: productId));
  }
  
  @override
  Future<BaseResponse<UpdateCartResponse>> getUserCart()async {
    return await executeApi(()=> apiClient.getUserCart());
  }

  @override
  Future<BaseResponse<ClearUserCartDto>> clearUserCart()async {
    return await executeApi(()=> apiClient.clearUserCart());
  }

}