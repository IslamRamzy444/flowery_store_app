import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flower_app/app/feature/product_details/domain/repo/product_details_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUsecase {
  ProductDetailsRepoContract productDetailsRepoContract;

  AddProductToCartUsecase(this.productDetailsRepoContract);

  Future<BaseResponse<UpdateCartModel>> call({
    String? productId,
    int? quantity,
  }) {
    var response = productDetailsRepoContract.addProductToCart(
      productId: productId,
      quantity: quantity,
    );
    return response;
  }
}
