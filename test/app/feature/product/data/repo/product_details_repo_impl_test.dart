import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/product_details/data/data_sources/product_details_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';
import 'package:flower_app/app/feature/product_details/data/models/products/products_response.dart';
import 'package:flower_app/app/feature/product_details/data/repo/product_details_repo_impl.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/products_entity.dart';
import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_details_repo_impl_test.mocks.dart';

@GenerateMocks([ProductDetailsRemoteDataSourceContract])
void main() {
  late ProductDetailsRemoteDataSourceContract productRemoteDataSource;
  late ProductDetailsRepoImpl productRepo;
  late ProductDetailsDto productResponse;
  late ProductsResponse productsResponse;
  late QueryProductRequest queryProductRequest;
  setUpAll(() {
    productRemoteDataSource = MockProductDetailsRemoteDataSourceContract();
    productRepo = ProductDetailsRepoImpl(productRemoteDataSource);
    productResponse = ProductDetailsDto(
      product: Product(id: "1", title: "flower"),
    );
    productsResponse = ProductsResponse(
      products: [Product(id: "1", title: "flower")],
    );
    queryProductRequest = QueryProductRequest(category: '1');
  },);


  group("Test Get Product Details function test cases", () {
    test("Test Success case with Product Details", ()async{
      provideDummy<BaseResponse<ProductDetailsDto>>(
          SuccessResponse(data: productResponse));
      when(productRemoteDataSource.getProductDetails("1")).thenAnswer((
          _) async {
        return SuccessResponse<ProductDetailsDto>(data: productResponse);
      },);
      var response = await productRepo.getProductDetails("1");
      expect(response, isA<SuccessResponse<ProductDetailsModel>>());
      expect((response as SuccessResponse<ProductDetailsModel>).data.id,
          isNotEmpty);
    });
  },);
  test(
    'when calling query product_details it must get data from data source', () async {
    provideDummy<BaseResponse<ProductsResponse>>(
        SuccessResponse(data: productsResponse));
    when(productRemoteDataSource.getQueryProducts(queryProductRequest))
        .thenAnswer((_) async {
      return SuccessResponse<ProductsResponse>(data: productsResponse);
    },);
    var response = await productRepo.getQueryProducts(queryProductRequest);
    expect(response, isA<SuccessResponse<ProductsEntity>>());
    expect((response as SuccessResponse<ProductsEntity>).data.product?[0].id,
        isNotEmpty);
  },);
}