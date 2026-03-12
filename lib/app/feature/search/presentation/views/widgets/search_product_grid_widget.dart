import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/feature/search/domain/models/search_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchProductGridWidget extends StatelessWidget {
  final List<SearchProductModel> products;

  const SearchProductGridWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductCard(product: products[index]);
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final SearchProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
            arguments: product.id
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.grayColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: product.imgCover,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.lightGrayColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.local_florist,
                      size: 40.sp,
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Discount badge
                        if (product.discountPercentage > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              '-${product.discountPercentage}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            if (product.discountPercentage > 0) ...[
                              Text(
                                'EGP ${product.price.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.grayColor,
                                    ),
                              ),
                              SizedBox(width: 4.w),
                            ],
                            Text(
                              'EGP ${product.priceAfterDiscount.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
