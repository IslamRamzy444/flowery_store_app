import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveSpecificItemFromCartUseCase {
  CartRepoContract cartRepoContract;
  RemoveSpecificItemFromCartUseCase(this.cartRepoContract);
  Future<BaseResponse<UpdateCartModel>> call ({String? productId}){
    return cartRepoContract.removeSpecificItemFromCart(productId: productId);
  }

}