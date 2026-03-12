import 'dart:async';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/search_products_use_case.dart';
import 'search_events.dart';
import 'search_states.dart';

@injectable
class SearchViewModel extends Cubit<SearchStates> {
  final SearchProductsUseCase _searchProductsUseCase;
  Timer? _debounceTimer;

  SearchViewModel(this._searchProductsUseCase) : super(const SearchStates());

  void doIntent(SearchEvents event) {
    switch (event) {
      case SearchProductsEvent():
        _handleSearch(event.keyword);
        break;
      case ClearSearchEvent():
        _clearSearch();
        break;
    }
  }

  void _handleSearch(String keyword) {
    _debounceTimer?.cancel();

    emit(state.copyWith(currentKeyword: keyword));

    if (keyword.trim().isEmpty) {
      emit(state.copyWith(searchState: null, currentKeyword: ''));
      return;
    }

    if (keyword.trim().length < 2) {
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchProducts(keyword);
    });
  }

  Future<void> _searchProducts(String keyword) async {
    emit(
      state.copyWith(
        searchState: BaseState(isLoading: true),
        currentKeyword: keyword,
      ),
    );

    final response = await _searchProductsUseCase(keyword);

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            searchState: BaseState(success: response.data, isLoading: false),
            currentKeyword: keyword,
          ),
        );
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            searchState: BaseState(error: response.error, isLoading: false),
            currentKeyword: keyword,
          ),
        );
        break;
    }
  }

  void _clearSearch() {
    _debounceTimer?.cancel();
    emit(const SearchStates());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
