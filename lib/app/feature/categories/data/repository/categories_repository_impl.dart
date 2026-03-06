import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../domain/model/categories_entity.dart';
import '../../domain/repository/categories_repo_contract.dart';
import '../data_source/categories_remote_data_source.dart';
import '../model/categories_response.dart';

@Injectable(as: CategoriesRepoContract)
class CategoriesRepositoryImpl extends CategoriesRepoContract {
  final CategoriesRemoteDataSourceContract _categoriesRemoteDataSource;

  CategoriesRepositoryImpl(this._categoriesRemoteDataSource);

  @override
  Future<BaseResponse<CategoriesEntity>> getAllCategories() async {
    final response = await _categoriesRemoteDataSource.getAllCategories();
    switch (response) {
      case SuccessResponse<CategoriesResponse>():
        return SuccessResponse(data: response.data.toAllCategoriesEntity());
      case ErrorResponse<CategoriesResponse>():
        return ErrorResponse<CategoriesEntity>(error: response.error);
    }
  }
}
