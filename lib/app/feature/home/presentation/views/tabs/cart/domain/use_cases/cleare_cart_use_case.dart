import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/clear_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/repo/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CleareCartUseCase {
  CartRepoContract cartRepoContract;
  CleareCartUseCase(this.cartRepoContract);
  Future<BaseResponse<ClearCartModel>> call(){
    return cartRepoContract.clearUserCart();
  }
}