import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/search/data/api_client/search_api_client.dart';
import 'package:flower_app/app/feature/search/data/data_sources/search_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/search/data/models/search_products_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_remote_data_source_test.mocks.dart';

@GenerateMocks([SearchApiClient])
void main() {
  late SearchRemoteDataSourceImpl dataSource;
  late MockSearchApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockSearchApiClient();
    dataSource = SearchRemoteDataSourceImpl(mockApiClient);
  });

  group('SearchRemoteDataSource - searchProducts', () {
    const testKeyword = 'rose';
    final testResponse = {
      'message': 'success',
      'metadata': {
        'currentPage': 1,
        'totalPages': 1,
        'limit': 40,
        'totalItems': 5,
      },
      'products': [
        {
          '_id': '1',
          'title': 'Red Rose',
          'slug': 'red-rose',
          'description': 'Beautiful red rose',
          'imgCover': 'https://example.com/rose.jpg',
          'images': [],
          'price': 100.0,
          'priceAfterDiscount': 80.0,
          'quantity': 10,
          'category': 'flowers',
          'occasion': 'birthday',
          'sold': 5,
          'rateAvg': 4.5,
          'rateCount': 10,
        },
      ],
    };

    test('should return SuccessResponse when API call is successful', () async {
      // Arrange
      when(
        mockApiClient.searchProducts(testKeyword),
      ).thenAnswer((_) async => testResponse);

      // Act
      final result = await dataSource.searchProducts(testKeyword);

      // Assert
      expect(result, isA<SuccessResponse<SearchProductsResponse>>());
      verify(mockApiClient.searchProducts(testKeyword)).called(1);

      final successResponse = result as SuccessResponse<SearchProductsResponse>;
      expect(successResponse.data!.products!.length, 1);
      expect(successResponse.data!.products!.first.title, 'Red Rose');
    });

    test(
      'should return ErrorResponse when API call throws exception',
      () async {
        // Arrange
        when(
          mockApiClient.searchProducts(testKeyword),
        ).thenThrow(Exception('Network error'));

        // Act
        final result = await dataSource.searchProducts(testKeyword);

        // Assert
        expect(result, isA<ErrorResponse<SearchProductsResponse>>());
        verify(mockApiClient.searchProducts(testKeyword)).called(1);
      },
    );

    test('should return SuccessResponse with empty products list', () async {
      // Arrange
      final emptyResponse = {
        'message': 'success',
        'metadata': {
          'currentPage': 1,
          'totalPages': 0,
          'limit': 40,
          'totalItems': 0,
        },
        'products': [],
      };

      when(
        mockApiClient.searchProducts(testKeyword),
      ).thenAnswer((_) async => emptyResponse);

      // Act
      final result = await dataSource.searchProducts(testKeyword);

      // Assert
      expect(result, isA<SuccessResponse<SearchProductsResponse>>());
      final successResponse = result as SuccessResponse<SearchProductsResponse>;
      expect(successResponse.data!.products, isEmpty);
    });
  });
}
