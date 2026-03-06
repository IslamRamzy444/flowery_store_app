import '../../../../config/base_response/base_response.dart';
import '../model/categories_response.dart';

abstract class CategoriesRemoteDataSourceContract {
  Future<BaseResponse<CategoriesResponse>> getAllCategories();
}
