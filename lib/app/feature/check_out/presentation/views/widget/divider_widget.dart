import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.sizeOf(context).height;
    return Container(
      width: double.infinity,
      height: 0.02*height,
      color: AppColors.dividerLightGrayColor,
    );
  }
}