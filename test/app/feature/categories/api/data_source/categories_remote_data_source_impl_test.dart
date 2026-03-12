import 'dart:io';

import 'package:flower_app/app/config/base_error/custom_exceptions.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/categories/api/categories_api_client/categories_api_clients.dart';
import 'package:flower_app/app/feature/categories/api/data_source/categories_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/categories/data/model/categories_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CategoriesApiClient])
void main() {
  late CategoriesApiClient categoriesApiClient;
  late CategoriesRemoteDataSourceImpl categoriesRemoteDataSourceImpl;
  late CategoriesResponse categoriesResponse;
  setUpAll(() {
    categoriesApiClient = MockCategoriesApiClient();
    categoriesRemoteDataSourceImpl = CategoriesRemoteDataSourceImpl(
      categoriesApiClient,
    );
    categoriesResponse = CategoriesResponse(
      message: 'success',
      categories: [Categories(name: 'flower')],
    );
  });

  test(
    'when calling get all categories and api return success it should return data',
    () async {
      when(
        categoriesApiClient.getAllCategories(),
      ).thenAnswer((_) async => categoriesResponse);
      var result =
          await categoriesRemoteDataSourceImpl.getAllCategories()
              as SuccessResponse<CategoriesResponse>;
      expect(result, isA<SuccessResponse<CategoriesResponse>>());
      expect(result.data, equals(categoriesResponse));
      expect(result.data.categories?[0].name, equals('flower'));
    },
  );
  test(
    'when calling get all categories and api return error it should return correct error',
    () async {
      when(categoriesApiClient.getAllCategories()).thenThrow(IOException);
      var result =
          await categoriesRemoteDataSourceImpl.getAllCategories()
              as ErrorResponse<CategoriesResponse>;
      expect(result, isA<ErrorResponse<CategoriesResponse>>());
      expect(result.error, equals(UnexpectedError()));
    },
  );
}
