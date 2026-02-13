import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryDateAndTimeEstimationWidget extends StatefulWidget {
  const DeliveryDateAndTimeEstimationWidget({super.key});

  @override
  State<DeliveryDateAndTimeEstimationWidget> createState() => _DeliveryDateAndTimeEstimationWidgetState();
}

class _DeliveryDateAndTimeEstimationWidgetState extends State<DeliveryDateAndTimeEstimationWidget> {
  DateTime now = DateTime.now();
  DateTime get futureTime => now.add(Duration(hours: 3));
  String get formattedDate => DateFormat('dd MMM yyyy').format(futureTime);
  String get formattedTime => DateFormat('hh:mm a').format(futureTime);
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Row(
        children: [
          Icon(Icons.access_time_outlined,color: AppColors.blackColor,),
          RichText(text: TextSpan(
            children: [
              TextSpan(
                text: '${AppLocalizations.of(context)!.instant},',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSize.s14)
              ),
              TextSpan(
                text: '${AppLocalizations.of(context)!.arrive_by} $formattedDate, $formattedTime',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.successColor,
                  fontSize: AppSize.s14
                )
              )
            ]
          ))
        ],
      ),
    );
  }
}