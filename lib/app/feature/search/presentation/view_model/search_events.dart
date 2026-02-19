sealed class SearchEvents {}

class SearchProductsEvent extends SearchEvents {
  final String keyword;
  SearchProductsEvent(this.keyword);
}

class ClearSearchEvent extends SearchEvents {}
