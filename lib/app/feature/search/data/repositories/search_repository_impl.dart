import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/search/domain/models/search_product_model.dart';
import 'package:flower_app/app/feature/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_sources/search_remote_data_source.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<SearchProductModel>>> searchProducts(
    String keyword,
  ) async {
    final response = await _remoteDataSource.searchProducts(keyword);

    switch (response) {
      case SuccessResponse():
        final products = (response.data.products ?? [])
            .map(
              (dto) => SearchProductModel(
                id: dto.id ?? '',
                title: dto.title ?? '',
                slug: dto.slug ?? '',
                description: dto.description ?? '',
                imgCover: dto.imgCover ?? '',
                images: dto.images ?? [],
                price: (dto.price ?? 0).toInt(),
                priceAfterDiscount: (dto.priceAfterDiscount ?? 0).toInt(),
                quantity: (dto.quantity ?? 0).toInt(),
                category: dto.category ?? '',
                occasion: dto.occasion ?? '',
                sold: dto.sold ?? 0,
                rateAvg: (dto.rateAvg ?? 0).toInt(),
                rateCount: dto.rateCount ?? 0,
              ),
            )
            .toList();
        return SuccessResponse(data: products);
      case ErrorResponse():
        return ErrorResponse(error: response.error);
    }
  }
}
