import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/reusable_widgets/loading_widget.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/categories/presentation/view/widget/search_widget.dart';
import 'package:flower_app/app/feature/categories/presentation/view_model/categories_intent.dart';
import 'package:flower_app/app/feature/categories/presentation/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/reusable_widgets/custom_error_widget.dart';
import '../../../../../core/utils/app_locale.dart';
import '../../../../product_details/presentation/views/widget/product_cart_item.dart';
import '../../view_model/categories_state.dart';
import 'categories_item_widget.dart';

class CategoriesBodyWidget extends StatelessWidget {
  const CategoriesBodyWidget({
    super.key,
    required this.state,
    required this.categoriesViewModel,
  });

  final CategoriesState state;
  final CategoriesViewModel categoriesViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          SearchWidget(),
          const SizedBox(height: 18),
          state.categoriesState.isLoading == true
              ? LoadingWidget()
              : state.categoriesState.success != null
              ? state.categoriesState.success!.categoriesEntity!.isNotEmpty
                    ? DefaultTabController(
                  initialIndex: state.categoriesState.index,
                  length: state
                            .categoriesState
                            .success!
                            .categoriesEntity!
                            .length,
                        child: TabBar(
                    onTap: (value) {
                      categoriesViewModel.doIntent(
                        GetCategoryIntent(index: value),
                      );
                    },
                    padding: EdgeInsets.zero,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.primaryColor,
                    dividerColor: Colors.transparent,
                    labelPadding: EdgeInsets.zero,
                    tabs: state.categoriesState.success!.categoriesEntity!
                        .map(
                          (e) => CategoriesItemWidget(
                            itemName: e.title ?? '',
                            isSelected:
                                state.categoriesState.index ==
                                state.categoriesState.success!.categoriesEntity!
                                    .indexOf(e),
                          ),
                        )
                        .toList(),
                  ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        height: 48,
                        child: Text(
                          AppLocale(context).noCategoriesAvailable,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
              : state.categoriesState.error != null
              ? CustomErrorWidget(
                  errorMessage: getException(
                    context,
                    state.categoriesState.error,
                  ),
                  onRetry: () {
                    categoriesViewModel.doIntent(CategoriesAction());
                  },
                )
              : Container(),
          SizedBox(height: 8),
          state.productsCategoryState.isLoading == true
              ? LoadingWidget()
              : state.productsCategoryState.success != null
              ? state.productsCategoryState.success?.product != null &&
                        state.productsCategoryState.success!.product!.isEmpty
                    ? Container(
                        height: MediaQuery.sizeOf(context).height * .25,
                        child: ProductCartItem(productEntity: null),
                      )
                    : Expanded(
                        child: GridView.builder(
                          itemCount: state
                              .productsCategoryState
                              .success!
                              .product!
                              .length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 163 / 229,
                              ),
                          itemBuilder: (context, index) {
                            return ProductCartItem(
                              productEntity: state
                                  .productsCategoryState
                                  .success!
                                  .product![index],
                            );
                          },
                        ),
                      )
              : state.productsCategoryState.error != null
              ? CustomErrorWidget(
                  errorMessage: getException(
                    context,
                    state.productsCategoryState.error,
                  ),
                  onRetry: () {
                    categoriesViewModel.doIntent(
                      GetProductsCategoryIntent(
                        categoryId:
                            state
                                .categoriesState
                                .success
                                ?.categoriesEntity?[state.categoriesState.index]
                                .id ??
                            '',
                      ),
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
