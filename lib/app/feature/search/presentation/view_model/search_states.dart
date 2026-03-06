import 'package:equatable/equatable.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import '../../domain/models/search_product_model.dart';

class SearchStates extends Equatable {
  final BaseState<List<SearchProductModel>>? searchState;
  final String currentKeyword;

  const SearchStates({this.searchState, this.currentKeyword = ''});

  SearchStates copyWith({
    BaseState<List<SearchProductModel>>? searchState,
    String? currentKeyword,
  }) {
    return SearchStates(
      searchState: searchState ?? this.searchState,
      currentKeyword: currentKeyword ?? this.currentKeyword,
    );
  }

  @override
  List<Object?> get props => [searchState, currentKeyword];
}
