import 'package:equatable/equatable.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/product_details/domain/models/products_entity.dart';

import '../../domain/model/categories_entity.dart';

class CategoriesState extends Equatable {
  final CategoryBaseState categoriesState;
  final BaseState<ProductsEntity> productsCategoryState;

  const CategoriesState({
    required this.categoriesState,
    required this.productsCategoryState,
  });

  CategoriesState copyWith({
    CategoryBaseState? categoriesState,
    BaseState<ProductsEntity>? productsCategoryState,
    bool clearSuccess = false,
    bool clearError = false,
  }) {
    return CategoriesState(
      categoriesState: CategoryBaseState(
        isLoading: categoriesState?.isLoading ?? this.categoriesState.isLoading,
        success: categoriesState?.success ?? this.categoriesState.success,
        error: categoriesState?.error ?? this.categoriesState.error,
        index: categoriesState?.index ?? this.categoriesState.index,
      ),
      productsCategoryState: BaseState(
        isLoading:
            productsCategoryState?.isLoading ??
            this.productsCategoryState.isLoading,
        success: clearSuccess
            ? null
            : (productsCategoryState?.success ??
                  this.productsCategoryState.success),
        error: clearError
            ? null
            : (productsCategoryState?.error ??
                  this.productsCategoryState.error),
      ),
    );
  }

  @override
  List<Object?> get props => [categoriesState, productsCategoryState];
}

class CategoryBaseState extends BaseState<CategoriesEntity> {
  const CategoryBaseState({
    this.index = 0,
    super.isLoading,
    super.success,
    super.error,
  });

  final int index;
}
