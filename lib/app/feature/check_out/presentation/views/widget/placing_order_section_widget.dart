import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlacingOrderSectionWidget extends StatelessWidget {
  final double itemsPrice;
  final VoidCallback onTap;
  final double? fee;
  final bool isEnabled;
  const PlacingOrderSectionWidget({super.key,required this.itemsPrice,required this.onTap,this.fee=10,this.isEnabled=true});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02*height,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.subtotal,style: Theme.of(context).textTheme.labelLarge,),
              Text('$itemsPrice${AppLocalizations.of(context)!.egp}',style: Theme.of(context).textTheme.labelLarge,)
            ],
          ),
          SizedBox(height: 0.006*height,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.delivery_fee,style: Theme.of(context).textTheme.labelLarge,),
              Text('$fee${AppLocalizations.of(context)!.egp}',style: Theme.of(context).textTheme.labelLarge,)
            ],
          ),
          SizedBox(height: 0.01*height,),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.grayColor,
          ),
          SizedBox(height: 0.006*height,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.total,style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.blackColor,
                fontWeight: FontWeights.medium,
                fontSize: AppSize.s18
              ),),
              Text('${itemsPrice+(fee ?? 10)}${AppLocalizations.of(context)!.egp}',style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.blackColor,
                fontWeight: FontWeights.medium,
                fontSize: AppSize.s18
              ),)
            ],
          ),
          SizedBox(height: 0.04*height,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isEnabled ? onTap : null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  isEnabled 
                    ? AppColors.primaryColor 
                    : AppColors.grayColor    
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.h),
                ),
              ), 
              child: Text(AppLocalizations.of(context)!.place_order)
            ),
          ),
          SizedBox(height: 0.05*height,)
        ],
      ),
    );
  }
}