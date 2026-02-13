import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeliveryTimeSectionHeaderWidget extends StatelessWidget {
  const DeliveryTimeSectionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context)!.delivery_time,style: Theme.of(context).textTheme.headlineLarge,),
          Text(AppLocalizations.of(context)!.schedule,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeights.semiBold,
            color: AppColors.primaryColor,
          ))
        ],
      ),
    );
  }
}