import 'package:flower_app/app/config/base_response/base_response.dart';
import '../models/search_product_model.dart';

abstract class SearchRepository {
  Future<BaseResponse<List<SearchProductModel>>> searchProducts(String keyword);
}
