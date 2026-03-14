import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_events.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends StatelessWidget {
  final String name;
  final int price;
  final int oldPrice;
  final int discount;
  final String imageUrl;
  final String productId;

  const ProductCardWidget({
    super.key,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.w,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSize.s8.r),
        border: Border.all(
          color: const Color(0xFFA6A6A6).withValues(alpha: 0.7),
          width: 0.5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.s8.r),
            ),
            child: Container(
              height: 120.h,
              width: double.infinity,
              color: AppColors.secondaryColor,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.secondaryColor,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppColors.grayColor,
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(AppPadding.p8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: FontsFamily.inter,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeights.regular,
                    color: AppColors.blackColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppSize.s4.h),
                Row(
                  children: [
                    Text(
                      '${AppLocale(context).egp} $price',
                      style: TextStyle(
                        fontFamily: FontsFamily.inter,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeights.medium,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: AppSize.s8.w),
                    Text(
                      '$oldPrice',
                      style: TextStyle(
                        fontFamily: FontsFamily.inter,
                        fontSize: FontSize.s12,
                        fontWeight: FontWeights.regular,
                        color: AppColors.grayColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: AppSize.s8.w),
                    Text(
                      '$discount%',
                      style: TextStyle(
                        fontFamily: FontsFamily.inter,
                        fontSize: FontSize.s12,
                        fontWeight: FontWeights.medium,
                        color: AppColors.successColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSize.s8.h),
                Container(
                  width: double.infinity,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.read<OccasionViewModel>().doIntent(AddProductToCartEventOccasion(productId: productId, quantity: 1));
                      },
                      borderRadius: BorderRadius.circular(100.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 13.sp,
                              color: AppColors.whiteColor,
                            ),
                            SizedBox(width: AppSize.s8.w),
                            Flexible(
                              child: Text(
                                AppLocale(context).addToCart,
                                style: TextStyle(
                                  fontFamily: FontsFamily.inter,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeights.medium,
                                  color: AppColors.whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
