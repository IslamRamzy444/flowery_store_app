import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/clear_user_cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/clear_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepoContract)
class CartRepoImpl implements CartRepoContract{
  CartRemoteDataSourceContract remoteDataSource;
  CartRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<UpdateCartModel>> addProductToCart({String? productId, int? quantity})async {
    var response = await remoteDataSource.addProductToCart(productId: productId,quantity: quantity);
    switch(response){
      case SuccessResponse<UpdateCartResponse>():
        return SuccessResponse<UpdateCartModel>(data: response.data.toModel()); 
      case ErrorResponse<UpdateCartResponse>():
        return ErrorResponse<UpdateCartModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ClearCartModel>> clearUserCart()async {
    var response = await remoteDataSource.clearUserCart();
    switch(response){
      case SuccessResponse<ClearUserCartDto>():
        return SuccessResponse<ClearCartModel>(data: response.data.toModel()); 
      case ErrorResponse<ClearUserCartDto>():
        return ErrorResponse<ClearCartModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<UpdateCartModel>> getUserCart()async {
    var response = await remoteDataSource.getUserCart();
    switch(response){
      case SuccessResponse<UpdateCartResponse>():
        return SuccessResponse<UpdateCartModel>(data: response.data.toModel()); 
      case ErrorResponse<UpdateCartResponse>():
        return ErrorResponse<UpdateCartModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<UpdateCartModel>> removeSpecificItemFromCart({String? productId})async {
    var response = await remoteDataSource.removeSpecificItemFromCart(productId: productId);
    switch(response){
      case SuccessResponse<UpdateCartResponse>():
        return SuccessResponse<UpdateCartModel>(data: response.data.toModel()); 
      case ErrorResponse<UpdateCartResponse>():
        return ErrorResponse<UpdateCartModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<UpdateCartModel>> updatedCartProductQuantity({String? productId, int? quantity})async {
    var response = await remoteDataSource.updatedCartProductQuantity(productId: productId,quantity: quantity);
    switch(response){
      case SuccessResponse<UpdateCartResponse>():
        return SuccessResponse<UpdateCartModel>(data: response.data.toModel()); 
      case ErrorResponse<UpdateCartResponse>():
        return ErrorResponse<UpdateCartModel>(error: response.error);
    }
  }

}