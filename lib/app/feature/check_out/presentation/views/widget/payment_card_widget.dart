import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/feature/check_out/domain/models/payment_method_model.dart';
import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final VoidCallback? onTap;
  final bool isSelected;
  const PaymentCardWidget({super.key,required this.paymentMethod,this.onTap,this.isSelected=false});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 0.04*width,vertical: 0.01*height),
      height: 0.05*height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.03*width),
        border: Border.all(width: 1,color: AppColors.lightGrayColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(paymentMethod.name??'',style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeights.regular),),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 0.05*width,
              height: 0.05*width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1,color: AppColors.primaryColor)
              ),
              child: Center(
                child: Container(
                  width: 0.03*width,
                  height: 0.03*width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:isSelected?AppColors.primaryColor:AppColors.transparentColor
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}