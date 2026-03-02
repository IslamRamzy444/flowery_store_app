import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../models/search_product_model.dart';
import '../repositories/search_repository.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<BaseResponse<List<SearchProductModel>>> call(String keyword) async {
    return await _repository.searchProducts(keyword);
  }
}
