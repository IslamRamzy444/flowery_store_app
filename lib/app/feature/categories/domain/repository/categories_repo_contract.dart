import '../../../../config/base_response/base_response.dart';
import '../model/categories_entity.dart';

abstract class CategoriesRepoContract {
  Future<BaseResponse<CategoriesEntity>> getAllCategories();
}
