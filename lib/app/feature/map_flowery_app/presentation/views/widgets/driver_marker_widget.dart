import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DriverMarkerWidget extends StatelessWidget {
  const DriverMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.blueColor,
        border: Border.all(color: AppColors.whiteColor,width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ]
      ),
      child: Icon(Icons.directions_car,color: AppColors.baseWhiteColor,size: 24,),
    );
  }
}