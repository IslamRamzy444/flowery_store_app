import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/app/config/base_error/custom_exceptions.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/categories/domain/model/categories_entity.dart';
import 'package:flower_app/app/feature/categories/domain/use_case/get_all_categories_use_case.dart';
import 'package:flower_app/app/feature/categories/presentation/view_model/categories_intent.dart';
import 'package:flower_app/app/feature/categories/presentation/view_model/categories_state.dart';
import 'package:flower_app/app/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:flower_app/app/feature/product_details/domain/models/products_entity.dart';
import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flower_app/app/feature/product_details/domain/use_cases/get_products_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_view_model_test.mocks.dart';

@GenerateMocks([GetAllCategoriesUseCase, GetProductsCategoryUseCase])
void main() {
  late GetAllCategoriesUseCase getAllCategoriesUseCase;
  late GetProductsCategoryUseCase getProductsCategoryUseCase;
  late CategoriesViewModel categoriesViewModel;
  late CategoriesEntity categoriesEntity;
  late ProductsEntity productsEntity;
  late QueryProductRequest queryProductRequest;
  late CategoriesEntity categories;

  setUpAll(() {
    getAllCategoriesUseCase = MockGetAllCategoriesUseCase();
    getProductsCategoryUseCase = MockGetProductsCategoryUseCase();
    categoriesEntity = CategoriesEntity(
      categoriesEntity: [CategoryEntity(title: "flower")],
    );
    productsEntity = ProductsEntity(
      product: [ProductDetailsModel(title: "flower")],
    );
    queryProductRequest = QueryProductRequest(category: '1');
    categories = CategoriesEntity(categoriesEntity: []);
  });
  setUp(() {
    categoriesViewModel = CategoriesViewModel(
      getAllCategoriesUseCase,
      getProductsCategoryUseCase,
    );
  });
  group('get all categories intent', () {
    blocTest(
      'when calling dointent with categories action with success it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<CategoriesEntity>>(
          SuccessResponse(data: categoriesEntity),
        );
        provideDummy<BaseResponse<ProductsEntity>>(
          SuccessResponse(data: productsEntity),
        );
        when(getAllCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: categoriesEntity));
        });
        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(SuccessResponse(data: productsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = CategoriesState(
          categoriesState: CategoryBaseState(),
          productsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categoriesEntity,
            ),
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categoriesEntity,
            ),
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categoriesEntity,
            ),
            productsCategoryState: BaseState(
              isLoading: false,
              success: productsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with categories action with success but empty list it should emit correct state',

      setUp: () {
        provideDummy<BaseResponse<CategoriesEntity>>(
          SuccessResponse(data: categories),
        );
        provideDummy<BaseResponse<ProductsEntity>>(
          SuccessResponse(data: productsEntity),
        );
        when(getAllCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: categories));
        });
        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(SuccessResponse(data: productsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = CategoriesState(
          categoriesState: CategoryBaseState(),
          productsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categories,
            ),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with categories action with error it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<CategoriesEntity>>(
          ErrorResponse(error: UnexpectedError()),
        );

        when(getAllCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(ErrorResponse(error: UnexpectedError()));
        });
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = CategoriesState(
          categoriesState: CategoryBaseState(),
          productsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              error: UnexpectedError(),
            ),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with categories action with success and error in get products it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<CategoriesEntity>>(
          SuccessResponse(data: categoriesEntity),
        );
        provideDummy<BaseResponse<ProductsEntity>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(getAllCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(SuccessResponse(data: categoriesEntity));
        });
        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(ErrorResponse(error: UnexpectedError()));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = CategoriesState(
          categoriesState: CategoryBaseState(),
          productsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categoriesEntity,
            ),
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categoriesEntity,
            ),
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              success: categoriesEntity,
            ),
            productsCategoryState: BaseState(
              isLoading: false,
              error: UnexpectedError(),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });
  group('get category intent', () {
    blocTest(
      'when calling dointent with get category with success in get products intent it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<ProductsEntity>>(
          SuccessResponse(data: productsEntity),
        );

        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(SuccessResponse(data: productsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(GetCategoryIntent(index: 0));
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(categoriesState: CategoryBaseState(index: 0)),
          state.copyWith(
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              success: productsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with get category with error in get products intent it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<ProductsEntity>>(
          ErrorResponse(error: UnexpectedError()),
        );

        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(ErrorResponse(error: UnexpectedError()));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(GetCategoryIntent(index: 0));
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(categoriesState: CategoryBaseState(index: 0)),
          state.copyWith(
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              error: UnexpectedError(),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });
  group('get products category intent', () {
    blocTest(
      'when calling dointent with get products category with success  it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<ProductsEntity>>(
          SuccessResponse(data: productsEntity),
        );
        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(SuccessResponse(data: productsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(
          GetProductsCategoryIntent(categoryId: '1'),
        );
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              success: productsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with get products category with error  it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<ProductsEntity>>(
          ErrorResponse(error: UnexpectedError()),
        );
        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(ErrorResponse(error: UnexpectedError()));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(
          GetProductsCategoryIntent(categoryId: '1'),
        );
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              error: UnexpectedError(),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });
  group('get sorted products  intent', () {
    blocTest(
      'when calling dointent with get sorted products with success in get products intent it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<ProductsEntity>>(
          SuccessResponse(data: productsEntity),
        );

        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(SuccessResponse(data: productsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(
          GetSortedProducts(sort: Sort.priceAsc, index: 1),
        );
      },
      expect: () {
        var state = categoriesViewModel.state;

        return [
          state.copyWith(
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              success: productsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );

    blocTest(
      'when calling dointent with get sorted products with error in get products intent it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<ProductsEntity>>(
          ErrorResponse(error: UnexpectedError()),
        );

        when(getProductsCategoryUseCase.invoke(queryProductRequest)).thenAnswer(
          (realInvocation) {
            return Future.value(ErrorResponse(error: UnexpectedError()));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(
          GetSortedProducts(sort: Sort.priceAsc, index: 1),
        );
      },
      expect: () {
        var state = categoriesViewModel.state;
        return [
          state.copyWith(
            productsCategoryState: BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            productsCategoryState: BaseState(
              isLoading: false,
              error: UnexpectedError(),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });
}
