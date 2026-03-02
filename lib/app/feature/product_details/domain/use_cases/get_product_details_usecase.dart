import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:injectable/injectable.dart';

import '../repo/product_details_repo_contract.dart';

@injectable
class GetProductDetailsUseCase {
  ProductDetailsRepoContract productDetailsRepoContract;

  GetProductDetailsUseCase(this.productDetailsRepoContract);

  Future<BaseResponse<ProductDetailsModel>> call(String productId) {
    var response = productDetailsRepoContract.getProductDetails(productId);
    return response;
  }
}