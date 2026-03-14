import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/occasion/data/models/product_model.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_products_events.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_products_states.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_products_view_model.dart';
import 'package:flower_app/app/feature/occasion/presentation/views/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OccasionTabWidget extends StatefulWidget {
  final String occasionId;

  const OccasionTabWidget({super.key, required this.occasionId});

  @override
  State<OccasionTabWidget> createState() => _OccasionTabWidgetState();
}

class _OccasionTabWidgetState extends State<OccasionTabWidget> {
  final _viewModel = getIt<OccasionProductsViewModel>();

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void didUpdateWidget(OccasionTabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.occasionId != widget.occasionId) {
      _fetch();
    }
  }

  void _fetch() {
    if (widget.occasionId.isEmpty) return;
    _viewModel.doIntent(GetProductsForOccasionEvent(widget.occasionId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: BlocBuilder<OccasionProductsViewModel, OccasionProductsStates>(
        builder: (context, state) {
          final productsState = state.productsState;

          if (productsState.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (productsState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productsState.error.toString(),
                    style: TextStyle(
                      fontFamily: FontsFamily.inter,
                      fontSize: FontSize.s14,
                      color: AppColors.errorColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSize.s16.h),
                  ElevatedButton(
                    onPressed: _fetch,
                    child: Text(AppLocale(context).retry),
                  ),
                ],
              ),
            );
          }

          final List<ProductModel> products = productsState.success ?? [];

          if (products.isEmpty) {
            return Center(
              child: Text(
                AppLocale(context).noProductsForOccasion,
                style: TextStyle(
                  fontFamily: FontsFamily.inter,
                  fontSize: FontSize.s14,
                  color: AppColors.grayColor,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16.w,
              vertical: AppPadding.p8.h,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSize.s12.w,
              mainAxisSpacing: AppSize.s16.h,
              childAspectRatio: 0.72,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCardWidget(
                productId: product.id,
                name: product.title,
                price: product.priceAfterDiscount.toInt(),
                oldPrice: product.price.toInt(),
                discount: product.discountPercentage,
                imageUrl: product.imgCover,
              );
            },
          );
        },
      ),
    );
  }
}
