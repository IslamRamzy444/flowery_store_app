import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/products_entity.dart';
import 'package:flower_app/app/feature/product_details/domain/repo/product_details_repo_contract.dart';
import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flower_app/app/feature/product_details/domain/use_cases/get_products_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_products_category_use_case_test.mocks.dart';

@GenerateMocks([ProductDetailsRepoContract])
void main() {
  test(
    'when calling get products category use case it must call repo',
    () async {
      ProductDetailsRepoContract productRepoContract =
          MockProductDetailsRepoContract();
      GetProductsCategoryUseCase getProductsCategoryUseCase =
          GetProductsCategoryUseCase(productRepoContract);
      ProductsEntity productsEntity = ProductsEntity(
        product: [ProductDetailsModel(title: "flower")],
      );
      QueryProductRequest queryProductRequest = QueryProductRequest(
        category: '1',
      );
      provideDummy<BaseResponse<ProductsEntity>>(
        SuccessResponse(data: productsEntity),
      );
      when(
        productRepoContract.getQueryProducts(queryProductRequest),
      ).thenAnswer((_) async {
        return SuccessResponse<ProductsEntity>(data: productsEntity);
      });
      var response = await getProductsCategoryUseCase.invoke(
        queryProductRequest,
      );
      expect(response, isA<SuccessResponse<ProductsEntity>>());
      verify(productRepoContract.getQueryProducts(queryProductRequest));
    },
  );
}
