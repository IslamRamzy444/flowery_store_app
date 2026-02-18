import '../../../product_details/domain/request/query_product_request.dart';

sealed class CategoriesIntent {}

class CategoriesAction extends CategoriesIntent {}

class GetCategoryIntent extends CategoriesIntent {
  final int index;

  GetCategoryIntent({required this.index});
}

class GetProductsCategoryIntent extends CategoriesIntent {
  final String categoryId;
  GetProductsCategoryIntent({required this.categoryId});
}

class GetSortedProducts extends CategoriesIntent {
  final Sort sort;
  final int index;

  GetSortedProducts({required this.sort, required this.index});
}

class ShowSortBottomSheet extends CategoriesIntent {}
