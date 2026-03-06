import 'dart:io';

import 'package:flower_app/app/config/base_error/custom_exceptions.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/product_details/api/api_client/api_client.dart';
import 'package:flower_app/app/feature/product_details/api/data_source_impls/product_details_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/product_details/data/models/product_details_dto.dart';
import 'package:flower_app/app/feature/product_details/data/models/products/products_response.dart';
import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_details_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductDetailsApiClient])
void main() {
  late ProductDetailsRemoteDataSourceImpl productDataSource;
  late ProductDetailsApiClient productApiClient;
  late QueryProductRequest queryProductRequest;
  late ProductDetailsDto productResponse;
  late ProductsResponse productsResponse;
  setUpAll(() {
    productApiClient = MockProductDetailsApiClient();
    productDataSource = ProductDetailsRemoteDataSourceImpl(productApiClient);
    queryProductRequest = QueryProductRequest(
        category: '1',
        occasion: '1'
    );
    productResponse = ProductDetailsDto(
        message: 'success',

        product: Product(
          title: 'flower',
        )
    );
    productsResponse = ProductsResponse(
      message: 'success',
      products: [Product(title: 'flower')],
    );
  },);

  group("Product Details test cases", () {
    test("Test Success case with Product Details", ()async{
      when(productApiClient.getProductDetails("1")).thenAnswer((_) async {
        return Future.value(productResponse);
      },);
      var response = await productDataSource.getProductDetails(
          "1") as SuccessResponse<ProductDetailsDto>;
      expect(response, isA<SuccessResponse<ProductDetailsDto>>());
      expect(response.data, equals(productResponse));
    });

    test("Test Error case with Product Details", ()async{
      when(productApiClient.getProductDetails("1")).thenThrow(IOException);
      var result = await productDataSource.getProductDetails(
          "1") as ErrorResponse<ProductDetailsDto>;
      expect(result, isA<ErrorResponse<ProductDetailsDto>>());
      expect((result).error, isA<UnexpectedError>());
    });
  },);
  group("query Product  test cases", () {
    test("Test Success case with query product_details", () async {
      when(productApiClient.getQueryProducts(queryProductRequest)).thenAnswer((
          _) async {
        return Future.value(productsResponse);
      },);
      var response = await productDataSource.getQueryProducts(
          queryProductRequest) as SuccessResponse<ProductsResponse>;
      expect(response, isA<SuccessResponse<ProductsResponse>>());
      expect((response).data, equals(productsResponse));
    });

    test("Test Error case with query product_details", () async {
      when(productApiClient.getQueryProducts(queryProductRequest)).thenThrow(
          IOException);
      var result = await productDataSource.getQueryProducts(
          queryProductRequest) as ErrorResponse<ProductsResponse>;
      expect(result, isA<ErrorResponse<ProductsResponse>>());
      expect((result).error.toString(),
          isNotEmpty);
    });
  },);
}