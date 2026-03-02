import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/categories/data/data_source/categories_remote_data_source.dart';
import 'package:flower_app/app/feature/categories/data/model/categories_response.dart';
import 'package:flower_app/app/feature/categories/data/repository/categories_repository_impl.dart';
import 'package:flower_app/app/feature/categories/domain/model/categories_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repository_impl_test.mocks.dart';

@GenerateMocks([CategoriesRemoteDataSourceContract])
void main() {
  test('when calling get all categories it call data source', () async {
    CategoriesRemoteDataSourceContract categoriesRemoteDataSourceContract =
        MockCategoriesRemoteDataSourceContract();
    CategoriesRepositoryImpl categoriesRepoImpl = CategoriesRepositoryImpl(
      categoriesRemoteDataSourceContract,
    );
    CategoriesResponse categoriesResponse = CategoriesResponse(
      message: 'success',
      categories: [Categories(name: 'flower')],
    );
    provideDummy<BaseResponse<CategoriesResponse>>(
      SuccessResponse(data: categoriesResponse),
    );
    when(
      categoriesRemoteDataSourceContract.getAllCategories(),
    ).thenAnswer((_) async => SuccessResponse(data: categoriesResponse));
    var result = await categoriesRepoImpl.getAllCategories();
    expect(result, isA<SuccessResponse<CategoriesEntity>>());
    verify(categoriesRemoteDataSourceContract.getAllCategories());
  });
}
