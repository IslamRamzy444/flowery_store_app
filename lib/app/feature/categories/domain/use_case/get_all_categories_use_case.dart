import 'package:flower_app/app/config/base_response/base_response.dart';

import 'package:injectable/injectable.dart';

import '../../../categories/domain/repository/categories_repo_contract.dart';
import '../../../categories/domain/model/categories_entity.dart';

@injectable
class GetAllCategoriesUseCase {
  final CategoriesRepoContract _categoriesRepoContract;

  GetAllCategoriesUseCase(this._categoriesRepoContract);

  Future<BaseResponse<CategoriesEntity>> invoke() {
    return _categoriesRepoContract.getAllCategories();
  }
}
