import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/categories/data/repository/categories_repository_impl.dart';
import 'package:flower_app/app/feature/categories/domain/model/categories_entity.dart';
import 'package:flower_app/app/feature/categories/domain/use_case/get_all_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_categories_use_case_test.mocks.dart';

@GenerateMocks([CategoriesRepositoryImpl])
void main() {
  test('when calling get all categories it call data source', () async {
    CategoriesRepositoryImpl categoriesRepoImpl =
        MockCategoriesRepositoryImpl();
    GetAllCategoriesUseCase getAllCategoriesUseCase = GetAllCategoriesUseCase(
      categoriesRepoImpl,
    );

    CategoriesEntity categoriesResponse = CategoriesEntity(
      categoriesEntity: [CategoryEntity(title: "flower")],
    );
    provideDummy<BaseResponse<CategoriesEntity>>(
      SuccessResponse(data: categoriesResponse),
    );
    when(
      categoriesRepoImpl.getAllCategories(),
    ).thenAnswer((_) async => SuccessResponse(data: categoriesResponse));
    var result = await getAllCategoriesUseCase.invoke();
    expect(result, isA<SuccessResponse<CategoriesEntity>>());
    verify(categoriesRepoImpl.getAllCategories());
  });
}
