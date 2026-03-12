import 'package:injectable/injectable.dart';
import '../../../../config/api_utils/api_utils.dart';
import '../../../../config/base_response/base_response.dart';
import '../../data/data_source/categories_remote_data_source.dart';
import '../../data/model/categories_response.dart';
import '../categories_api_client/categories_api_clients.dart';

@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    extends CategoriesRemoteDataSourceContract {
  final CategoriesApiClient _categoriesApiClient;

  CategoriesRemoteDataSourceImpl(this._categoriesApiClient);

  @override
  Future<BaseResponse<CategoriesResponse>> getAllCategories() {
    return executeApi(() => _categoriesApiClient.getAllCategories());
  }
}
