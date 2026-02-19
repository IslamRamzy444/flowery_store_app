import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/search/data/api_client/search_api_client.dart';
import 'package:flower_app/app/feature/search/data/models/search_products_response.dart';
import 'package:injectable/injectable.dart';
import 'search_remote_data_source.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final SearchApiClient _apiClient;

  SearchRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<SearchProductsResponse>> searchProducts(
    String keyword,
  ) async {
    try {
      final response = await _apiClient.searchProducts(keyword);
      final searchResponse = SearchProductsResponse.fromJson(response);
      return SuccessResponse(data: searchResponse);
    } catch (e) {
      return ErrorResponse(error: Exception(e.toString()));
    }
  }
}
