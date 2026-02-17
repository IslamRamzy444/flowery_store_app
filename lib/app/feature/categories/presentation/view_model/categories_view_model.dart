import 'package:flower_app/app/config/base_state/custom_cubit.dart';
import 'package:flower_app/app/feature/categories/domain/use_case/get_all_categories_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../product_details/domain/models/products_entity.dart';
import '../../../product_details/domain/request/query_product_request.dart';
import '../../../product_details/domain/use_cases/get_products_category_use_case.dart';
import 'categories_event.dart';
import 'categories_intent.dart';
import 'categories_state.dart';

@injectable
class CategoriesViewModel
    extends CustomCubit<CategoriesEvent, CategoriesState> {
  final GetAllCategoriesUseCase _categoriesUseCase;
  final GetProductsCategoryUseCase _productsCategoryUseCase;
  CategoriesViewModel(this._categoriesUseCase, this._productsCategoryUseCase)
    : super(
        CategoriesState(
          categoriesState: CategoryBaseState(),
          productsCategoryState: BaseState(),
        ),
      );
  late var baseState = state;

  Future<void> _getAllCategories() async {
    baseState = state.copyWith(
      categoriesState: CategoryBaseState(isLoading: true),
    );
    emit(baseState);
    final response = await _categoriesUseCase.invoke();
    switch (response) {
      case SuccessResponse():
        baseState = state.copyWith(
          categoriesState: CategoryBaseState(
            isLoading: false,
            success: response.data,
          ),
        );
        emit(baseState);
        if (state.categoriesState.success?.categoriesEntity?.isNotEmpty ??
            false) {
          _getProductsCategory(
            '${state.categoriesState.success?.categoriesEntity?[0].id}',
        );
        }
        break;
      case ErrorResponse():
        baseState = state.copyWith(
          categoriesState: CategoryBaseState(
            isLoading: false,
            error: response.error,
          ),
        );
        emit(baseState);
        break;
    }
  }

  void _getCategory(int index) {
    baseState = state.copyWith(
      categoriesState: CategoryBaseState(index: index),
    );
    emit(baseState);
    _getProductsCategory(
      '${state.categoriesState.success?.categoriesEntity?[index].id}',
    );
  }

  Future<void> _getProductsCategory(String categoryId) async {
    emit(
      state.copyWith(
        productsCategoryState: BaseState(isLoading: true),
        clearSuccess: true,
        clearError: true,
      ),
    );
    final response = await _productsCategoryUseCase.invoke(
      QueryProductRequest(category: categoryId),
    );
    switch (response) {
      case SuccessResponse<ProductsEntity>():
        emit(
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              success: response.data,
            ),
            clearError: true,
          ),
        );

        break;
      case ErrorResponse<ProductsEntity>():
        emit(
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              success: null,
              error: response.error,
            ),
            clearSuccess: true,
          ),
        );

        break;
    }
  }

  void doIntent(CategoriesIntent intent) {
    switch (intent) {
      case CategoriesAction():
        _getAllCategories();
        break;
      case GetCategoryIntent():
        _getCategory((intent.index));
        break;
      case GetProductsCategoryIntent():
        _getProductsCategory(intent.categoryId);
        break;
    }
  }
}
