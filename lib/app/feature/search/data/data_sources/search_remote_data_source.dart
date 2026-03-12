import 'package:flower_app/app/config/base_response/base_response.dart';
import '../models/search_products_response.dart';

abstract class SearchRemoteDataSource {
  Future<BaseResponse<SearchProductsResponse>> searchProducts(String keyword);
}
