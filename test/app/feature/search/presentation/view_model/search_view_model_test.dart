import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/search/domain/models/search_product_model.dart';
import 'package:flower_app/app/feature/search/domain/use_cases/search_products_use_case.dart';
import 'package:flower_app/app/feature/search/presentation/view_model/search_events.dart';
import 'package:flower_app/app/feature/search/presentation/view_model/search_states.dart';
import 'package:flower_app/app/feature/search/presentation/view_model/search_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_view_model_test.mocks.dart';

@GenerateMocks([SearchProductsUseCase])
void main() {
  late SearchViewModel viewModel;
  late MockSearchProductsUseCase mockUseCase;

  setUpAll(() {
    provideDummy<BaseResponse<List<SearchProductModel>>>(
      SuccessResponse(data: const []),
    );
  });

  setUp(() {
    mockUseCase = MockSearchProductsUseCase();
    viewModel = SearchViewModel(mockUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  group('SearchViewModel - SearchProductsEvent', () {
    final testProducts = [
      SearchProductModel(
        id: '1',
        title: 'Red Rose',
        slug: 'red-rose',
        description: 'Beautiful red rose',
        imgCover: 'https://example.com/rose.jpg',
        images: [],
        price: 100,
        priceAfterDiscount: 80,
        quantity: 10,
        category: 'flowers',
        occasion: 'birthday',
        sold: 5,
        rateAvg: 4,
        rateCount: 10,
      ),
    ];

    blocTest<SearchViewModel, SearchStates>(
      'emits [loading, success] when search is successful',
      build: () {
        when(
          mockUseCase.call('rose'),
        ).thenAnswer((_) async => SuccessResponse(data: testProducts));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(SearchProductsEvent('rose')),
      wait: const Duration(milliseconds: 600), // Wait for debounce
      expect: () => [
        const SearchStates(currentKeyword: 'rose'),
        SearchStates(
          searchState: BaseState(isLoading: true),
          currentKeyword: 'rose',
        ),
        SearchStates(
          searchState: BaseState(success: testProducts, isLoading: false),
          currentKeyword: 'rose',
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call('rose')).called(1);
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'emits [loading, error] when search fails',
      build: () {
        when(mockUseCase.call('rose')).thenAnswer(
          (_) async => ErrorResponse(error: Exception('Network error')),
        );
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(SearchProductsEvent('rose')),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const SearchStates(currentKeyword: 'rose'),
        isA<SearchStates>().having(
          (state) => state.searchState?.isLoading,
          'isLoading',
          true,
        ),
        isA<SearchStates>()
            .having((state) => state.searchState?.isLoading, 'isLoading', false)
            .having(
              (state) => state.searchState?.error,
              'error',
              isA<Exception>(),
            ),
      ],
      verify: (_) {
        // Just verify the error state was set
        expect(viewModel.state.searchState?.error, isA<Exception>());
        expect(viewModel.state.searchState?.isLoading, false);
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'does not search when keyword is less than 2 characters',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(SearchProductsEvent('r')),
      wait: const Duration(milliseconds: 600),
      expect: () => [const SearchStates(currentKeyword: 'r')],
      verify: (_) {
        verifyNever(mockUseCase.call(any));
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'clears results when keyword is empty',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(SearchProductsEvent('')),
      expect: () => [const SearchStates(currentKeyword: '')],
      verify: (_) {
        verifyNever(mockUseCase.call(any));
      },
    );
  });

  group('SearchViewModel - ClearSearchEvent', () {
    blocTest<SearchViewModel, SearchStates>(
      'emits initial state when ClearSearchEvent is triggered',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ClearSearchEvent()),
      expect: () => [const SearchStates()],
    );
  });

  group('SearchViewModel - Debouncing', () {
    blocTest<SearchViewModel, SearchStates>(
      'debounces multiple rapid searches',
      build: () {
        when(
          mockUseCase.call('roses'),
        ).thenAnswer((_) async => SuccessResponse(data: []));
        return viewModel;
      },
      act: (bloc) {
        bloc.doIntent(SearchProductsEvent('r'));
        bloc.doIntent(SearchProductsEvent('ro'));
        bloc.doIntent(SearchProductsEvent('ros'));
        bloc.doIntent(SearchProductsEvent('rose'));
        bloc.doIntent(SearchProductsEvent('roses'));
      },
      wait: const Duration(milliseconds: 600),
      verify: (_) {
        // Only the last search should be executed after debounce
        verify(mockUseCase.call('roses')).called(1);
        verifyNever(mockUseCase.call('r'));
        verifyNever(mockUseCase.call('ro'));
        verifyNever(mockUseCase.call('ros'));
        verifyNever(mockUseCase.call('rose'));
      },
    );
  });
}
