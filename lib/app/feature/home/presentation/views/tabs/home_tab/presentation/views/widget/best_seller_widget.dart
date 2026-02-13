import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/domain/models/best_seller_model.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_details_args.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class BestSellerWidget extends StatelessWidget {
  final List<BestSellerModel> bestSellers;
  const BestSellerWidget({super.key,required this.bestSellers});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 0.28*height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.productDetails,arguments:ProductDetailsArgs(productId: bestSellers[index].id!));
            },
            child: SizedBox(
              width: 0.35*width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 0.18*height,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(bestSellers[index].imgCover ?? ''),fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(height: 0.01*height,),
                  Text(bestSellers[index].title ?? '',style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: FontSize.s12,
                    color: AppColors.blackColor
                  ),),
                  Text('${bestSellers[index].price} ${AppLocalizations.of(context)!.egyptianLivre}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: FontSize.s14
                  ),)
                ],
              ),
            ),
          );
        }, 
        separatorBuilder: (context, index) {
          return SizedBox(width: 0.04*width,);
        }, 
        itemCount: bestSellers.length
      ),
    );
  }
}